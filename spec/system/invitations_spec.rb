require "rails_helper"

RSpec.describe "invitations", type: :system do
  let!(:sender) { create(:user) }
  let!(:recipient) { create(:user) }

  before do
    sign_in sender
  end

  context "when no invitations have been sent" do
    it "does not show invitations in recipient's dashboard notifications" do
      sign_in recipient
      visit dashboard_path

      within "[data-testid='notifications-list']" do
        expect(page).not_to have_content("#{sender.username} has invited you to their collection")
      end
    end
  end

  context "when sending an invitation" do
    let(:collection) { create(:collection, owner: sender) }

    before do
      visit collection_path(collection)
      click_button "invite-reveal-btn"
      fill_in "collection-username-search", with: recipient.username
      click_button "invite-send-btn"
    end

    it "shows invitation in recipient user's dashboard" do
      sign_in recipient
      visit dashboard_path

      within "[data-testid='notifications-list']" do
        expect(page).to have_content("#{sender.username} has invited you to their collection #{collection.name}.")
      end
    end
  end

  context "when accepting an invitation" do
    it "shows accepted invitation's collection in user's collections" do
      # expect(page).to have_content(collection.name)
    end
  end
end
