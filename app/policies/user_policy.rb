class UserPolicy < ApplicationPolicy
  def show?
    user.present?
  end

  def manage?
    user.id = record.id
  end
end
