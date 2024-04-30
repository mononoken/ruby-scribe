class NotePolicy < ApplicationPolicy
  authorize :journal, optional: true

  def index?
    allowed_to?(:show?, journal)
  end

  def new?
    create?
  end

  def create?
    allowed_to?(:show?, journal)
  end

  def manage?
    author?
  end
end
