require "rails_helper"

RSpec.describe "viewing navbar", type: :system do
  let(:user) { create(:user) }

  context "when user is signed out" do
    before do
      sign_out user
    end

    context "when user visits root" do
      before do
        visit root_path
      end

      it "has link to open navbar" do
        pending "Implement dynamic navbar"

        expect(page).to have_button(:FIX_ME_navbar_button)
      end

      it "has link to sign in in navbar" do
        within "nav" do
          expect(page).to have_link(href: new_user_session_path)
        end
      end

      it "has link to sign up in navbar" do
        within "nav" do
          expect(page).to have_link(href: new_user_registration_path)
        end
      end

      it "does not have link to sign out user in navbar" do
        within "nav" do
          expect(page).not_to have_link(href: destroy_user_session_path)
        end
      end

      it "does not have link to user notebook index" do
        within "nav" do
          expect(page).not_to have_link(href: journals_path)
        end
      end
    end
  end

  context "when user is signed in" do
    before do
      sign_in user
    end

    context "when user visits root" do
      before do
        visit root_path
      end

      it "has link to open navbar" do
        pending "Implement dynamic navbar"

        expect(page).to have_button(:FIX_ME_navbar_button)
      end

      it "has link to sign out in navbar" do
        within "nav" do
          expect(page).to have_link(href: destroy_user_session_path)
        end
      end

      it "does not have link to sign in user in navbar" do
        within "nav" do
          expect(page).not_to have_link(href: new_user_session_path)
        end
      end

      it "does not have link to sign up user in navbar" do
        within "nav" do
          expect(page).not_to have_link(href: new_user_registration_path)
        end
      end

      it "has link to user notebook index" do
        within "nav" do
          expect(page).to have_link(href: journals_path)
        end
      end
    end
  end
end
