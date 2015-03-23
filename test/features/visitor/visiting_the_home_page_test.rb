require "test_helper"

feature "Visiting The HomePage" do
  scenario "Presented Sign up link" do
    visit root_path
    page.text.must_include "Sign up"
  end

  scenario "Visitor signs up" do
    visit root_path
    click_on "Sign up"

    fill_in "Email", with: "sample@example.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_on "Register"

    page.content.must_include "Welcome! You have been successfully registered."
    page.wont_have_content "There was a problem with your registration."
  end
end
