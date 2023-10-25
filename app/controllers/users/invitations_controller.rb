class Users::InvitationsController < Users::ApplicationController
  before_action :set_invitation, only: %i[accept]

  def accept
    @invitation.accept

    redirect_to @invitation.collection
  end

  def index
    @invitations = Invitation.where(recipient_id: current_user.id)
    authorize! @invitations
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])

    authorize! @invitation
  end

  def invitation_params
    params.require(:invitation).permit(:sender_id, :recipient_id,
      :collection_id)
  end
end
