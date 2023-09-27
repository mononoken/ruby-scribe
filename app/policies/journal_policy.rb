class JournalPolicy < ApplicationPolicy
  default_rule :manage?

  def index?
    user.present?
  end

  def new?
    user.present?
  end

  def create?
    author?
  end

  def manage?
    author?
  end

  private

  def author?
    user.id == record.author_id
  end
end
