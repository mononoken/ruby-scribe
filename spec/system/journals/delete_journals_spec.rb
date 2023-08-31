require "rails_helper"

RSpec.describe "deleting journals", type: :system do
  let!(:user) { create(:user) }
  let!(:journal) { create(:journal, user: user) }

  before do
    sign_in user
  end

  it "does not show journal in index after deletion" do
    visit journals_path
    accept_alert do
      click_on "journal-delete-btn"
    end

    within "ul[data-testid='journal-list']" do
      expect(page).not_to have_content(journal.name)
    end
  end
end
