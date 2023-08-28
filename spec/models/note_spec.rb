require "rails_helper"

RSpec.describe Note, type: :model do
  describe "dafault_scope" do
    it "orders notes in descending order" do
      note1 = create(:note)
      note2 = create(:note)
      note3 = create(:note)

      expect(Note.all).to eq([note3, note2, note1])
    end
  end
end
