require "rails_helper"

RSpec.describe "updating campaigns", type: :system do
  let!(:user) { create(:user) }
  let(:campaign) { create(:campaign, :with_owner_journal, owner: user) }

  before do
    sign_in user
  end

  context "when visiting campaign show page" do
    before do
      visit campaign_path(campaign)
    end

    it "has link to edit campaign" do
      expect(page).to have_link(href: edit_campaign_path(campaign))
    end
  end

  scenario "valid inputs" do
    updated_name = "Updated Campaign"

    visit edit_campaign_path(campaign)
    fill_in "campaign-name-input", with: updated_name
    click_button "campaign-save-btn"

    expect(page).to have_content(updated_name)
  end
end
