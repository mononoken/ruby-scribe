class MembershipPolicy < ApplicationPolicy
  default_rule :manage?

  def manage?
    member?
  end

  private

  def member?
    user.id == record.member_id
  end
end
