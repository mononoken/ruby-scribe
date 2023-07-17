require "rails_helper"

RSpec.describe "viewing notes", type: :system do
  describe "viewing notes index" do
    let(:visit_index) { visit notes_path }
    let(:user) { create(:user) }

    context "when user is signed out" do
      before do
        sign_out user
      end

      it "redirects to login" do
        visit_index

        expect(page).to have_current_path(user_session_path)
      end
    end

    context "when user is signed in" do
      before do
        sign_in user
      end

      it "shows notes" do
        visit_index

        expect(page).to have_current_path(notes_path)
      end
    end
  end
end
