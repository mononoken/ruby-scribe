class CommentPolicy < ApplicationPolicy
  authorize :note, optional: true

  def index?
    allowed_to?(:manage?, note)
  end

  def create?
    allowed_to?(:manage?, note)
  end

  def manage?
    author?
  end
end
