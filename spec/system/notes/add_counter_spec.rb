require "rails_helper"

RSpec.describe "Counter", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when user has existing note" do
    let!(:note) { create(:note, author: user) }
    let(:counter) { build(:counter, note:) }

    xit "shows button to add counter" do
      visit note_path(note)
      click_button "counter-toggle-btn"

      within "[data-testid='counter-form']" do
        fill_in "new_counter-label-input", with: counter.label
      end
      sleep 0.5
      click_button "new_counter-save-btn"

      expect(page).to have_content(counter.label)
      expect(page).to have_content(counter.label)
    end
  end
end
