class NotesController < ApplicationController
  before_action :get_journal, only: %i[new create index]

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

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    flash[:success] = "Note successfully deleted."
    redirect_to journal_notes_path(@note.journal)
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])

    if @note.update(note_params)
      redirect_to @note
    else
      flash.now[:error] = @note.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @note = Note.new
    @notes = @journal.notes
  end

  def show
    @note = Note.find(params[:id])
  end

  private

  def get_journal
    @journal = Journal.find(params[:journal_id])
  end

  def note_params
    params.require(:note).permit(:body, :journal_id)
  end
end
