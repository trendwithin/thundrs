require "test_helper"

feature "User Sign In" do
  scenario "Successful log in to site" do
    visit root_path
    click_on "Sign in"

    fill_in "Email", with: users(:user_1).email
    fill_in "Password", with: (:user_1).password
    click_on 'Log in'

    page.must_have_content "Signed in successfully"
    page.wont_have_content "Error"
  end

  scenario "Invalid data prevents user log in" do
    visit root_path
    click_on "Sign in"
    fill_in "Email", with: "One"
    click_on 'Log in'

    page.wont_have_content "Signed in successfully"
    page.must_have_content "Password can't be blank"
    page.must_have_content "Email is too short"
  end

  scenario "User Sign in with Twitter" do
    visit root_path
    click_on "Sign in with Twitter"

    page.must_have_content "Signed in successfully"
end
