require "rails_helper"

RSpec.describe "multiple journals", type: :system do
  let!(:campaign) { create(:campaign) }
  let(:user) { campaign.owner }
  let!(:journal) { create(:journal, author: user) }
  let!(:journal_note) { create(:note, journal:) }

  before do
    sign_in user
  end

  scenario "valid input" do
    visit campaign_path(campaign)

    click_link "add-journal-link"
    select journal.name, from: "journals-select"
    click_button "membership-journal-save-btn"

    expect(page).to have_content(journal_note.name)
  end
end
