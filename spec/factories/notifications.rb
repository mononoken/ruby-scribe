FactoryBot.define do
  factory :notification do
    recipient
    type { "" }
    params { "" }
    read_at { nil }

    factory :invitation_notification do
      transient do
        invitation { create(:invitation, recipient: recipient) }
      end

      type { "NewInvitationNotification" }
      params { {invitation: invitation} }
    end
  end
end
