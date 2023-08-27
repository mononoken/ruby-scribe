require "rails_helper"

RSpec.describe "editing notes", type: :system do
  let!(:user) { create(:user) }

  context "when user is viewing journal notes" do
    let!(:journal) { create(:journal, user: user) }
    let!(:note) { create(:note, journal: journal) }

    before do
      sign_in user
      visit journal_notes_path(journal)
    end

    fit "navigates to edit page of note when clicking edit button" do
      click_link "Edit Note"

      expect(page).to have_current_path(edit_note_path(note))
    end

    fit "shows edited journal note after saving edited note" do
      click_link "Edit Note"

      fill_in "Body", with: "Note has been edited!"
      click_button "Save Note"

      expect(page).to have_content("Note has been edited!")
    end
  end
end
