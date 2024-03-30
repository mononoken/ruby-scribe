require "rails_helper"

RSpec.describe "multiple journals", type: :system do
  let!(:campaign) { create(:campaign) }
  let!(:journal) { create(:journal, author: campaign.owner) }

  before do
    sign_in campaign.owner
  end

  scenario "valid input" do
    visit campaign_path(campaign)

    click_link "Add Journal"
    select journal.name, from: "journal-select"
    click_button "add-journal-btn"

    expect(page).to have_content(journal.notes.last.name)
  end
end
