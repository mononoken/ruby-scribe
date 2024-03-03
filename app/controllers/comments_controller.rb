class CommentsController < ApplicationController
  before_action :set_note, only: %i[index new create]
  before_action :set_comment, only: %i[edit update destroy show]

  def index
    @comments = @note.comments.desc
  end

  def new
    @comment = @note.comments.build
  end

  def create
    @comment = @note.comments.build(comment_params.merge(author: current_user))

    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          @comment.broadcast_prepend_to(
            [@note, :comments],
            target: helpers.dom_id(@note, :comments)
          )

          @comment = @note.comments.build
        end
        format.html { redirect_to @note }
      else
        format.turbo_stream {}
        format.html do
          flash.now[:error] = @comment.errors.full_messages
          redirect_to @note, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.turbo_stream { @comment.broadcast_remove }
      format.html do
        flash[:success] = "Comment successfully deleted."
        redirect_to note_comments_path(@comment.note)
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream { @comment.broadcast_replace }
        format.html { redirect_to @comment }
      else
        format.turbo_stream { @comment.broadcast_replace }
        format.html do
          flash.now[:error] = @comment.errors.full_messages
          redirect_to @note, status: :unprocessable_entity
        end
      end
    end
  end

  def show
  end

  private

  def set_note
    @note = Note.find(params[:note_id])

    authorize! context: {note: @note}
  end

  def set_comment
    @comment = Comment.find(params[:id])

    authorize! @comment
  end

  def comment_params
    params.require(:comment).permit(:body, :author_id, :note_id)
  end
end
