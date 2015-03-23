require "test_helper"

feature "As a user, I would like to create memories with photos, keywords, and descriptions" do
  scenario "the memory index has a link to a new memory form" do
    # given a signed in user
    user = users :user1
    sign_in user

    # when visiting the memory index
    visit memories_path

    # then a link to the create form should exist
    page.find('#create-memory-button').click
    current_path.must_equal new_memory_path
  end

  scenario "memories can be created from the new memory form" do
    # given a signed in user
    user = users :user1
    sign_in user

    # and given data for a memory
    memory_data = memories :new_memory

    # when the new memory form is submitted
    submit_memory_form(memory_data)

    # then the user should be shown the created memory
    current_path.must_equal memory_path(memory)
    page_must_include_memory(memory_data)
  end

  scenario "memories cannot be created without a name" do
    # given a signed in user
    user = users :user1
    sign_in user

    # and given memory information without a name
    memory_data = memories :new_memory
    memory_data.name = ""

    # when submitting the create form
    submit_memory_form(memory_data)

    # then the form should remain and an error should be displayed
    current_path.must_equal new_memory_path
    page.text.must_include "could not be saved"
    page.text.must_include "Name is a required field"
  end
end
