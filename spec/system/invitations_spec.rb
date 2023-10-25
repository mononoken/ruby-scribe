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
        expect(page).not_to have_content(
          "#{sender.username} has invited you to their collection"
        )
      end
    end
  end

  context "when sending an invitation to owned collection" do
    let(:collection) { create(:collection, owner: sender) }

    before do
      visit collection_path(collection)
      click_button "invite-reveal-btn"
      expect(page).to have_test_id("invitation-form")

      select recipient.username, from: "collection-username-select"
      click_button "invite-submit-btn"
      sleep 0.5
    end

    it "shows invitation in recipient user's dashboard" do
      sign_in recipient
      visit dashboard_path

      within "[data-testid='notifications-list']" do
        expect(page).to have_content(
          "#{sender.username} has invited you to their collection #{collection.name}."
        )
      end
    end

    it "shows invitation sent success message with recipient name" do
      expect(page).to have_content(
        "You invited #{recipient.username} to your collection #{collection.name}"
      )
    end
  end

  context "when accepting an invitation" do
    let!(:collection) { create(:collection, owner: sender) }
    let!(:invitation) { create(:invitation, sender:, recipient:, collection:) }

    before do
      sign_in recipient
      visit users_invitations_path
      click_button "accept-invitation-btn"
      sleep 0.5
    end

    it "shows accepted invitation's collection in user's collections" do
      visit collections_path

      expect(page).to have_content(collection.name)
    end

    it "redirects to the accepted collection" do
      expect(page).to have_current_path(collection_path(collection))
    end
  end
end
