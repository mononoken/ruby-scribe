class Collection < ApplicationRecord
  has_many :collection_invitations, dependent: :destroy
  has_many :journals, through: :collection_invitations

  accepts_nested_attributes_for :collection_invitations
end
