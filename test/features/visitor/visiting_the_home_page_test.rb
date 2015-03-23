require "test_helper"

feature "Visiting The HomePage" do
  scenario "Presented with header Thundrs" do
    visit root_path
    page.text.must_include "Thundrs!"
  end

  scenario "Visitor signs up for account" do
    visit root_path
    click_on "Sign up"

    fill_in "Name", with: visitors(:visitor_1).name
    fill_in "Email", with: visitors(:visitor_1).email
    fill_in "Password", with: visitors(:visitor_1).password
    fill_in "Password Confirmation", with: visitors(:visitor_1).password
    click_on "Register"

    page.content.must_include "Welcome! You have been successfully registered."
    page.wont_have_content "There was a problem with your registration."
  end

  scenario "Visitor incorrectly fills in form" do
    visit root_path
    click_on "Sign up"
    fill_in "Email", with: "EMD"
    click_on "Register"

    page.text.must_include "Invalid Email"
    page.text.must_include "Password can't be blank"
  end

  scenario "Visitor Email must be unique" do
    skip
  end

  scenario "Visitor Name must be unique" do
    skip
  end

  scenario "Vistor Sign up through Twitter" do
    skip
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:twitter,
                            {
                            uid: '12345',
                            info: { nickname: 'test_twitter_user'},
                            })
    visit root_path
    Capybara.current_session.driver.request.env['devise.mapping'] = Devise.mappings[:user]
    Capybara.current_session.driver.request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]

    click_on "Sign up with Twitter"
    page.must_have_content "Logged in as test_twitter_user"
  end

  scenario "Visitor unable to Sign up through Twitter" do
    skip
    visit root_path
    click_on "Sign in with Twitter"
    page.wont_have_content "Logged in as"
  end

end
