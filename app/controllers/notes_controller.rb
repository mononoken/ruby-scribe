class NotesController < ApplicationController
  before_action :set_journal, only: %i[index new create]
  before_action :set_note, only: %i[edit update destroy show]

  def index
    @note = Note.new
    @q = @journal.notes.ransack(params[:q])
    @notes = @q.result(distinct: true)
  end

  def new
    @note = @journal.notes.build
  end

  def create
    @note = @journal.notes.build(note_params.merge(author: current_user))

    if @note.save
      redirect_to action: :index
    else
      flash.now[:error] = @note.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy

    respond_to do |format|
      format.turbo_stream { @note.broadcast_remove }
      format.html do
        flash[:success] = "Note successfully deleted."
        redirect_to journal_notes_url(@note.journal)
      end
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to @note
    else
      flash.now[:error] = @note.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @journal = @note.journal
    @comments = @note.comments
    @counters = @note.counters.persisted
    @new_counter = @note.counters.build
  end

  private

  def set_journal
    @journal = Journal.find(params[:journal_id])

    authorize! context: {journal: @journal}
  end

  def set_note
    @note = Note.find(params[:id])

    authorize! @note
  end

  def note_params
    params.require(:note).permit(:name, :body, :journal_id, :user_id)
  end
end
