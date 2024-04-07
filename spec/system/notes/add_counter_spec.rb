require "rails_helper"

RSpec.describe "Counter", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user has existing note" do
    let!(:note) { create(:note, author: user) }
    let(:counter) { build(:counter) }

    xit "shows button to add counter" do
      visit note_path(note)
      click_button "counter-create-btn"

      expect(page).to have_content("New counter")
    end

    context "when incrementable exists" do
      # let!(:incrementable) { create(:incrementable, note:) }

      it "should have button to increment"
      it "should have button to decrement"
    end
  end
end
