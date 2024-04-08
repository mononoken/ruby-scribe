require "rails_helper"

RSpec.describe "remove journal from campaign", type: :system do
  let!(:campaign) { create(:campaign, :with_owner_journal) }
  let(:user) { campaign.owner }
  let(:owner_journal) { campaign.journals.first }

  scenario "valid input for owner" do
    sign_in user
    visit campaign_path(campaign)

    click_link "edit-campaign-link"
    accept_alert do
      click_button "remove-journal_#{owner_journal.id}-btn"
    end

    within "[data-testid='campaign-journals-list']" do
      expect(page).not_to have_content(owner_journal.name)
    end
  end

  context "when other member joined campaign" do
    let!(:membership) { create(:membership, :with_journal, campaign:) }
    let(:member) { membership.member }
    let(:member_journal) { membership.journals.last }

    scenario "member can remove own journals from campaign" do
      sign_in member
      visit campaign_path(campaign)

      click_link "edit-campaign-link"
      accept_alert do
        click_button "remove-journal_#{member_journal.id}-btn"
      end

      within "[data-testid='campaign-journals-list']" do
        expect(page).not_to have_content(member_journal.name)
      end
    end

    scenario "member cannot remove others' journals" do
      sign_in member
      visit campaign_path(campaign)

      click_link "edit-campaign-link"
      accept_alert do
        click_button "remove-journal_#{owner_journal.id}-btn"
      end

      within "[data-testid='campaign-journals-list']" do
        expect(page).to have_content(owner_journal.name)
      end
    end
  end
end
