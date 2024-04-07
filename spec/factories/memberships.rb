FactoryBot.define do
  factory :membership do
    campaign
    member
    role { :member }

    trait :with_journal do
      after(:create) do |membership, context|
        create(:membership_journal, membership:)
      end
    end
  end
end
