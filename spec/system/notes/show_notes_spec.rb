require "rails_helper"

RSpec.describe "showing notes", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user's journal has a note with markdown syntax" do
    let!(:journal) { create(:journal, user: user) }
    let(:markdown) do
      <<~MARKDOWN.strip
        # Header
        - List item
        - List item with *italics*
      MARKDOWN
    end
    let!(:note) { create(:note, journal: journal, body: markdown) }

    fit "shows converted markdown note when clicked" do
      visit journal_notes_path(journal)

      converted_markdown = <<~HTML
        <h1>Header</h1>
        <ul>
          <li>List item</li>
          <li>List item with <em>italics</em></li>
        </ul>
      HTML

      click_link "note-link"

      expect(page).to have_content(converted_markdown)
    end
  end
end
