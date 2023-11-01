class Note < ApplicationRecord
  default_scope { order(updated_at: :desc) }

  belongs_to :journal
  belongs_to :author, class_name: "User"

  has_many :comments

  validates :name, presence: true, uniqueness: {scope: :author_id}
end
