require "test_helper"

before :each do
  @user = users :user_1
  sign_in @user
end

feature "Visiting Anothers Profile" do
  scenario "Their profile populates and renders" do
    # (How to implement this? )visit profile_path
    click_on "View Profile" #think this through
    page.must_have_conent users(:user_2).name
  end

  scenario "Another user's page not found" do
  end

  scenario "View another user's images" do
    click_on "View Profile"
    #click on an image
  end

  scenario "Read another user's story" do
    #path to other user
    click_on "Story"
    page.must_have_conent sotries(:story_1).text
  end
end
