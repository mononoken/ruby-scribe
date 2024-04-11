class MembershipJournalPolicy < ApplicationPolicy
  authorize :campaign, optional: true

  def create?
    member?
  end

  def destroy?
    allow! if owner?

    author?
  end

  private

  def owner?
    user.id == record.campaign.owner_id
  end

  def author?
    user.id == record.journal.author_id
  end

  def member?
    member_ids = campaign.members.map(&:id)
    member_ids.any? do |member_id|
      user.id == member_id
    end
  end
end
