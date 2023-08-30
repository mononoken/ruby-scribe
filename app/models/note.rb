class Note < ApplicationRecord
  default_scope { order(updated_at: :desc) }

  belongs_to :journal
  belongs_to :user

  validates :name, presence: true, uniqueness: {scope: :user_id}
end
