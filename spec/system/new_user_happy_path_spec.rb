require "rails_helper"

RSpec.describe "new user happy path", type: :system do
  let!(:user) { create(:user) }
  let!(:journal) { create(:journal, user: user) }
  let!(:note1) { create(:note, journal: journal) }
  let!(:note2) { create(:note, journal: journal) }
  let!(:note3) { create(:note, journal: journal) }

  context "when new user is signed in" do
    before do
      sign_in user
    end

    context "when new user visits root" do
      before do
        visit root_path
      end

      context "when user creates a new journal" do
        before do
          fill_in "Name", with: journal.name
          click_button "journal-save-btn"
        end

        context "when user creates new notes in the journal" do
          before do
            fill_in "Body", with: note1.body
            click_button "note-save-btn"

            fill_in "Body", with: note2.body
            click_button "note-save-btn"

            fill_in "Body", with: note3.body
            click_button "note-save-btn"
          end

          it "displays users created notes" do
            [note1, note2, note3].each do |note|
              expect(page).to have_content(note.body)
            end
          end
        end
      end
    end
  end
end
