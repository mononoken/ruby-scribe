require "rails_helper"

RSpec.describe "sharing notes", type: :system do
  let!(:user) { create(:user) }

  context "when user creates a shared journal" do
    let!(:user_journal) { create(:journal, author: user) }
    let!(:user_note) { create(:note, journal: user_journal, author: user) }

    before do
      sign_in user
      visit dashboard_path
      click_link "new-shared-journal-link"
      select journal.name, from: "journals-select"
      click_button "invite-user-btn"
      select other_user.name, from: "invites-select"
      click_button "save-shared-journal-btn"
    end

    fit "shows notes of user's journal in the shared journal" do
      expect(page).to have_content(user_note.name)
    end

    context "when other user joins the shared journal" do
      let!(:other_user) { create(:user) }
      let!(:other_journal) { create(:journal, author: other_user) }
      let!(:other_note) { create(:note, journal: other_journal, author: other_user) }

      before do
        sign_in other_user
        # visit notifications_path
        visit dashboard_path
        within "notifications-list" do
          click_button "accept-shared-journal-btn"
        end
      end

      it "shows notes of other's in the shared journal" do
        click_link "shared-journal-link"
        expect(page).to have_content(other_note.name)
      end
    end
  end

  xcontext "when user has joined a shared journal" do
    # let!(:user_journal) { create(:journal, author: user) }
    #
    # let!(:other_user1) { create(:user) }
    # let!(:other_user2) { create(:user) }
    let!(:party_journal) { create(:party_journal) }

    before do
      visit journal_path(user_journal)
    end

    it "shows user's notes from their joined journal"
    it "shows notes of the other journal party members"
    it "does not show other's private notes"
    it "does show user's own private notes"
  end
end
