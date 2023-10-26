class UsersController < ApplicationController
  def show
    @invitations = Invitation.pending.where(recipient_id: current_user.id)
    authorize! context: {invitations: @invitations}
  end
end
