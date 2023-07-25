require "rails_helper"

RSpec.describe "visiting root", type: :system do
  let(:visit_root) { visit root_path }
  let(:user) { create(:user) }

  context "when user is signed out" do
    before do
      sign_out user
      visit_root
    end

    it "directs to root path" do
      expect(page).to have_current_path(root_path)
    end

    it "opens a page with a link to user registration" do
      expect(page).to have_link(href: new_user_registration_path)
    end

    it "opens a page with a link to user sign in" do
      expect(page).to have_link(href: new_user_session_path)
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
        it "shows campaign index" do
        end
      end

      context "when user has no campaigns" do
        it "redirects to new campaign path" do
          visit_root

          expect(page).to have_current_path(new_campaign_path)
        end
      end
    end
  end
end
