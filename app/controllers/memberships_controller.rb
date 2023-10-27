class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[destroy]

  def destroy
    @membership.destroy

    flash[:success] = "You successfully left #{@membership.collection.name}."
    redirect_to collections_path
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])

    authorize! @membership
  end
end
