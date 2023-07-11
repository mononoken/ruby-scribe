require "rails_helper"

RSpec.describe "Notes", type: :request do
  let(:user) { create(:user) }

  describe "GET /notes/" do
    context "when user is signed in" do
      before do
        sign_in user
      end

      it "returns http success" do
        get "/notes/"
        expect(response).to have_http_status(:success)
      end
    end

    xcontext "when user is signed out" do
      before do
        sign_out user
      end

      it "returns http found" do
        get "/notes/"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
