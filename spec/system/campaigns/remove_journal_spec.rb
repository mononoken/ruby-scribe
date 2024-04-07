require "rails_helper"

RSpec.describe "remove journal from campaign", type: :system do
  let!(:campaign) { create(:campaign, :with_owner_journal) }
  let(:user) { campaign.owner }
  let(:journal) { campaign.journals.first }

  scenario "valid input for owner" do
    sign_in user
    visit campaign_path(campaign)

    click_link "edit-campaign-link"
    accept_alert do
      click_button "remove-journal_#{journal.id}-btn"
    end

    within "[data-testid='campaign-journals-list']" do
      expect(page).not_to have_content(journal.name)
    end
  end

  context "when other member joined campaign" do
    let!(:membership) { create(:membership, :with_journal, campaign:) }
    let(:member) { membership.member }
    let(:member_journal) { membership.journals.last }

    scenario "valid input for member" do
      sign_in member
      visit campaign_path(campaign)

      click_link "edit-campaign-link"
      accept_alert do
        click_button "remove-journal_#{member_journal.id}-btn"
      end

      within "[data-testid='campaign-journals-list']" do
        expect(page).not_to have_content(journal.name)
      end
    end

    scenario "member cannot remove others' journals" do
    end
  end
end
