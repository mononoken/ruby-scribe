class CollectionsController < ApplicationController
  def index
    # @collections = current_user.collections
    # authorize! @collections
  end

  def new
    authorize!
    @collection = Collection.new
    @collection.invitations.build(accepted_at: DateTime.now)

    @journals = current_user.journals
  end

  def create
    @collection = Collection.new(collection_params.merge(owner: current_user))
    authorize! @collection

    if @collection.save
      redirect_to @collection
    else
      flash.now[:error] = @collection.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @collection = Collection.find(params[:id])
    authorize! @collection
  end

  private

  def collection_params
    params.require(:collection)
      .permit(:name, :owner_id,
        invitations_attributes:
          [:collection_id, :journal_id, :accepted_at])
  end
end
