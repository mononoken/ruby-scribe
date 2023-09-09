require "rails_helper"

RSpec.describe "/journals", type: :request do
  let!(:user) { create(:user) }

  describe "GET /:id/notes" do
    let!(:user_journal) { create(:journal, author: user) }
    let!(:user_note) { create(:note, journal: user_journal, author: user) }

    context "when other user signed in" do
      let!(:other_user) { create(:user) }

      before do
        sign_in other_user
      end

      it "returns http forbidden" do
        without_detailed_exceptions do
          get journal_notes_path(user_journal)
        end

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
