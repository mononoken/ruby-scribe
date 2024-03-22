require "rails_helper"

RSpec.describe "invitations", type: :system do
  let!(:sender) { create(:user) }
  let!(:recipient) { create(:user) }

  context "when no invitations have been sent" do
    it "does not show invitations in recipient's invitations index" do
      sign_in recipient
      visit users_invitations_path

      expect(page).not_to have_content(
        "#{sender.username} has invited you to their campaign"
      )
    end
  end

  context "when sending an invitation to owned campaign" do
    let(:campaign) { create(:campaign, owner: sender) }

    before do
      sign_in sender
      visit campaign_path(campaign)
      click_button "invite-reveal-btn"
      expect(page).to have_test_id("invitation-form")

      select recipient.username, from: "campaign-username-select"
      click_button "invite-submit-btn"
      sleep 0.5
    end

    it "shows invitation in recipient user's invitations index" do
      sign_in recipient
      visit users_invitations_path

      expect(page).to have_content(
        "#{sender.username} has invited you to their campaign #{campaign.name}."
      )
    end

    it "shows invitation sent success message with recipient name" do
      expect(page).to have_content(
        "You invited #{recipient.username} to your campaign #{campaign.name}"
      )
    end
  end

  context "when an invitation has been received" do
    let!(:campaign) { create(:campaign, owner: sender) }
    let!(:invitation) { create(:invitation, sender:, recipient:, campaign:) }

    before do
      sign_in recipient
    end

    it "shows link to the invitation on index" do
      visit users_invitations_path

      expect(page).to have_link(href: users_invitation_path(invitation))
    end

    context "when accepting an invitation" do
      before do
        visit users_invitations_path
        click_button "accept-invitation-btn"
        sleep 0.5
      end

      it "shows accepted invitation's campaign in user's campaigns" do
        visit campaigns_path

        expect(page).to have_content(campaign.name)
      end

      it "redirects to the accepted campaign" do
        expect(page).to have_current_path(campaign_path(campaign))
      end

      it "does not show invitation anymore on invitations index" do
        visit users_invitations_path

        expect(page).not_to have_content(campaign.name)
      end

      it "does not show link to the invitation on index" do
        visit users_invitations_path

        expect(page).not_to have_link(href: users_invitation_path(invitation))
      end
    end
  end
end
