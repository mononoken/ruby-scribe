require "rails_helper"

RSpec.describe "showing notes", type: :system do
  let!(:user) { create(:user) }

  context "when user's journal has a note with markdown syntax" do
    let!(:journal) { create(:journal, author: user) }
    let(:markdown) do
      <<~MARKDOWN.strip
        # Header
        - List item
        - List item with *italics*
      MARKDOWN
    end
    let!(:note) { create(:note, journal: journal, body: markdown) }

    before do
      sign_in user
    end

    it "shows parsed markdown note when clicked" do
      visit journal_notes_path(journal)

      click_link "note-link"

      expect(page).to have_selector("h1", text: "Header")
      expect(page).to have_selector("ul", text: "List item\nList item with italics")
      expect(page).to have_selector("li", text: "List item")
      expect(page).to have_selector("li", text: "List item with italics")
      expect(page).to have_selector("em", text: "italics")
    end
  end
end
