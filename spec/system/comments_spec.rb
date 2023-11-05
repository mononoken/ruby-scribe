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
        expect(page).to have_button("new_comment-save-btn")
      end

      it "has the new comment input" do
        expect(page).to have_field("new_comment-body-input")
      end

      context "when user creates comment" do
        let(:comment_input) { "first!!" }

        before do
          fill_in "new_comment-body-input", with: comment_input
          click_button "new_comment-save-btn"
        end

        it "shows new comment on the note page" do
          expect(page).to have_content(comment_input)
        end
      end
    end
  end

  describe "destroying comments" do
    let!(:user) { create(:user) }
    let!(:note) { create(:note, author: user) }

    before do
      sign_in user
    end

    context "when user is viewing note page with one comment" do
      let!(:comment) { create(:comment, author: user, note: note) }

      before do
        visit note_path(note)
      end

      context "when user clicks destroy comment button" do
        before do
          accept_alert do
            click_button "comment_#{comment.id}-destroy-btn"
          end
        end

        it "does not show comment body on note page" do
          expect(page).not_to have_content(comment.body)
        end
      end
    end

    context "when user is viewing note page with multiple comments" do
      let!(:other_comment) { create(:comment, note: note) }
      let!(:user_comment) { create(:comment, author: user, note: note) }
      let!(:another_comment) { create(:comment, note: note) }

      before do
        visit note_path(note)
      end

      context "when user clicks destroy comment button for their comment" do
        before do
          accept_alert do
            click_button "comment_#{user_comment.id}-destroy-btn"
          end
        end

        it "does not show comment body on note page" do
          expect(page).not_to have_content(user_comment.body)
        end
      end
    end
  end
end
