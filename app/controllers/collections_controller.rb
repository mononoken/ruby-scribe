class CollectionsController < ApplicationController
  def new
    @collection = Collection.new
    @journals = current_user.available_journals
    # @journals = @collection.potential_journals
  end
end
