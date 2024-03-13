class CountersController < ApplicationController
  skip_verify_authorized

  before_action :set_note, only: %i[index new create]
  before_action :set_counter, only: %i[edit update destroy show increment]

  def index
    @counters = @note.counters.order(created_at: :desc)
  end

  def new
    @counter = @note.counters.build
  end

  def create
    @counter = @note.counters.build(counter_params)

    respond_to do |format|
      if @counter.save
        format.turbo_stream do
          @counter.broadcast_prepend_to(
            [@note, :counters],
            target: helpers.dom_id(@note, :counters)
          )

          @counter = @note.counters.build
        end
        format.html { redirect_to @note }
      else
        format.turbo_stream {}
        format.html do
          flash.now[:error] = @counter.errors.full_messages
          redirect_to @note, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @counter.destroy

    respond_to do |format|
      format.turbo_stream { @counter.broadcast_remove }
      format.html do
        flash[:success] = "counter successfully deleted."
        redirect_to note_counters_path(@counter.note)
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @counter.update(counter_params)
        format.turbo_stream { @counter.broadcast_replace }
        format.html { redirect_to @counter }
      else
        format.turbo_stream { @counter.broadcast_replace }
        format.html do
          flash.now[:error] = @counter.errors.full_messages
          redirect_to @note, status: :unprocessable_entity
        end
      end
    end
  end

  def increment
    respond_to do |format|
      if @counter.increment!(:count)
        format.turbo_stream { @counter.broadcast_replace }
        format.html { redirect_to @counter }
      else
        format.turbo_stream { @counter.broadcast_replace }
        format.html do
          flash.now[:error] = @counter.errors.full_messages
          redirect_to @note, status: :unprocessable_entity
        end
      end
    end
  end

  def decrement
  end

  private

  def set_note
    @note = Note.find(params[:note_id])

    # authorize! context: {note: @note}
  end

  def set_counter
    @counter = Counter.find(params[:id])

    # authorize! @counter
  end

  def counter_params
    params.require(:counter).permit(:label, :count)
  end
end
