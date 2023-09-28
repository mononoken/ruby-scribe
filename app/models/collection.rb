class Collection < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :invitations, dependent: :destroy
  has_many :journals, through: :invitations
  has_many :authors, through: :journals, class_name: "User"

  accepts_nested_attributes_for :invitations
end
