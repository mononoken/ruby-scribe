module Campaigns
  class InvitationsController < Campaigns::ApplicationController
    before_action :set_invitation, only: %i[destroy]

    def new
      @invitation = Invitation.new
    end

    def create
      @invitation = Invitation.new(invitation_params)

      if @invitation.save
        @invitation.notify_recipient

        flash[:success] = "You invited #{@invitation.recipient.username} to your campaign #{@invitation.campaign.name}."
        redirect_to campaign_invitations_path(@campaign)
      else
        flash.now[:error] = @invitation.errors.full_messages
        render :new, status: :unprocessable_entity
      end
    end

    def index
      @invitations = Invitation.where(campaign_id: @campaign.id)
    end

    def destroy
      @invitation.destroy

      flash[:success] = "Invitation successfully deleted."
      redirect_to campaign_invitations_path(@invitation.campaign)
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
end
