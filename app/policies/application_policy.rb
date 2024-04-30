# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  # Configure additional authorization contexts here
  # (`user` is added by default).
  #
  # Action Policy defaults https://actionpolicy.evilmartians.io/#/aliases?id=default-rule
  #
  # default_rule :manage?
  # alias_rule :new?, to: :create?
  # def index?() = false
  # def create?() = false
  # def manage?() = false

  private

  def author?
    user.id == record.author_id
  end
end
