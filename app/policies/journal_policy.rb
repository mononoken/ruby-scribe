class JournalPolicy < ApplicationPolicy
  default_rule :manage?
  alias_rule :index?, :create?, to: :manage?

  def manage?
    author?
  end

  # def new?
  #   true
  # end

  private

  def author?
    user.id == record.author_id
  end
end
