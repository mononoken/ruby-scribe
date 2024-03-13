class Counter < ApplicationRecord
  belongs_to :note

  scope :persisted, -> { where.not(id: nil) }
end
