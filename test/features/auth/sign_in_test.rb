require "test_helper"

feature "User Sign In" do
  before do
    @user = users :user_1
    sign_in @user
  end

  scenario "Successful log in to site" do
    sign_in(users(:user_1))
    page.must_have_content "Signed in successfully"
    page.wont_have_content "Error"
  end

  scenario "Invalid data prevents user log in" do
    skip
    visit root_path
    click_on "Sign in"
    fill_in "Name", with: "Preakness"
    fill_in "Email", with: "One"
    click_on 'Log in'

    page.wont_have_content "Signed in successfully"
    page.must_have_content "Password can't be blank"
    page.must_have_content "Email is too short"
  end

  scenario "User Sign in with Twitter" do
    skip
    visit root_path
    click_on "Sign in with Twitter"

    page.must_have_content "Signed in successfully"
  end
end
