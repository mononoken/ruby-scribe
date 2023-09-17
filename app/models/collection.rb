class Collection < ApplicationRecord
  has_many :collection_invitations, dependent: :destroy
  has_many :journals, through: :collection_invitations
end
