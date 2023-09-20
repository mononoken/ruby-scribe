class CollectionsController < ApplicationController
  def new
    @collection = Collection.new
    @collection.collection_invitations.build

    @journals = current_user.journals
  end

  def create
    @collection = Collection.new(collection_params)

    if @collection.save
      redirect_to @collection
    else
      flash.now[:error] = @collection.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @collections = current_user.collections
  end

  def show
    @collection = Collection.find(params[:id])
  end

  private

  def collection_params
    params.require(:collection)
      .permit(:name,
        collection_invitations_attributes:
          [:collection_id, :journal_id, :accepted_at])
  end
end
