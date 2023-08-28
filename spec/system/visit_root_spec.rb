require "rails_helper"

RSpec.describe "visiting root", type: :system do
  let!(:user) { create(:user) }

  context "when user is signed out" do
    before do
      sign_out user
      visit root_path
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
      visit root_path
    end

    it "redirects to dashboard path" do
      expect(page).to have_current_path(dashboard_path)
    end
  end
end
