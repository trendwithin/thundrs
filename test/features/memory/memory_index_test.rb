require "test_helper"

feature "As a user, I would like to have a personal landing page where I can view my memories" do
  scenario "memory index shows personal memories" do
    visit memories_path
    user = users :user1
    memory = memories :user1_memory

    page.text.must_include memory.name
    page.find("#memory#{memory.id} .memory-image")['src'].must_have_content memory.image_src
  end

  scenario "memory index doesn't show other's memories" do
    visit memories_path
    user = users :user1
    memory = memories :user2_memory

    page.text.wont_include memory.name
    assert_raise Capybara::ElementNotFound do
      page.find("#memory#{memory.id}")
    end
  end
end
