require "rails_helper"

RSpec.describe "dashboard", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user has journal" do
    let!(:journal) { create(:journal, author: user) }

    it "shows link to journal notes" do
      visit dashboard_path

      expect(page).to have_link(href: journal_notes_path(journal))
    end
  end

  context "when user has no journals" do
    it "shows link to new journal" do
      visit dashboard_path

      expect(page).to have_link(href: new_journal_path)
    end
  end
end
