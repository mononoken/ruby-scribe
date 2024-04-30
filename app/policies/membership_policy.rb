class MembershipPolicy < ApplicationPolicy
  def manage?
    member?
  end

  private

  def member?
    user.id == record.member_id
  end
end
