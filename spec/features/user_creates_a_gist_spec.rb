require 'rails_helper'

RSpec.feature "user creates a gist" do
  scenario "user creates a gist" do
    VCR.use_cassette("gists.create_feature") do
      stub_omniauth
      visit "/"
      click_link "Sign in with Github"
      click_link "Gists"
      click_link "Create a New Gist"
      fill_in "Description", with: "description"
      fill_in "Title", with: "new_gist_title"
      fill_in "Contents", with: "contents"
      click_on "Create New Public Gist"
      expect(page).to have_content("new_gist_title")
    end
  end
end
