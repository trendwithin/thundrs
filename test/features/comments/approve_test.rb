require "test_helper"

feature "As a user, I want to be able to moderate comments on my memories" do
  scenario "unapproved comments show up on the dashboard" do
    # given a specific user and an unapproved comment
    user = users :user_1
    sign_in(user)
    comment = comments :unapproved_comment

    # when the user looks at their dashboard page
    visit memories_path
    # then the comment will be displayed
    page_must_include_comment comment
  end

  scenario "a memory owner's comments on their own memories don't need to be approved" do
    # given a user and their own memory
    user = users :user_1
    sign_in user
    memory = memories :user1_memory
    comment = comments :new_comment

    # when they comment on their own memory
    visit memory_path(memory)
    submit_comment_form(comment)
    # then it should be visible to everyone right away
    page.text.wont_include "Pending approval"
    switch_signed_in_user users(:user_2)
    visit memory_path(memory)
    page_must_include_comment(comment)
  end

  scenario "unapproved comments are only visible to the memory creator" do
    # given a user and an unapproved comment they shouldn't be able to see
    user = users :user_3
    sign_in user
    comment = comments :unapproved_comment

    # when the user views the memory the comment is on
    visit memory_path(comment.memory)
    # then the comment will not be visible
    page_wont_include_comment(comment)
  end

  scenario "comments can be approved from the dashboard" do
    # given a specific user and an unapproved comment
    user = users :user_1
    sign_in user
    comment = comments :unapproved_comment

    # when the user clicks the approve button on the dashboard
    visit memories_path
    click_button 'Accept'

    # then the comment will no longer be shown on the dashboard
    visit memories_path
    page_wont_include_comment(comment)

    # and then the comment will be shown to other users
    switch_signed_in_user users(:user_2)
    save_and_open_page
    visit memory_path(comment.memory)
    page_must_include_comment(comment)
  end

  scenario "comments can be declined from the dashboard" do
    # given a specific user and an unapproved comment
    user = users :user_1
    sign_in user
    comment = comments :unapproved_comment

    # when the user clicks the decline button on the dashboard
    visit memories_path
    click_button 'Delete'

    # then the comment will disappear forever
    visit memories_path
    page_wont_include_comment(comment)
  end
end
