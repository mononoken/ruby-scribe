require "rails_helper"

RSpec.describe "customizing redcarpet", type: :system do
  describe "linking notes" do
    let!(:user) { create(:user) }
    let!(:journal) { create(:journal, author: user) }
    let!(:linked_note) { create(:note, journal:) }

    before do
      sign_in user
    end

    context "when note body includes note-link syntax" do
      let!(:viewed_note) {
        create(:note, journal:, body: "this links to [[#{linked_note.name}]]")
      }

      it "contains link to the target note's page" do
        visit note_path(viewed_note)

        expect(page).to have_link(href: note_path(linked_note))
      end
    end

    context "when note body includes multiple note-link syntax instances" do
      let!(:viewed_note) {
        create(:note, journal:,
          body: "this links to [[#{linked_note.name}]] and again [[#{linked_note.name}]]")
      }

      it "contains link to the target note's page" do
        visit note_path(viewed_note)

        expect(page).to have_link(href: note_path(linked_note), count: 2)
      end
    end
  end
end
