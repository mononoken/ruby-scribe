# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, Journal, author_id: user.id
    can :manage, Note, journal: {author_id: user.id}
  end
end
