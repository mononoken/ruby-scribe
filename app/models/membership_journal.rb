class MembershipJournal < ApplicationRecord
  belongs_to :membership
  belongs_to :journal

  validates :journal, uniqueness: {scope: :membership}
end
