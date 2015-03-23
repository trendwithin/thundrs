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

  def submit_memory_form(memory_data)
    visit new_memory_path
    fill_in "Name", with: memory_data.name
    fill_in "Keywords", with: memory_data.keywords
    fill_in "Description", with: memory_data.description
    # TODO: test image upload?
    page.find('#create-button').click
  end

  def page_must_include_memory(memory_data)
    memory = Memory.find_by_name(memory_data.name)
    page.text.must_include memory_data.name
    page.text.must_include memory_data.keywords
    page.text.must_include memory_data.description
    # TODO: this is going to throw ambiguous selector errors:
    page.find("#memory .memory-image")['src'].must_have_content memory.image_src
    # will need to find a way to loop through the images and make sure one of them is the one we are looking for
  end

  def page_wont_include_memory(memory_data)
    memory = Memory.find_by_name(memory_data.name)
    page.text.wont_include memory_data.name
    page.text.wont_include memory_data.keywords
    page.text.wont_include memory_data.description
    assert_raise Capybara::ElementNotFound do
      page.find("#memory .memory-image[src=#{memory_data.image_src}]")
    end
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Assertions
end
