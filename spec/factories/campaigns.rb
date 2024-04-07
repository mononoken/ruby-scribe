FactoryBot.define do
  factory :campaign do
    owner
    name { "#{owner.username}'s Party" }

    memberships {
      [
        association(:membership,
          campaign: instance,
          member: owner,
          role: :owner)
      ]
    }

    trait :with_owner_journal do
      memberships {
        [
          association(:membership,
            :with_journal,
            campaign: instance,
            member: owner,
            role: :owner)
        ]
      }
    end
  end
end
