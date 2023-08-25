class JournalsController < ApplicationController
  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params)
    @journal.user = current_user

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

  private

  def journal_params
    params.require(:journal).permit(:name, :user_id)
  end
end
