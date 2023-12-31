class NewInvitationNotification < Noticed::Base
  # Add your delivery methods
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  param :invitation

  # Define helper methods to make rendering easier.
  def message
    t(".message", collection:, sender:)
  end

  def url
    users_invitations_path
  end

  def invitation
    params[:invitation]
  end

  private

  def collection
    invitation.collection.name
  end

  def sender
    invitation.sender.username
  end
end
