require "rails_helper"

RSpec.describe "creating campaigns", type: :system do
  context "when user is creating their first campaign" do
    let(:user) { create(:user) }
    let(:campaign) { create(:campaign) }

    before do
      sign_in user
    end

    fit "shows the new campaign title in the campaign index" do
      visit new_campaign_path
      click_button "Create"

      expect(page).within("li").to have_text(campaign.title)
    end
  end
end
