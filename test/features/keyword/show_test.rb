require "test_helper"

feature "As a user, I want to click on keywords to see memories associated with them" do
  scenario "keywords have a show template with memories" do
    keyword = keywords :k1

    visit keyword_path(keyword)

    page_must_include_memory memories(:user1_memory)
    page_must_include_memory memories(:user2_memory)
  end
end
