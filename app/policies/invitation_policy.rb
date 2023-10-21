class InvitationPolicy < ApplicationPolicy
  authorize :collection, optional: true

  default_rule :manage?

  def index?
    allowed_to?(:manage?, collection)
  end

  def new?
    create?
  end

  def create?
    allowed_to?(:manage?, collection)
  end

  def manage?
    sender?
  end

  private

  def sender?
    user.id == record.sender_id
  end
end
