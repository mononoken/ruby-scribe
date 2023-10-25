class Collections::ApplicationController < ApplicationController
  before_action :set_collection, only: %i[index new create]

  def set_collection
    @collection = Collection.find(params[:collection_id])

    authorize! context: {collection: @collection}
  end
end
