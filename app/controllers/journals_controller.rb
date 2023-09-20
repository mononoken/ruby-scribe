class JournalsController < ApplicationController
  load_and_authorize_resource :journal

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params.merge(author: current_user))

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

  def journal_params
    params.require(:journal).permit(:name, :author_id)
  end
end
