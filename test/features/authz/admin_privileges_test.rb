require "test_helper"

feature "As an administrator, I want to delete content from the site, so that I can remove inappropriate content" do
  scenario "admins can delete memories" do
    # given a memory
    memory = memories :user1_memory

    # when an admin views the memory detail page
    sign_in users(:adminuser)
    visit memory_path(memory)

    # then she should be able to delete the memory
    page.find("#delete-button").click

    # and then the memory should no longer exist
    visit memory_path(memory)
    current_path.must_equal memories_path # TODO: not sure if this will redirect properly or just throw a 404?
    page_wont_include_memory memory
  end

  scenario "admins can delete comments" do
    # given a memory with comments and a specific comment
    comment = comments :unapproved_comment
    memory = comment.memory

    # when an admin sees the memory detail page
    sign_in users(:adminuser)
    visit memory_path(memory)

    # then she should be able to delete a comment
    page.find("#comment-#{comment.id} .delete-button").click

    # and then the comment should no longer be there
    page_wont_include_comment comment
  end

  scenario "non-admins cannot delete memories" do
    # given a memory from another user
    memory = memories :user2_memory

    # when a normal user visits the memory detail page
    sign_in users(:user_1)
    visit memory_path(memory)

    # then there will not be a delete button
    assert_raise Capybara::ElementNotFound do
      page.find("#memory .delete-button")
    end
  end

  scenario "non-admins cannot delete comments" do
    # given a comment and it's associated memory
    comment = comments :approved_comment
    memory = comment.memory

    # when a normal user visits the memory detail page
    sign_in users(:user_1)
    visit memory_path(memory)

    # then there will not be a delete button
    assert_raise Capybara::ElementNotFound do
      page.find("#comment-#{comment.id} .delete-button")
    end
  end
end
