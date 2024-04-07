require "rails_helper"

RSpec.describe "destroy campaign", type: :system do
  let!(:campaign) { create(:campaign) }
  let(:user) { campaign.owner }

  before do
    sign_in user
  end

  scenario "valid input" do
    visit campaign_path(campaign)

    click_link "edit-campaign-link"
    accept_alert do
      click_button "destroy-campaign-btn"
    end

    within "[data-testid='campaigns-list']" do
      expect(page).not_to have_content(campaign.name)
    end
  end
end
