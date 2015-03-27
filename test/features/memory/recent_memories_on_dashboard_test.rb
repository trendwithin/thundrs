require "test_helper"

feature "As a user, I want to see memories that others have recently added" do
  scenario "recent memories are shown on the dashboard" do
    # given recent memories that don't belong to the current user
    memory = memories :user2_memory
    sign_in users(:user_1)

    # when the user visits their dashboard
    visit memories_path

    # then they should see those memories
    page.find("#recent_memories #memory-#{memory.id}.memory .memory-image").wont_be_nil
  end
end
