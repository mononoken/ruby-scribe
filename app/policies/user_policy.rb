class UserPolicy < ApplicationPolicy
  authorize :invitations, optional: true

  def show?
    allowed_to?(:index?, invitations, namespace: Users)
  end
end
