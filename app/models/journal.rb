class Journal < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :notes, dependent: :destroy
end
