class Invitation < ApplicationRecord
  has_noticed_notifications

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :campaign

  validates :recipient, uniqueness: {scope: :campaign, message: "has already been invited to this campaign."}

  scope :pending, -> { where(accepted_at: nil) }

  def accept(membership_class = Membership)
    update(accepted_at: DateTime.now)

    membership = membership_class.create(
      campaign: campaign,
      member: recipient,
      role: :member
    )

    cleanup if membership.valid?
  end

  def message
    "#{sender.username} has invited you to their campaign #{campaign.name}."
  end

  def notify_recipient
    NewInvitationNotification.with(invitation: self).deliver_later(recipient)
  end

  private

  def cleanup
    notifications_as_invitation.destroy_all
    destroy
  end
end
