class Collection < ApplicationRecord
  has_many :collection_invitations, dependent: :destroy
end
