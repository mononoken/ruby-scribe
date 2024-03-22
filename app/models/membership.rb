class Membership < ApplicationRecord
  belongs_to :campaign
  belongs_to :member, class_name: "User"
  belongs_to :journal, optional: true

  enum :role, {owner: 0, admin: 1, member: 2}

  validates :member, uniqueness:
    {scope: :campaign, message: "has already joined this campaign."}

  validate :member_owns_journal

  private

  def member_owns_journal
    return unless journal

    if journal.author != member
      errors.add(:journal, "is not authored by this member")
    end
  end
end
