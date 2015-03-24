require "test_helper"

feature "User Signs Out" do
  scenario "User informed of log out" do
    sign_in(users(:user_1))
    click_on "Logout"
    page.must_have_content "Signed out successfully"
  end
end
