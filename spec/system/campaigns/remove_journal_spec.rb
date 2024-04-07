require "rails_helper"

RSpec.describe "remove journal from campaign", type: :system do
  let!(:campaign) { create(:campaign, :with_owner_journal) }
  let(:user) { campaign.owner }
  let(:journal) { campaign.journals.first }

  before do
    sign_in user
  end

  scenario "valid input for owner" do
    visit campaign_path(campaign)

    click_link "edit-campaign-link"
    accept_alert do
      click_button "remove-journal_#{journal.id}-btn"
    end

    within "[data-testid='campaign-journals-list']" do
      expect(page).not_to have_content(journal.name)
    end
  end
end
