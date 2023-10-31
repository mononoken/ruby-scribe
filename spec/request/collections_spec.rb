require "rails_helper"

RSpec.describe "/collections", type: :request do
  let!(:user) { create(:user) }

  describe "GET /:id/" do
    before do
      sign_in user
    end

    context "when user owns the collection" do
      let!(:collection) { create(:collection, owner: user) }

      it "returns http success" do
        get collection_path(collection)

        expect(response).to have_http_status(:success)
      end
    end

    context "when user is a member of other user's collection" do
      let!(:other_user) { create(:user) }
      let!(:users_journal) { create(:journal, author: user) }
      let!(:others_journal) { create(:journal, author: other_user) }

      let!(:collection) {
        collection_with_journals(journals: [users_journal, others_journal],
          owner: other_user, owner_journal: others_journal)
      }

      it "returns http success" do
        get collection_path(collection)

        expect(response).to have_http_status(:success)
      end
    end

    context "when user has no membership to the collection" do
      let!(:other_user) { create(:user) }
      let!(:others_journal) { create(:journal, author: other_user) }

      let!(:collection) {
        collection_with_journals(journals: [others_journal], owner: other_user)
      }

      it "returns http forbidden" do
        without_detailed_exceptions do
          get collection_path(collection)
        end

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
