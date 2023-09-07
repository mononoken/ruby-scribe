require "rails_helper"

RSpec.describe "editing journals", type: :system do
  let!(:user) { create(:user) }
  let!(:journal) { create(:journal, author: user) }

  before do
    sign_in user
  end

  context "when user is viewing journal index" do
    it "has a link to journal's edit page" do
      visit journals_path

      expect(page).to have_link(href: edit_journal_path(journal))
    end
  end

  context "when user is viewing journal notes index" do
    it "has a link to journal's edit page" do
      visit journal_notes_path(journal)

      expect(page).to have_link(href: edit_journal_path(journal))
    end
  end

  context "when user has an existing journal" do
    it "shows the edited journal title in the journal index" do
      visit edit_journal_path(journal)
      fill_in "journal-name-input", with: "Edited Journal"
      click_button "journal-save-btn"

      expect(page).to have_text("Edited Journal")
    end
  end
end
