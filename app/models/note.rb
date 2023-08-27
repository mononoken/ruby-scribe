class Note < ApplicationRecord
  default_scope { order(updated_at: :desc) }

  belongs_to :journal
end
