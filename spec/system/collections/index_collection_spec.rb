require "rails_helper"

RSpec.describe "indexing collections", type: :system do
  let!(:user) { create(:user) }
  # let!(:collection1) { create(:collection, owner: user) }
  # let!(:collection2) { create(:collection, owner: user) }

  context "when user visits collections path from navbar" do
    before do
      sign_in user
      visit root_path

      within "nav" do
        click_link "collections-link"
      end
    end

    xit "shows links to all of user's collections" do
      pending "Implement collections index view"
      # [collection1, collection2].each do |collection|
      #   expect(page).to have_link(href: collection_path(collection))
      # end
    end
  end
end
