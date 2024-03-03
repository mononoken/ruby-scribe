class Counter < ApplicationRecord
  belongs_to :note

  scope :persisted, -> { where.not(id: nil) }

  def increment!
    self.count += 1
  end

  def decrement!
    self.count -= 1
  end
end
