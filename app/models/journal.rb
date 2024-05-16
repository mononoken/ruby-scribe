class Journal < ApplicationRecord
  belongs_to :author, class_name: "User"

  has_many :notes, dependent: :destroy
  has_many :membership_journals
  has_many :memberships, through: :membership_journals
  has_many :campaigns, through: :memberships

  validates :name, presence: true

  broadcasts_refreshes
end
