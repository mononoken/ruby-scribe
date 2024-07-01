class Comment < ApplicationRecord
  belongs_to :note, touch: true, counter_cache: true
  belongs_to :author, class_name: "User"

  scope :desc, -> { order(created_at: :desc) }

  validates :body, length: {minimum: 2}
end
