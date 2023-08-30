require "rails_helper"

RSpec.describe "creating notes", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user has one empty journal" do
    let!(:journal) { create(:journal, user: user) }
    let(:note_input) { "Test note" }

    it "shows created journal note after submitting note" do
      visit new_journal_note_path(journal)
      fill_in "Body", with: note_input
      click_button "note-save-btn"

      expect(page).to have_content(note_input)
    end
  end

  context "when user has existing notes" do
    let!(:journal) { create(:journal, user: user) }
    let!(:existing_note) { create(:note, journal: journal) }
    let(:note_count) { Note.all.count }

    before do
      visit new_journal_note_path(journal)
      fill_in "name-input", with: existing_note.name
      click_button "note-save-btn"
    end

    it "shows error when user tries to create a note with the same name" do
      expect(page).to have_content("This note name is already in use.")
    end
  end
end
