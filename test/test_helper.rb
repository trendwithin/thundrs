ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"
require "minitest/rails/capybara"
require "minitest/pride"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  fixtures :all

  def sign_in(user = nil)
    visit new_user_session_path
    email = user ? user.email : users(:users_1).email
    password = "password"
    fill_in "Email", with: email
    fill_in "Password", with: password
    page.find('#signin-button').click
  end

  def sign_out
    visit root_path
    page.find("#signout-button").click
  end

  def switch_signed_in_user(user = nil)
    sign_out
    sign_in user
  end

  def submit_memory_form(memory_data)
    fill_in "Name", with: memory_data.name
    fill_in "Keywords", with: memory_data.keywords
    fill_in "Description", with: memory_data.description
    # TODO: test image upload?
    page.find('#create-button').click
  end

  def page_must_include_memory(memory_data)
    page.text.must_include memory_data.name
    page.text.must_include memory_data.keywords
    page.text.must_include memory_data.description
    # TODO: this next test is a little weird. If it's nil, it will actually raise an error, but not sure
    #       how best to check for that
    page.find("#memory .memory-image[src=#{memory_data.image_src}]").wont_be_nil
  end

  def page_wont_include_memory(memory_data)
    page.text.wont_include memory_data.name
    page.text.wont_include memory_data.keywords
    page.text.wont_include memory_data.description
    assert_raise Capybara::ElementNotFound do
      page.find("#memory .memory-image[src=#{memory_data.image_src}]")
    end
  end

  def submit_comment_form(comment_data)
    fill_in "#comment_body", with: @comment.body
    page.find("#save_comment_button").click
  end

  def page_must_include_comment(comment_data)
    page.text.must_include comment_data.body
    page.text.must_include comment_data.author.username
  end

  def page_wont_include_comment(comment_data)
    page.text.must_include comment_data.body
    page.text.must_include comment_data.author.username
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Assertions
end
