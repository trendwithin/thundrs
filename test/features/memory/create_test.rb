require "test_helper"

feature "As a user, I would like to create memories with photos, keywords, and descriptions" do
  before do
    @user = users :user1
    sign_in @user

    @memory = memories :new_memory
  end

  scenario "the memory index has a link to a new memory form" do
    # when visiting the memory index
    visit memories_path

    # then a link to the create form should exist
    page.find('#create-memory-button').click
    current_path.must_equal new_memory_path
  end

  scenario "memories can be created from the new memory form" do
    # when the new memory form is submitted
    submit_memory_form(@memory)

    # then the user should be shown the created memory
    current_path.must_equal memory_path(memory)
    page_must_include_memory(@memory)
  end

  scenario "memories cannot be created without a name" do
    # given a memory with a blank name
    @memory.name = ""

    # when submitting the create form
    submit_memory_form(@memory)

    # then the form should remain and an error should be displayed
    current_path.must_equal new_memory_path
    page.text.must_include "could not be saved"
    page.text.must_include "Name is a required field"
  end

  scenario "memories cannot be created without at least one keyword" do
    # given a memory without any keywords
    @memory.keywords = ""

    # when submitting the create form
    submit_memory_form(@memory)

    # then the form should remain and an error should be displayed
    current_path.must_equal new_memory_path
    page.text.must_include "could not be saved"
    page.text.must_include "at least one keyword"
  end

  scenario "memories cannot be created without a description" do
    # given memory information without a description
    @memory.description = ""

    # when submitting the create form
    submit_memory_form(@memory)

    # then the form should remain and an error should be displayed
    current_path.must_equal new_memory_path
    page.text.must_include "could not be saved"
    page.text.must_include "must have a description"
  end

  scenario "new memories are added to the user's memory index" do
    # when the new memory form is submitted
    submit_memory_form(@memory)

    # then the memory should be on the memory index page
    visit memories_path
    page_must_include_memory(@memory)
  end
end
