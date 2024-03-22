require "rails_helper"

RSpec.describe Invitation, type: :model do
  let(:invitation) { build(:invitation) }

  describe "#message" do
    let(:sender) { build_stubbed(:user, username: "Gandalf") }
    let(:campaign) { build_stubbed(:campaign, name: "Thorin's Quest") }
    let(:invitation) { build(:invitation, sender:, campaign:) }

    before do
      allow(sender).to receive(:username).and_return("Gandalf")
      allow(campaign).to receive(:name).and_return("Thorin's Quest")
    end

    it "returns string showing message with sender and campaign" do
      expected_message = "Gandalf has invited you to their campaign Thorin's Quest."

      expect(invitation.message).to eq(expected_message)
    end
  end

  describe "#accept" do
    include ActiveSupport::Testing::TimeHelpers

    let(:membership_class) { spy("Membership") }
    let(:membership) { instance_double(Membership) }

    before do
      allow(membership_class).to receive(:create)
        .with(
          campaign: invitation.campaign,
          member: invitation.recipient,
          role: :member
        ).and_return(membership)

      allow(membership).to receive(:valid?)
        .and_return(true)
    end

    it "sets accepted_at to current time" do
      freeze_time

      expect { invitation.accept }
        .to change { invitation.accepted_at }
        .to(DateTime.now)
    end

    it "sends create to Membership class with campaign and recipient" do
      invitation.accept(membership_class)

      expect(membership_class).to have_received(:create)
        .with(
          campaign: invitation.campaign,
          member: invitation.recipient,
          role: :member
        )
    end
  end

  describe "#valid?" do
    let!(:invitation) { create(:invitation) }

    context "when duplicate invitation is built" do
      let(:duplicate_invitation) {
        build(:invitation, sender: invitation.sender,
          recipient: invitation.recipient, campaign: invitation.campaign)
      }

      # Delete if failing
      it "is not valid" do
        expect(duplicate_invitation.valid?).to be(false)
      end
    end

    context "when invitation has same recipient and campaign but different sender" do
      let(:duplicate_invitation) {
        build(:invitation, recipient: invitation.recipient,
          campaign: invitation.campaign)
      }

      # Delete if failing
      it "is not valid" do
        expect(duplicate_invitation.valid?).to be(false)
      end
    end

    context "when invitation has a different recipient" do
      let(:new_recipient) { create(:user) }
      let(:new_invitation) {
        build(:invitation, sender: invitation.sender,
          recipient: new_recipient, campaign: invitation.campaign)
      }

      # Delete if failing
      it "is valid" do
        expect(new_invitation.valid?).to be(true)
      end
    end
  end
end
