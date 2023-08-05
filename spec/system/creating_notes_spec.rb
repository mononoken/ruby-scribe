require "rails_helper"

RSpec.describe "creating notes", type: :system do
  let(:user) { create(:user) }

  context "when user is signed in with one empty journal" do
    let(:journal) { create(:journal, user: user) }
    let(:note_input) { "Test note" }

    before do
      sign_in user
    end

    it "shows created journal note after submitting note" do
      visit new_journal_note_path(journal)
      fill_in "Body", with: note_input
      click_button "Create Note"

      expect(page).to have_content(note_input)
    end
  end
end
