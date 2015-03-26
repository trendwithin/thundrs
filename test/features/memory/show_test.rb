require "test_helper"

feature "As a user, I would like to see the details of memories" do
  before do
    @user = users :user_1
    sign_in @user
  end

  scenario "users can click on memory images to see the detail page" do
    skip
    # given one of their own memories
    @memory = memories :user1_memory

    # when the user clicks on it in the index
    visit memories_path
    page.find("#memory-#{@memory.id}.memory .memory-image").click

    # then the user will be directed to the memory's detail page
    current_path.must_equal memory_path(@memory)
    page_must_include_memory(@memory)
  end

  scenario "users can view other user's memory details" do
    # given one of another user's memories
    @memory = memories :user2_memory

    # when the user visits the detail page
    visit memory_path(@memory)

    # then the user can see that memory
    page_must_include_memory(@memory)
  end
end
