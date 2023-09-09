class CollectionsController < ApplicationController
  def new
    @collection = Collection.new
    @journals = @collection.potential_journals
  end
end
