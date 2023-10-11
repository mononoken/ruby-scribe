require "rails_helper"

RSpec.describe "navbar button", type: :system do
  let!(:user) { create(:user) }

  let(:valid_paths) do
    [
      root_path,
      about_path,
      journals_path
    ]
  end

  before do
    sign_in user

    visit root_path
  end

  context "when signed in user visits root path" do
    it "does not show links in nav before clicking anything" do
      within "nav" do
        valid_paths.each do |path|
          expect(page).not_to have_link(href: path)
        end
      end
    end

    it "shows valid links when toggled for the first time" do
      click_button "nav-hamburger-btn"

      within "nav" do
        valid_paths.each do |path|
          expect(page).to have_link(href: path)
        end
      end
    end

    it "does not show valid links when closed" do
      click_button "nav-hamburger-btn"
      click_button "nav-close-btn"

      within "nav" do
        valid_paths.each do |path|
          expect(page).not_to have_link(href: path)
        end
      end
    end
  end
end
