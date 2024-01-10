module Collections
  class InvitationsController < Collections::ApplicationController
    before_action :set_invitation, only: %i[destroy]

    def new
      @invitation = Invitation.new
    end

    def create
      @invitation = Invitation.new(invitation_params)

      if @invitation.save
        @invitation.notify_recipient

        flash[:success] = "You invited #{@invitation.recipient.username} to your collection #{@invitation.collection.name}."
        redirect_to collection_invitations_path(@collection)
      else
        flash.now[:error] = @invitation.errors.full_messages
        render :new, status: :unprocessable_entity
      end
    end

    def index
      @invitations = Invitation.where(collection_id: @collection.id)
    end

    def destroy
      @invitation.destroy

      flash[:success] = "Invitation successfully deleted."
      redirect_to collection_invitations_path(@invitation.collection)
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
end
