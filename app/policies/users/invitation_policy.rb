module Users
  class InvitationPolicy < Users::ApplicationPolicy
    default_rule :manage?
    alias_rule :accept?, to: :manage?

    def index?
      record.all? do |item|
        item.recipient.id == user.id
      end
    end

    def manage?
      recipient?
    end

    private

    def recipient?
      user.id == record.recipient.id
    end
  end
end
