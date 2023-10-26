require "rails_helper"

RSpec.describe Invitation, type: :model do
  let(:invitation) { build(:invitation) }

  describe "#message" do
    let(:sender) { build_stubbed(:user, username: "Gandalf") }
    let(:collection) { build_stubbed(:collection, name: "Thorin's Quest") }
    let(:invitation) { build(:invitation, sender:, collection:) }

    before do
      allow(sender).to receive(:username).and_return("Gandalf")
      allow(collection).to receive(:name).and_return("Thorin's Quest")
    end

    it "returns string showing message with sender and collection" do
      expected_message = "Gandalf has invited you to their collection Thorin's Quest."

      expect(invitation.message).to eq(expected_message)
    end
  end

  describe "#accept" do
    include ActiveSupport::Testing::TimeHelpers

    let(:membership_class) { spy("Membership") }

    before do
      allow(membership_class).to receive(:create)
        .with(collection: invitation.collection, member: invitation.recipient)
    end

    it "sets accepted_at to current time" do
      freeze_time

      expect { invitation.accept }
        .to change { invitation.accepted_at }
        .to(DateTime.now)
    end

    it "sends create to Membership class with collection and recipient" do
      invitation.accept(membership_class)

      expect(membership_class).to have_received(:create)
        .with(collection: invitation.collection, member: invitation.recipient)
    end
  end

  describe "#valid?" do
    let!(:invitation) { create(:invitation) }

    context "when duplicate invitation is built" do
      let(:duplicate_invitation) {
        build(:invitation, sender: invitation.sender,
          recipient: invitation.recipient, collection: invitation.collection)
      }

      # Delete if failing
      it "is not valid" do
        expect(duplicate_invitation.valid?).to be(false)
      end
    end

    context "when invitation has same recipient and collection but different sender" do
      let(:duplicate_invitation) {
        build(:invitation, recipient: invitation.recipient,
          collection: invitation.collection)
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
          recipient: new_recipient, collection: invitation.collection)
      }

      # Delete if failing
      it "is valid" do
        expect(new_invitation.valid?).to be(true)
      end
    end
  end
end
