require "rails_helper"

RSpec.describe "Notes", type: :system do
  describe "viewing notes" do
    let(:user) { create(:user) }

    context "when user is logged out" do
      before do
        sign_out :user
      end

      it "redirects to login" do
        visit notes_path

        expect(page).to have_current_path(user_session_path)
      end
    end
  end
end
