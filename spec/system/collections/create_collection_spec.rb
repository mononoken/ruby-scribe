require "rails_helper"

RSpec.describe "creating collections", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user has a journal and note but no collections" do
    let!(:user_journal) { create(:journal, author: user) }
    let!(:user_note) { create(:note, author: user, journal: user_journal) }

    it "shows new collection link on dashboard" do
      visit dashboard_path

      expect(page).to have_link(href: new_collection_path)
    end

    it "shows notes of user's selected journal after creating collection" do
      visit new_collection_path

      fill_in "collection-name-input", with: "New Collection"
      select user_journal.name, from: "journals-select"
      click_button "collection-save-btn"

      expect(page).to have_content(user_note.name)
    end
  end

  xcontext "when user has joined a collection" do
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
