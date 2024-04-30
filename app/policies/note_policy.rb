class NotePolicy < ApplicationPolicy
  authorize :journal, optional: true

  def index?
    allowed_to?(:manage?, journal)
  end

  def create?
    allowed_to?(:manage?, journal)
  end

  def manage?
    author?
  end
end
