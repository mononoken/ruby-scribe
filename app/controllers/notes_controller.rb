class NotesController < ApplicationController
  before_action :get_journal

  def new
    @note = @journal.notes.build
  end

  def create
    @note = @journal.notes.build(note_params)

    if @note.save
      redirect_to action: :index
    else
      flash.now[:error] = @note.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @notes = @journal.notes
  end

  private

  def get_journal
    @journal = Journal.find(params[:journal_id])
  end

  def note_params
    params.require(:note).permit(:body, :journal_id)
  end
end
