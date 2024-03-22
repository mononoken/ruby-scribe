require "rails_helper"

RSpec.describe "indexing campaigns", type: :system do
  let!(:user) { create(:user) }
  # let!(:campaign1) { create(:campaign, owner: user) }
  # let!(:campaign2) { create(:campaign, owner: user) }

  context "when user visits campaigns path from navbar" do
    before do
      sign_in user
      visit root_path

      within "nav" do
        click_link "campaigns-link"
      end
    end

    xit "shows links to all of user's campaigns" do
      pending "Implement campaigns index view"
      # [campaign1, campaign2].each do |campaign|
      #   expect(page).to have_link(href: campaign_path(campaign))
      # end
    end
  end
end
