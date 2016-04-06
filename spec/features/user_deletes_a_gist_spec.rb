require 'rails_helper'

RSpec.feature "user deletes a gist" do
  scenario "user deletes a gist" do
    VCR.use_cassette("gists.delete_feature") do
      stub_omniauth
      visit "/"
      click_link "Sign in with Github"
      click_link "Gists"
      click_link "Create a New Gist"
      fill_in "Description", with: "description"
      fill_in "Title", with: "this_new_gist_title"
      fill_in "Contents", with: "contents"
      click_on "Create New Public Gist"
      click_on("this_new_gist_title")
      click_on("Delete this Gist")
      expect(page).to_not have_content("this_new_gist_title")
    end
  end
end
