require "rails_helper"

RSpec.describe Invitation, type: :model do
  let!(:invitation) { create(:invitation) }

  describe "#valid?" do
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
