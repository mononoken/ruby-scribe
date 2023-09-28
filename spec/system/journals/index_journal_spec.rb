require "rails_helper"

RSpec.describe "indexing journals", type: :system do
  let!(:user) { create(:user) }
  let!(:journal1) { create(:journal, author: user) }
  let!(:journal2) { create(:journal, author: user) }

  before do
    sign_in user
  end

  describe "journal index" do
    it "shows link to each of the user's journal's notes" do
      visit journals_path

      [journal1, journal2].each do |journal|
        within "[data-testid='journals-list']" do
          expect(page).to have_link(href: journal_notes_path(journal))
        end
      end
    end
  end
end
