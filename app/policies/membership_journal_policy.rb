class MembershipJournalPolicy < ApplicationPolicy
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
end
