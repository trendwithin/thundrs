require "test_helper"

feature "User Signs Out" do
  scenario "User informed of log out" do
    #visit user_sign_in
    visit root_path
    click_on 'Login'

    fill_in "Email", with: users(:user_1).email
    fill_in "Password", with: "password"
    click_button "Log in"
    click_on "Logout"
    page.wont_have_content "Signed out successfully"
  end
end
