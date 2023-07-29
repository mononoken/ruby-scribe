require "rails_helper"

RSpec.describe "creating campaigns", type: :system do
  context "when user is creating their first campaign" do
    let(:campaign) { create(:campaign) }

    before do
      sign_in campaign.user
    end

    it "shows the new campaign title in the campaign index" do
      visit root_path
      fill_in "Name", with: campaign.name
      click_button "Create"

      expect(page).to have_text(campaign.name)
    end

    context "when user does not enter a campaign title and submits" do
      let(:error_msg) { "Name can't be blank" }

      fit "shows an error" do
        visit root_path
        click_button "Create"

        expect(page).to have_text(error_msg)
      end
    end
  end
end
