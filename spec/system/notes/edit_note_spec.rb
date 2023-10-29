require "rails_helper"

RSpec.describe "editing notes", type: :system do
  let!(:user) { create(:user) }

  context "when user is viewing journal notes" do
    let!(:journal) { create(:journal, author: user) }
    let!(:note) { create(:note, journal: journal, author: user) }

    before do
      sign_in user
      visit journal_notes_path(journal)
    end

    it "navigates to edit page of note when clicking edit button" do
      click_link "note-edit-link"

      expect(page).to have_current_path(edit_note_path(note))
    end

    it "shows edited journal note after saving edited note" do
      click_link "note-edit-link"

      fill_in "Body", with: "Note has been edited!"
      click_button "note-save-btn"
      sleep 0.5

      expect(page).to have_content("Note has been edited!")
    end

    it "does not show original note content" do
      original_note_body = note.body

      click_link "note-edit-link"

      fill_in "Body", with: "Note has been edited!"
      sleep 0.5
      click_button "note-save-btn"

      expect(page).not_to have_content(original_note_body)
    end
  end
end
