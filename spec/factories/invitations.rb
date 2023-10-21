FactoryBot.define do
  factory :invitation do
    sender
    recipient
    collection { build(:collection, owner: sender) }
    accepted_at { nil }
  end
end
