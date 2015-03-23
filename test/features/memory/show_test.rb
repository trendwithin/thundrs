require "test_helper"

feature "As a user, I would like to see the details of memories" do
  before do
    @user = users :user1
    sign_in user
  end

  scenario "users can click on memory images to see the detail page" do
    # given a specific memory
    @memory = memories :user1_memory

    # when it is clicked on in the index
    visit memories_path
    page.find("#memory .memory-image[src=#{memory_data.image_src}]").click

    # then the user will be directed to the memory's detail page
    current_path.must_equal memory_path(@memory)
  end
end
