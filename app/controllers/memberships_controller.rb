class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[destroy]

  def destroy
    @membership.destroy

    flash[:success] = "You successfully left #{@membership.campaign.name}."
    redirect_to campaigns_path
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])

    authorize! @membership
  end
end
