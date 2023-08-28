require "rails_helper"

RSpec.describe "indexing notes", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user's journal has three notes" do
    let!(:journal) { create(:journal, user: user) }
    let!(:note1) { create(:note, created_at: 2.minutes.ago, updated_at: 2.minutes.ago, journal: journal) }
    let!(:note2) { create(:note, created_at: 1.minutes.ago, updated_at: 1.minutes.ago, journal: journal) }
    let!(:note3) { create(:note, created_at: 0.minutes.ago, updated_at: 0.minutes.ago, journal: journal) }

    it "shows notes in descending updated_at order" do
      visit journal_notes_path(journal)

      notes_desc = [note3.body, note2.body, note1.body]

      page_notes = page.all("[data-testid='note-body']").map(&:text)

      expect(page_notes).to eq(notes_desc)
    end
  end
end
