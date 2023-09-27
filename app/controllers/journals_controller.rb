class JournalsController < ApplicationController
  before_action :set_journal, only: %i[edit update destroy]
  before_action :authorize!, only: %i[new index]

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params.merge(author: current_user))
    authorize! @journal

    if @journal.save
      redirect_to journal_notes_path(@journal)
    else
      flash.now[:error] = @journal.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @journals = current_user.journals
  end

  def edit
  end

  def update
    if @journal.update(journal_params)
      redirect_to journal_notes_path(@journal)
    else
      flash.now[:error] = @journal.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @journal.destroy

    flash[:success] = "#{@journal.name} Journal successfully deleted."
    redirect_to journals_path
  end

  private

  def set_journal
    @journal = Journal.find(params[:id])

    authorize! @journal
  end

  def journal_params
    params.require(:journal).permit(:name, :author_id)
  end
end
