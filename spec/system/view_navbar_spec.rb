require "rails_helper"

RSpec.describe "viewing navbar", type: :system do
  let(:user) { create(:user) }

  context "when user is signed out" do
    before do
      sign_out user
    end

    context "when user visits root" do
      let(:valid_paths) do
        [
          new_user_session_path,
          new_user_registration_path,
          root_path,
          about_path
        ]
      end

      let(:invalid_paths) do
        [
          destroy_user_session_path,
          journals_path
        ]
      end

      before do
        visit root_path
      end

      it "has button to open navbar" do
        pending "Implement dynamic navbar"

        expect(page).to have_button(:FIX_ME_navbar_button)
      end

      it "has valid links in navbar" do
        valid_paths.each do |path|
          within "nav" do
            expect(page).to have_link(href: path)
          end
        end
      end

      it "does not have invalid links in navbar" do
        invalid_paths.each do |path|
          within "nav" do
            expect(page).not_to have_link(href: path)
          end
        end
      end
    end
  end

  context "when user is signed in" do
    before do
      sign_in user
    end

    context "when user visits root" do
      let(:valid_paths) do
        [
          destroy_user_session_path,
          journals_path,
          root_path
        ]
      end

      let(:invalid_paths) do
        [
          new_user_session_path,
          new_user_registration_path
        ]
      end

      before do
        visit root_path
      end

      it "has path to open navbar" do
        pending "Implement dynamic navbar"

        expect(page).to have_button(:FIX_ME_navbar_button)
      end

      it "has valid links in navbar" do
        valid_paths.each do |path|
          within "nav" do
            expect(page).to have_link(href: path)
          end
        end
      end

      it "does not have invalid links in navbar" do
        invalid_paths.each do |path|
          within "nav" do
            expect(page).not_to have_link(href: path)
          end
        end
      end
    end
  end

  context "when user has journals" do
    let!(:journal1) { create(:journal, user: user) }
    let!(:journal2) { create(:journal, user: user) }

    before do
      sign_in user
      visit root_path
    end

    it "has links to user's journals in navbar" do
      journal_paths = [journal1, journal2].map do |journal|
        journal_notes_path(journal)
      end

      journal_paths.each do |path|
        within "nav" do
          expect(page).to have_link(href: path)
        end
      end
    end
  end
end