require "rails_helper"

RSpec.describe "viewing navbar", type: :system do
  let(:user) { create(:user) }

  context "when user is signed out" do
    before do
      sign_out user
    end

    context "when user visits root" do
      let(:valid_links) do
        [
          new_user_session_path,
          new_user_registration_path,
          root_path,
          about_path
        ]
      end

      let(:invalid_links) do
        [
          destroy_user_session_path,
          journals_path
        ]
      end

      before do
        visit root_path
      end

      it "has link to open navbar" do
        pending "Implement dynamic navbar"

        expect(page).to have_button(:FIX_ME_navbar_button)
      end

      fit "has valid links in navbar" do
        valid_links.each do |link|
          within "nav" do
            expect(page).to have_link(href: link)
          end
        end
      end

      fit "does not have invalid links in navbar" do
        invalid_links.each do |link|
          within "nav" do
            expect(page).not_to have_link(href: link)
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
      let(:valid_links) do
        [
          destroy_user_session_path,
          journals_path,
          root_path
        ]
      end

      let(:invalid_links) do
        [
          new_user_session_path,
          new_user_registration_path
        ]
      end

      before do
        visit root_path
      end

      it "has link to open navbar" do
        pending "Implement dynamic navbar"

        expect(page).to have_button(:FIX_ME_navbar_button)
      end

      fit "has valid links in navbar" do
        valid_links.each do |link|
          within "nav" do
            expect(page).to have_link(href: link)
          end
        end
      end

      fit "does not have invalid links in navbar" do
        invalid_links.each do |link|
          within "nav" do
            expect(page).not_to have_link(href: link)
          end
        end
      end
    end
  end
end
