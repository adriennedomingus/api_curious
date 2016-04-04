require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "user logs in" do
    stub_omniauth
    visit "/"
    click_link "Sign in with Github"
    expect(current_path).to eq("/")
    expect(page).to have_content("Adrienne")
    expect(page).to have_content("Logout")
    expect(page).to_not have_content("Sign in with Github")
 end
end
