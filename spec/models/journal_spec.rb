require "rails_helper"

RSpec.describe Journal, type: :model do
  describe "#notes" do
    context "when journal has notes and is deleted" do
      let!(:journal) { create(:journal) }
      let!(:note) { create(:note, journal: journal, author: journal.author) }

      # Delete if failing
      it "destroys all associated notes" do
        expect { journal.destroy }.to change { Note.count }
          .by(-1)
      end
    end
  end

  describe "#valid?" do
    context "when journal has a name" do
      subject(:journal) { create(:journal) }

      context "when journal has a user" do
        let(:user) { create(:user) }

        subject(:journal) do
          described_class.new(name: "Test Journal", author: user)
        end

        # Delete if failing
        it "is valid" do
          expect(journal.valid?).to be(true)
        end
      end
    end

    context "when journal has no name" do
      subject(:journal) { described_class.new(name: nil) }

      # Delete if failing
      it "is not valid" do
        expect(journal.valid?).to be(false)
      end
    end
  end
end
