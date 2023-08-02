require "rails_helper"

RSpec.describe "creating journals", type: :system do
  context "when user is creating their first journal" do
    let(:journal) { create(:journal) }

    before do
      sign_in journal.user
    end

    it "shows the new journal title in the journal index" do
      visit root_path
      fill_in "Name", with: journal.name
      click_button "Create"

      expect(page).to have_text(journal.name)
    end

    context "when user does not enter a journal title and submits" do
      let(:error_msg) { "Name can't be blank" }

      it "shows an error" do
        visit root_path
        click_button "Create"

        expect(page).to have_text(error_msg)
      end
    end
  end
end
