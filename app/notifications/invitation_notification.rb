class InvitationNotification < Noticed::Base
  # Add your delivery methods
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  param :invitation

  # Define helper methods to make rendering easier.
  def message
    t(".message")
  end

  def url
    invitation_path(params[:invitation])
  end
end
