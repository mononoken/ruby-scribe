require "rails_helper"

RSpec.describe "memberships", type: :system do
  describe "destroying a membership" do
    let!(:user) { create(:user) }
    let!(:collection) { create(:collection) }
    let!(:membership) { create(:membership, collection:, member: user) }

    context "when user clicks leave button on collection page" do
      before do
        sign_in user
        visit collection_path(collection)
        click_button "membership-destroy-btn"
      end

      it "does not show collection in collections index" do
        visit collections_path

        within "[data-testid='collections-list']" do
          expect(page).not_to have_content(collection.name)
        end
      end
    end
  end
end
