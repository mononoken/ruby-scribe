require "rails_helper"

RSpec.describe "/campaigns", type: :request do
  let!(:user) { create(:user) }

  describe "GET /:id/" do
    before do
      sign_in user
    end

    context "when user owns the campaign" do
      let!(:campaign) { create(:campaign, owner: user) }

      it "returns http success" do
        get campaign_path(campaign)

        expect(response).to have_http_status(:success)
      end
    end

    context "when user is a member of other user's campaign" do
      let!(:other_user) { create(:user) }
      let!(:users_journal) { create(:journal, author: user) }
      let!(:others_journal) { create(:journal, author: other_user) }

      let!(:campaign) {
        campaign_with_journals(journals: [users_journal, others_journal],
          owner: other_user, owner_journal: others_journal)
      }

      it "returns http success" do
        get campaign_path(campaign)

        expect(response).to have_http_status(:success)
      end
    end

    context "when user has no membership to the campaign" do
      let!(:other_user) { create(:user) }
      let!(:others_journal) { create(:journal, author: other_user) }

      let!(:campaign) {
        campaign_with_journals(journals: [others_journal], owner: other_user)
      }

      it "returns http forbidden" do
        without_detailed_exceptions do
          get campaign_path(campaign)
        end

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
