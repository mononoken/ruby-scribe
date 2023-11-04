class CommentPolicy < ApplicationPolicy
  authorize :note, optional: true

  default_rule :manage?

  def index?
    allowed_to?(:show?, note)
  end

  def new?
    create?
  end

  def create?
    allowed_to?(:show?, note)
  end

  def manage?
    author?
  end

  private

  def author?
    user.id == record.author_id
  end
end
