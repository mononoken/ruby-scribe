require "rails_helper"

RSpec.describe "creating notes", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user has one empty journal" do
    let!(:journal) { create(:journal, user: user) }
    let(:note_name) { "Test note" }

    it "shows created journal note after submitting note" do
      visit new_journal_note_path(journal)
      fill_in "note-name-input", with: note_name
      click_button "note-save-btn"

      expect(page).to have_content(note_name)
    end
  end

  context "when user has existing notes" do
    let!(:journal) { create(:journal, user: user) }
    let!(:existing_note) { create(:note, journal: journal, user: user) }

    it "shows error when user tries to create a note with the same name" do
      visit new_journal_note_path(journal)

      fill_in "note-name-input", with: existing_note.name
      fill_in "note-body-input", with: "Body should not affect uniqueness."
      click_button "note-save-btn"

      expect(page).to have_content("Name has already been taken")
    end
  end
end
