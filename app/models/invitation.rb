class Invitation < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :collection

  validates :recipient, uniqueness: {scope: :collection, message: "has already been invited to this collection."}

  scope :pending, -> { where(accepted_at: nil) }

  def accept(membership_class = Membership)
    update(accepted_at: DateTime.now)

    membership_class.create(collection: collection, member: recipient)
  end

  def message
    "#{sender.username} has invited you to their collection #{collection.name}."
  end
end
