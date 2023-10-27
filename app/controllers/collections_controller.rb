class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[show edit update destroy]

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

  def index
    @collections = current_user.collections
    authorize! @collections
  end

  def show
    @invitation = @collection.invitations.build
    @membership = Membership.find_by(
      member: current_user, collection: @collection
    )
  end

  def edit
  end

  def update
    if @collection.update(collection_params)
      redirect_to @collection
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @collection.destroy

    flash[:success] = "Collection successfully deleted."
    redirect_to collections_path, status: :see_other
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])

    authorize! @collection
  end

  def collection_params
    params.require(:collection)
      .permit(:name, :owner_id,
        memberships_attributes:
          [:collection_id, :member_id, :journal_id])
  end
end
