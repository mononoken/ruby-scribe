class Users::InvitationsController < Users::ApplicationController
  before_action :set_invitation, only: %i[accept show]

  def accept
    @invitation.accept

    redirect_to @invitation.campaign
  end

  def index
    @invitations = Invitation.pending.where(recipient_id: current_user.id)
    authorize! @invitations
  end

  def show
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])

    authorize! @invitation
  end

  def invitation_params
    params.require(:invitation).permit(:sender_id, :recipient_id,
      :campaign_id)
  end
end
