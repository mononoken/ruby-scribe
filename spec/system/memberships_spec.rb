require "rails_helper"

RSpec.describe "memberships", type: :system do
  describe "destroying a membership" do
    let!(:user) { create(:user) }
    let!(:campaign) { create(:campaign) }
    let!(:membership) { create(:membership, campaign:, member: user) }

    context "when user clicks leave button on campaign page" do
      before do
        sign_in user
        visit campaign_path(campaign)
        click_button "membership-destroy-btn"
      end

      it "does not show campaign in campaigns index" do
        visit campaigns_path

        within "[data-testid='campaigns-list']" do
          expect(page).not_to have_content(campaign.name)
        end
      end
    end
  end
end
