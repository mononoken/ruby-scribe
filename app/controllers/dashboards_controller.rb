class DashboardsController < ApplicationController
  def show
    @invitations = Invitation.pending.where(recipient_id: current_user.id)
    authorize! :dashboard, context: {invitations: @invitations}
  end
end
