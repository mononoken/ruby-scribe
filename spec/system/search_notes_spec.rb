require "rails_helper"

RSpec.describe "search notes", type: :system do
  let!(:user) { create(:user) }
  let!(:journal) { create(:journal, author: user) }
  let(:matching_notes) { [] }
  let(:not_matching_notes) { [] }

  before do
    10.times do |i|
      if i < 2
        matching_notes << create(:note, author: user, journal:, name: "success #{i}")
      else
        not_matching_notes << create(:note, author: user, journal:, name: "failure #{i}")
      end
    end
  end

  context "when viewing journal_notes_path" do
    before do
      sign_in user
      visit journal_notes_path(journal)
    end

    it "shows all notes before searching" do
      matching_notes.concat(not_matching_notes).each do |note|
        within "[data-testid='notes-list']" do
          expect(page).to have_content(note.name)
        end
      end
    end

    context "when searching journal based on note name" do
      before do
        fill_in "note-search-input", with: "success"
        click_button "note-search-btn"
      end

      it "shows matching notes on search result" do
        matching_notes.each do |note|
          within "[data-testid='notes-list']" do
            expect(page).to have_content(note.name)
          end
        end
      end

      it "does not show not matching notes on search result" do
        not_matching_notes.each do |note|
          within "[data-testid='notes-list']" do
            expect(page).not_to have_content(note.name)
          end
        end
      end
    end
  end
end
