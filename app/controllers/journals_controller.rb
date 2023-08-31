class JournalsController < ApplicationController
  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params.merge(user: current_user))

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
    @journal = Journal.find(params[:id])
  end

  def update
    @journal = Journal.find(params[:id])

    if @journal.update(journal_params)
      redirect_to journal_notes_path(@journal)
    else
      flash.now[:error] = @journal.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @journal = Journal.find(params[:id])
    @journal.destroy

    flash[:success] = "#{@journal.name} Journal successfully deleted."
    redirect_to journals_path
  end

  private

  def journal_params
    params.require(:journal).permit(:name, :user_id)
  end
end
