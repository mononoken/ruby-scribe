require "rails_helper"

RSpec.describe "creating collections", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user owns the visited collection" do
    let!(:journals) { [create(:journal, author: user)] }
    let!(:note) { create(:note, author: user, journal: journals.first) }
    let!(:collection) {
      collection_with_journals(journals: journals, owner: user)
    }

    before do
      visit collection_path(collection)
    end

    it "shows notes of user's joined journal in collection" do
      expect(page).to have_content(note.name)
    end
  end

  context "when user does not own the visited collection" do
    let!(:other_user) { create(:user) }
    let!(:others_journal) { create(:journal, author: other_user) }
    let!(:others_note) {
      create(:note, author: other_user,
        journal: others_journal)
    }

    context "when user has a membership to the collection" do
      let!(:users_journal) { create(:journal, author: user) }
      let!(:users_note) { create(:note, author: user, journal: users_journal) }
      let!(:journals) {
        [users_journal, others_journal]
      }
      let!(:collection) {
        collection_with_journals(journals: journals, owner: other_user)
      }

      before do
        visit collection_path(collection)
      end

      it "shows notes of user's joined journal in collection" do
        expect(page).to have_content(users_note.name)
      end

      it "shows notes of other user's joined journal in collection" do
        expect(page).to have_content(others_note.name)
      end
    end
  end
end
