class NotificationPolicy < ApplicationPolicy
  # Use default_rule if more rules are necessary beyond destroy?
  # default_rule :manage?

  def index?
    record.all? do |notification|
      recipient?(notification)
    end
  end

  def destroy?
    recipient?
  end

  private

  def recipient?(notification = record)
    user.id == notification.recipient_id
  end
end
