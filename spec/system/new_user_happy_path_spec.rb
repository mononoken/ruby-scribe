require "rails_helper"

RSpec.describe "new user happy path", type: :system do
  context "when new user is signed in" do
    let!(:user) { create(:user) }

    before do
      sign_in user
    end

    context "when new user visits root" do
      before do
        visit root_path
      end

      context "when user creates a new journal" do
        let(:journal) { build(:journal) }

        before do
          click_link "new-journal-link"
          fill_in "Name", with: journal.name
          click_button "journal-save-btn"
        end

        context "when user creates new notes in the journal" do
          let(:note1) { build(:note) }
          let(:note2) { build(:note) }
          let(:note3) { build(:note) }

          it "displays users created notes' names after each save" do
            [note1, note2, note3].each do |note|
              fill_in "note-name-input", with: note.name
              fill_in "note-body-input", with: note.body
              click_button "note-save-btn"
              expect(page).to have_content(note.name)
            end
          end
        end
      end
    end
  end
end
