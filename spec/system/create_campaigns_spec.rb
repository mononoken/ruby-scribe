require "rails_helper"

RSpec.describe "creating campaigns", type: :system do
  context "when user is creating their first campaign" do
    let(:campaign) { create(:campaign) }

    before do
      sign_in campaign.user
    end

    fit "shows the new campaign title in the campaign index" do
      visit root_path
      fill_in "Name", with: campaign.name
      click_button "Create"

      expect(page).to have_text(campaign.name)
    end
  end
end
