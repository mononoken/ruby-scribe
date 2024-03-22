require "rails_helper"

RSpec.describe "creating campaigns", type: :system do
  let!(:user) { create(:user) }
  let!(:user_journal) { create(:journal, author: user) }
  let!(:user_note) { create(:note, author: user, journal: user_journal) }

  before do
    sign_in user
  end

  context "when user has a journal and note but no campaigns" do
    it "shows new campaign link on dashboard" do
      visit dashboard_path

      expect(page).to have_link(href: new_campaign_path)
    end
  end

  context "when user creates a campaign" do
    before do
      visit new_campaign_path

      fill_in "campaign-name-input", with: "New Campaign"
      select user_journal.name, from: "journals-select"
      click_button "campaign-save-btn"
    end

    it "shows notes of user's selected journal after creating campaign" do
      expect(page).to have_content(user_note.name)
    end

    it "shows owner (user) as a member of the campaign" do
      within "[data-testid='members-list']" do
        expect(page).to have_content(user.username)
      end
    end
  end
end
