require "test_helper"

feature "As a user, I want to click on keywords to see memories associated with them" do
  scenario "keywords have a show template with memories" do
    keyword = keywords :k1
    sign_in users(:user_1)

    visit keyword_path(keyword)

    page.find("#memory-#{memories(:user1_memory).id}").wont_be_nil
    page.find("#memory-#{memories(:user2_memory).id}").wont_be_nil
  end
end
