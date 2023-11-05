require "rails_helper"

RSpec.describe "showing notes", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user's journal has a note with markdown syntax" do
    let!(:journal) { create(:journal, author: user) }
    let(:markdown) do
      <<~MARKDOWN.strip
        # Header
        - List item
        - List item with *italics*
      MARKDOWN
    end
    let!(:note) {
      create(:note, journal: journal, author: user,
        body: markdown)
    }

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

  context "when user views their note" do
    let!(:note) { create(:note, author: user) }

    before do
      visit note_path(note)
    end

    it "has a link to note's journal notes" do
      expect(page).to have_link(href: journal_notes_path(note.journal))
    end

    it "has link to edit note" do
      expect(page).to have_link("note-edit-link")
    end

    it "has button to destroy note" do
      expect(page).to have_button("note-destroy-btn")
    end

    it "has button to create a comment for note" do
      expect(page).to have_button("new_comment-save-btn")
    end
  end
end
