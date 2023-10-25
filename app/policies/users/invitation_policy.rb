module Users
  class InvitationPolicy < Users::ApplicationPolicy
    default_rule :manage?

    def accept?
      user.id == record.recipient.id
    end

    def index?
      record.all? do |item|
        item.recipient.id == user.id
      end
    end

    def manage?
      false
    end
  end
end
