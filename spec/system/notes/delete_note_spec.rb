require "rails_helper"

RSpec.describe "deleting notes", type: :system do
  let!(:user) { create(:user) }

  context "when user with one journal and one note is signed at notes index" do
    let!(:journal) { create(:journal, author: user) }
    let!(:existing_note) { create(:note, journal: journal) }

    before do
      sign_in user
      visit journal_notes_path(journal)
    end

    it "has current page path as journal's notes index" do
      accept_alert do
        click_button "note-delete-btn"
      end

      expect(page).to have_current_path(journal_notes_path(journal))
    end

    it "does not show deleted note after destroying note" do
      accept_alert do
        click_button "note-delete-btn"
      end

      expect(page).not_to have_content(existing_note.body)
    end

    it "shows flash notifying successful note deletion" do
      delete_notification = "Note successfully deleted."

      accept_alert do
        click_button "note-delete-btn"
      end

      within "div[data-testid='flash-msg']" do
        expect(page).to have_content(delete_notification)
      end
    end
  end
end
