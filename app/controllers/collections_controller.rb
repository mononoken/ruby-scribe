class CollectionsController < ApplicationController
  def new
    authorize!
    @collection = Collection.new
    @collection.memberships.build

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

  # def index
  #   @collections = current_user.collections
  #   authorize! @collections
  # end

  def show
    @collection = Collection.find(params[:id])
    authorize! @collection

    @invitation = @collection.invitations.build
  end

  private

  def collection_params
    params.require(:collection)
      .permit(:name, :owner_id,
        memberships_attributes:
          [:collection_id, :member_id, :journal_id])
  end
end
