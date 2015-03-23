require "test_helper"

before :each do
  @user = users :user_1
  sign_in @user
end

feature "Creating My Own Story" do
  scenario "User adds a personal story" do
    click_on "Add Memory"
    fill_in "Story", with: stories(:story_1).text
    click_on "Share Story"
    page.text.musth_include "Story successfully created"
    page.text.must_include stories(:story_1).text
  end

  scenario "Creaed story is not blank" do
    visit #user_session_path?
    click_on "Add Memory"
    click_on "Share Story"
    page.text.must_include "Story can't be empty"
  end
end
