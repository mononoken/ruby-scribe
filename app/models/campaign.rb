class Campaign < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, class_name: "User"
  has_many :journals, through: :memberships
  has_many :authors, through: :journals, class_name: "User"
  has_many :invitations, dependent: :destroy

  accepts_nested_attributes_for :memberships
end
