class MembershipJournal < ApplicationRecord
  belongs_to :membership
  belongs_to :journal

  has_one :member, through: :membership

  validates :journal, uniqueness: {scope: :membership}
  validate :member_owns_journal

  private

  def member_owns_journal
    return unless journal

    if journal.author != member
      errors.add(:journal, "is not authored by this member")
    end
  end
end
