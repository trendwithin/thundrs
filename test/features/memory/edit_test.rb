require "test_helper"

feature "As a user, I want to edit the details of my memories" do
  before do
    @user = users :user1
    sign_in user
  end

  scenario "users can see an edit link on their own memories" do
    # given one of their own memories
    memory = memories :user1_memory

    # when a user visits that memory's detail page
    visit memory_path(memory)

    # then an edit button is visible, and it leads to an edit form
    page.find("#edit-button").click
    current_path.must_equal edit_memory_path(memory)
  end

  scenario "users cannot see an edit link on other's memories" do
    # given another user's memory
    memory = memories :user2_memory

    # when a user visits that memory's detail page
    visit memory_path(memory)

    # there will not be an edit button
    assert_raise Capybara::ElementNotFound do
      page.find "#edit-button"
    end
  end

  scenario "users cannot directly visit the edit form of other's memories" do
    # given another user's memory
    memory = memories :user2_memory

    # when a user goes to the edit path
    visit edit_memory_path(memory)

    # the user will be redirected
    current_path.wont_equal edit_memory_path(memory)
    page.text.must_include "you cannot edit"
  end

  scenario "memory details can be changed" do
    # given their own memory
    memory = memories :user1_memory

    # when a user changes that memory on the edit form
    visit edit_memory_path(memory)
    memory.name = "Edited memory"
    memory.keywords += " edit revise change"
    memory.description = "This memory has been edited"
    submit_memory_form(memory)

    # then the memory details will be different on the detail view
    visit memory_path(memory)
    memory.name.must_equal memory.name
    memory.keywords.must_equal memory.keywords
    memory.description.must_equal memory.description
  end
end
