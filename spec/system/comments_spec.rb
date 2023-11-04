require "rails_helper"

RSpec.describe "comments", type: :system do
  describe "creating comments" do
    let!(:user) { create(:user) }
    let!(:note) { create(:note, author: user) }

    before do
      sign_in user
    end

    context "when user is viewing note page" do
      before do
        visit note_path(note)
      end

      it "has link/button to create comment" do
        expect(page).to have_button("comment-save-btn")
      end

      it "has the new comment input" do
        expect(page).to have_field("comment-body-input")
      end

      context "when user creates comment" do
        let(:comment_input) { "first!!" }

        before do
          fill_in "comment-body-input", with: comment_input
          click_button "comment-save-btn"
        end

        it "shows new comment on the note page" do
          expect(page).to have_content(comment_input)
        end

        it "shows indicator that note has comments on the journal notes page" do
          pending "Implement comment indicator"
          # visit journal_notes_path(note.journal)

          # How should this be checked? What would indicator look like?
          # expect(page).to have_content()
        end
      end
    end
  end
end
