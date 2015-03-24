require "test_helper"

feature "As a user, I would like to have a personal landing page where I can view my memories" do
  before do
    user = users :user_1
    sign_in user
  end

  scenario "memory index shows personal memories" do
    # given a user's own memory
    memory = memories :user1_memory

    # when the user views their memory list
    visit memories_path

    # then the memory should be displayed
    page.text.must_include memory.name
    # page.find("#memory#{memory.id} .memory-image")['src'].must_have_content memory.image_src
  end

  scenario "memory index doesn't show other's memories" do
    # given some other user's memory
    memory = memories :user2_memory

    # when the user views their memory list
    visit memories_path

    # then the memory should not be displayed
    page.text.wont_include memory.name
    assert_raise Capybara::ElementNotFound do
      page.find("#memory#{memory.id}")
    end
  end
end
