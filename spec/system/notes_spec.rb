require "rails_helper"

RSpec.describe "Notes", type: :system do
  describe "viewing notes" do
    context "when logged out" do
      before do
        sign_out :user
      end

      it "redirects to login" do
        visit notes_url

        expect(page).to have_field("password")
      end
    end
  end
end
