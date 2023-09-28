require "rails_helper"

RSpec.describe "creating journals", type: :system do
  let!(:user) { create(:user) }
  let(:journal) { build(:journal) }

  before do
    sign_in user
  end

  it "shows new journal link on journals index" do
    visit journals_path

    expect(page).to have_link(href: new_journal_path)
  end

  it "shows new journal link on dashboard when user has no journals" do
    visit dashboard_path

    expect(page).to have_link(href: new_journal_path)
  end

  it "shows the new journal title in the journal index" do
    visit new_journal_path
    fill_in "journal-name-input", with: journal.name
    click_button "journal-save-btn"

    expect(page).to have_text(journal.name)
  end

  context "when user does not enter a journal title and submits" do
    let(:error_msg) { "Name can't be blank" }

    it "shows an error" do
      visit new_journal_path
      click_button "journal-save-btn"

      expect(page).to have_text(error_msg)
    end
  end
end
