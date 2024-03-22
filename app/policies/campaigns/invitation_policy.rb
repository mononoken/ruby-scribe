module Campaigns
  class InvitationPolicy < Campaigns::ApplicationPolicy
    authorize :campaign, optional: true

    default_rule :manage?

    def index?
      allowed_to?(:manage?, campaign)
    end

    def new?
      create?
    end

    def create?
      allowed_to?(:manage?, campaign)
    end

    def manage?
      sender?
    end

    private

    def sender?
      user.id == record.sender_id
    end
  end
end
