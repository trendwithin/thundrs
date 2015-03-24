require "test_helper"

feature "As a user, I would like to create memories with photos, keywords, and descriptions" do
  before do
    @user = users :user_1
    sign_in @user

    @memory = memories :new_memory
  end

  scenario "the memory index has a link to a new memory form" do
    # when visiting the memory index
    visit memories_path
    # then a link to the create form should exist
    click_link 'New Memory'
    current_path.must_equal new_memory_path
  end

  scenario "memories can be created from the new memory form" do
    visit new_memory_path
    # when the new memory form is submitted
    submit_memory_form(@memory)
    # then the user should be shown the created memory
    page_must_include_memory(@memory)
  end

  scenario "memories cannot be created without a name" do
    # given a memory with a blank name
    @memory.name = ""

    # when submitting the create form
    visit new_memory_path
    submit_memory_form(@memory)

    # then the form should remain and an error should be displayed
    page.text.must_include "prohibited this memory from being saved:"
    page.text.must_include "Name can't be blank"
  end

  scenario "memories cannot be created without at least one keyword" do
    # given a memory without any keywords
    @memory.keywords = ""

    # when submitting the create form
    visit new_memory_path
    submit_memory_form(@memory)

    # then the form should remain and an error should be displayed
    page.text.must_include "Keywords can't be blank"
  end

  scenario "memories cannot be created without a description" do
    # given memory information without a description
    @memory.description = ""

    # when submitting the create form
    visit new_memory_path
    submit_memory_form(@memory)

    # then the form should remain and an error should be displayed
    page.text.must_include "Description can't be blank"
  end

  scenario "new memories are added to the user's memory index" do
    # when the new memory form is submitted
    visit new_memory_path
    save_and_open_page
    submit_memory_form(@memory)

    # then the memory should be on the memory index page
    visit memories_path
    save_and_open_page
    page_must_include_memory(@memory)
  end
end
