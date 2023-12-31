class Invitation < ApplicationRecord
  has_noticed_notifications

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :collection

  validates :recipient, uniqueness: {scope: :collection, message: "has already been invited to this collection."}

  scope :pending, -> { where(accepted_at: nil) }

  after_create_commit :notify_recipient

  def accept(membership_class = Membership)
    update(accepted_at: DateTime.now)

    membership_class.create(
      collection: collection,
      member: recipient,
      role: :member
    )

    notifications_as_invitation.destroy_all
  end

  def message
    "#{sender.username} has invited you to their collection #{collection.name}."
  end

  def notify_recipient
    NewInvitationNotification.with(invitation: self).deliver_later(recipient)
  end
end
