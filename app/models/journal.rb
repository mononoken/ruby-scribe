class Journal < ApplicationRecord
  validates :name, presence: true

  belongs_to :author, class_name: "User"

  has_many :notes, dependent: :destroy
  has_many :collection_invitations, dependent: :destroy
end
