require "test_helper"

feature "As a user, I would like to comment on other user's memories" do
  before do
    # given a logged in user and a memory
    @user = users :user_1
    sign_in @user
    @memory = memories :user2_memory
    @comment = comments :new_comment
  end

  scenario "comment form shows on memories" do
    # when the user views a memory's detail page
    visit memory_path(@memory)

    # then a form and button for leaving a comment are visible
    page.find("#comment_body").wont_be_empty
    page.find("#save_comment_button").wont_be_empty
  end

  scenario "comments can be created" do
    # when a user submits the comment create form
    submit_comment_form(@comment)

    # then the user will see their unapproved comment show up
    page_must_include_comment(@comment)
    page.text.must_include "Pending approval"
  end
end
