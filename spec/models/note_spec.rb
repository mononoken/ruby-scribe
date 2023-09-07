require "rails_helper"

RSpec.describe Note, type: :model do
  describe "default_scope" do
    it "orders notes in descending order" do
      note1 = create(:note)
      note2 = create(:note)
      note3 = create(:note)

      expect(Note.all).to eq([note3, note2, note1])
    end
  end

  describe "#valid?" do
    context "when note has already been taken by the user" do
      let(:existing_note) { create(:note) }
      subject(:duplicate_note) do
        create(:note, name: existing_note.name,
          author: existing_note.author)
      end

      it "raises an error" do
        expect { duplicate_note.valid? }.to raise_error(ActiveRecord::RecordInvalid) # Validation failed: Name has already been taken
      end
    end

    context "when note has already been taken by another user" do
      let(:other_user_note) { create(:note) }
      subject(:new_note) { create(:note, name: other_user_note.name) }

      it "is valid" do
        expect(new_note.valid?).to be(true)
      end
    end

    context "when note name is unused" do
      subject(:new_note) { create(:note) }

      it "is valid" do
        expect(new_note.valid?).to be(true)
      end
    end
  end
end
