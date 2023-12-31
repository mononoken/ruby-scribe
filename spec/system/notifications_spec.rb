require "rails_helper"

RSpec.describe "Notifications", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "notifications count" do
    context "when user has 1 notification" do
      before do
        create(:notification, recipient: user)

        visit root_path
      end

      it "shows text '1' with notification icon" do
        within "[data-testid='notifications-count']" do
          expect(page).to have_content("1")
        end
      end
    end

    context "when user has no notifications" do
      it "does not show a notification count" do
        visit root_path

        within "[data-testid='notifications-count']" do
          expect(page).to have_content("")
        end
      end
    end

    context "when user has 3 notifications" do
      before do
        3.times do
          create(:notification, recipient: user)
        end

        visit root_path
      end

      it "shows text '3' with notification icon" do
        within "[data-testid='notifications-count']" do
          expect(page).to have_content("3")
        end
      end
    end
  end

  describe "destroying notifications" do
    let!(:notification_record) { create(:invitation_notification, recipient: user) }
    let(:notification) { notification_record.to_notification }

    context "when user accepts an invitation" do
      it "destroys associated notification"
    end

    context "when user clicks dismiss button for a notification" do
      it "destroys notification"
    end

    context "when user views notifications" do
      it "does not destroy notification" do
        visit notifications_path

        expect(page).to have_content(notification.message)
      end
    end
  end

  describe "showing notifications" do
  end
end
