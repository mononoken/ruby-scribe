require "rails_helper"

RSpec.describe Journal, type: :model do
  # Delete if failing
  context "when journal has a name" do
    subject(:journal) { create(:journal) }

    context "when journal has a user" do
      let(:user) { create(:user) }

      subject(:journal) do
        described_class.new(name: "Test Journal", user:)
      end

      it "is valid" do
        expect(journal.valid?).to be(true)
      end
    end
  end

  # Delete if failing
  context "when journal has no name" do
    subject(:journal) { described_class.new(name: nil) }

    it "is not valid" do
      expect(journal.valid?).to be(false)
    end
  end
end
