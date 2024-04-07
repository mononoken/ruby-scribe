require "rails_helper"

RSpec.describe "showing campaigns", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user owns the visited campaign" do
    let!(:campaign) { create(:campaign, :with_owner_journal, owner: user) }
    let!(:note) { create(:note, journal: campaign.journals[0]) }

    before do
      visit campaign_path(campaign)
    end

    it "shows notes of user's joined journal in campaign" do
      expect(page).to have_content(note.name)
    end
  end

  context "when user does not own the visited campaign" do
    let!(:other_user) { create(:user) }
    let!(:campaign) { create(:campaign, owner: other_user) }
    let!(:others_journal) { create(:journal_with_notes, author: other_user) }
    let!(:others_membership_journal) { create(:membership_journal, membership: campaign.memberships.first, journal: others_journal) }

    context "when user has a membership to the campaign" do
      let!(:users_journal) { create(:journal_with_notes, author: user) }
      let!(:users_membership) { create(:membership, campaign:, member: user) }
      let!(:users_membership_journal) { create(:membership_journal, membership: users_membership, journal: users_journal) }

      before do
        visit campaign_path(campaign)
      end

      it "shows notes of user's joined journal in campaign" do
        users_note = users_journal.notes.first

        expect(page).to have_content(users_note.name)
      end

      it "shows notes of other user's joined journal in campaign" do
        others_note = others_journal.notes.first

        expect(page).to have_content(others_note.name)
      end
    end
  end
end
