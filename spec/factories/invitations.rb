FactoryBot.define do
  factory :invitation do
    sender
    recipient
    campaign { build(:campaign, owner: sender) }
    accepted_at { nil }
  end
end
