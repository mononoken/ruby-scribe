require "rails_helper"

RSpec.describe Campaign, type: :model do
  # Delete if failing
  context "when campaign has a name" do
    subject(:campaign) { create(:campaign) }

    context "when campaign has a user" do
      let(:user) { create(:user) }

      subject(:campaign) do
        described_class.new(name: "Test Campaign", user:)
      end

      it "is valid" do
        expect(campaign.valid?).to be(true)
      end
    end
  end

  # Delete if failing
  context "when campaign has no name" do
    subject(:campaign) { described_class.new(name: nil) }

    it "is not valid" do
      expect(campaign.valid?).to be(false)
    end
  end
end
