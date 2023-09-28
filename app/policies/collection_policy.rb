class CollectionPolicy < ApplicationPolicy
  default_rule :manage?

  # def index?
  #   user.present?
  # end

  def new?
    user.present?
  end

  def create?
    owner?
  end

  def manage?
    owner?
  end

  private

  def owner?
    user.id == record.owner_id
  end

  # def manager?
  #   record.managers.any?(user)
  # end
end
