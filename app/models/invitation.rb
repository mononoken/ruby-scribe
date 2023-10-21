class Invitation < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :collection

  validates :collection, uniqueness: {scope: :recipient, message: "User has already been invited to this collection."}
end
