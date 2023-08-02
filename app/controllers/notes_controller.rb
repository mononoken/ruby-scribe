class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to action: :index
    else
      flash.now[:error] = @note.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @notes = Note.all
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end
end
