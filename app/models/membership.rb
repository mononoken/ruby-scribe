class Membership < ApplicationRecord
  belongs_to :collection
  belongs_to :member, class_name: "User"
  belongs_to :journal, optional: true

  enum :role, {owner: 0, admin: 1, member: 2}

  validates :member, uniqueness: {scope: :collection, message: "has already joined this collection."}
end
