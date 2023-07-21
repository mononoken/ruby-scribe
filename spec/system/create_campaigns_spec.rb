require "rails_helper"

RSpec.describe "creating campaigns", type: :system do
  context "when user is creating their first campaign" do
    let(:user) { create(:user) }
    let(:campaign) { create(:campaign) } # How to create campaign factory with given user?

    before do
      sign_in user
    end

    fit "shows the new campaign title in the campaign index" do
      visit new_campaign_path
      fill_in "Name", with: "Test Campaign"
      click_button "Create"

      expect(page).to have_text(campaign.title)
    end
  end
end
