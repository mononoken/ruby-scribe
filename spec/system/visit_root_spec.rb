require "rails_helper"

RSpec.fdescribe "visiting root", type: :system do
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

    context "when user has one existing journal" do
      let(:journal) { create(:journal, user: user) }

      it "redirects to the new note page for that journal" do
        pending "Method to check for user last journal to route to"

        expect(page).to have_current_path(new_journal_note_path(journal))
      end
    end

    context "when user has many existing journals" do
      it "redirects to the new note page for last visited journal" do
        pending "Method to store last visited journal"

        expect(page).to have_current_path(new_journal_note_path(:FIX_ME_last_journal))
      end
    end

    context "when user has no journals" do
      it "redirects to new journal path" do
        expect(page).to have_current_path(new_journal_path)
      end
    end
  end
end
