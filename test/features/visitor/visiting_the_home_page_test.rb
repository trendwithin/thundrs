require "test_helper"

feature "Visiting The HomePage" do
  scenario "Presented with header Thundrs" do
    visit root_path
    page.text.must_include "Thundrs"
  end

  scenario "Visitor signs up for account" do
    visit root_path
    click_on "Sign up"

    fill_in "Username", with: "Maude"
    fill_in "Email", with: "then@theres.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    page.text.must_include "You have signed up successfully"
    page.wont_have_content "There was a problem with your registration."
  end

  scenario "Visitor incorrectly fills in form" do
    visit root_path
    click_on "Sign up"
    fill_in "Email", with: "EMD"
    click_button "Sign up"

    page.text.must_include "Email is invalid"
    page.text.must_include "Password can't be blank"
  end

  scenario "Visitor Email must not be too long" do
    users(:user_1).email.length < ("a" * 244 + "@example.com").length
  end

  scenario "Visitor Email must be unique" do
    visit root_path
    click_on "Sign up"
    fill_in "Username", with: "name"
    fill_in "Email", with: users(:user_1).email
    fill_in "Password", with: "password"
    click_button "Sign up"

    page.text.must_include "Email has already been taken"
  end

  scenario "Visitor Email must be valid" do
    visit root_path
    click_on "Sign up"
    fill_in "Username", with: "name"
    fill_in "Email", with: "abc@.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    page.text.must_include "Email is invalid"
  end

  scenario "Vistor Password Confirmation Doesn't Match" do
    visit root_path
    click_on "Sign up"
    fill_in "Username", with: "name"
    fill_in "Email", with: "abc@xyz.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "word"
    click_button "Sign up"

    page.text.must_include "Password confirmation"
  end

  scenario "Visitor Username must be unique" do
    visit root_path
    click_on "Sign up"
    fill_in "Username", with: users(:user_1).username
    fill_in "Email", with: "test_test@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    page.text.must_include ""
  end

  scenario "Visitor Name must not be too long" do
    users(:user_1).username.length < ("a" * 50).length
  end

  scenario "Vistor Sign up through Twitter" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:twitter,
                            {
                            uid: '12345',
                            info: { nickname: 'test_twitter_user' },
                            })
    visit root_path
    Capybara.current_session.driver.request.env['devise.mapping'] = Devise.mappings[:user]
    Capybara.current_session.driver.request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]

    click_on "Sign up with Twitter"
    page.must_have_content "Logged in as test_twitter_user"
  end
end
