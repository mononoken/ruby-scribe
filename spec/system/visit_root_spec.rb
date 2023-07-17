require "rails_helper"

RSpec.describe "visiting root", type: :system do
  let(:visit_root) { visit root_path }
  let(:user) { create(:user) }

  context "when user is signed out" do
    before do
      sign_out user
    end

    it "redirects to login" do
      visit_root

      expect(page).to have_current_path(user_session_path)
    end

    fit "redirects to splash page" do
      visit_root

      expect(page).to have_current_path(splash_path)
    end
  end

  context "when user is signed in" do
    before do
      sign_in user
    end

    context "when user has a selected campaign" do
      before do
        :FIX_ME_select_campaign
      end

      xit "redirects to the new note page for that campaign" do
        visit_root

        expect(page).to have_current_path(new_note_path)
      end
    end

    context "when user does not have a selected campaign" do
      context "when user has any campaigns" do
        it "shows campaign index"
      end

      context "when user has no campaigns" do
        it "redirects to new campaign page"
      end
    end
  end
end
