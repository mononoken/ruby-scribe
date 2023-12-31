require "rails_helper"

RSpec.describe "Notifications", type: :system do
  describe "notifications count" do
    let!(:user) { create(:user) }

    before do
      sign_in user
    end

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

  describe "showing notifications" do
  end
end
