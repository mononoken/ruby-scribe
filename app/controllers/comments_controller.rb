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

    if @comment.save
      redirect_to @note
    else
      flash.now[:error] = @comment.errors.full_messages
      redirect_to @note, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    flash[:success] = "Comment successfully deleted."
    # redirect_to note_comments_path(@comment.note)
    redirect_to @comment.note
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.note
    else
      flash.now[:error] = @comment.errors.full_messages
      redirect_to @comment.note, status: :unprocessable_entity
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
