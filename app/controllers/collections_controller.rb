class CollectionsController < ApplicationController
  def new
    @collection = Collection.new
    @journals = current_user.journals
    # @journals = @collection.potential_journals
  end
end
