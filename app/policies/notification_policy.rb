class NotificationPolicy < ApplicationPolicy
  def index?
    record.all? do |notification|
      user.id == notification.recipient_id
    end
  end
end
