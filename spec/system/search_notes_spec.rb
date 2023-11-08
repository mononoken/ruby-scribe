require "rails_helper"

RSpec.describe "search notes", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when searching journal with 10 total notes and 2 matching notes" do
    let!(:journal) { create(:journal, author: user) }
    let(:matching_notes) { [] }
    let(:not_matching_notes) { [] }

    before do
      10.times do |i|
        if i < 2
          matching_notes << create(:note, author: user, name: "success #{i}")
        else
          not_matching_notes << create(:note, author: user, name: "failure #{i}")
        end
      end

      visit journal_notes_path(journal)

      fill_in "note-search-input", with: "success"
      click_button "note-search-btn"
    end

    it "shows two matching notes on search result" do
      matching_notes.each do |note|
        expect(page).to have_content(note.name)
      end
    end

    it "does not show not matching notes on search result" do
      not_matching_notes.each do |note|
        expect(page).not_to have_content(note.name)
      end
    end
  end
end
