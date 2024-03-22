FactoryBot.define do
  factory :membership do
    campaign
    journal { nil }
    member {
      if journal
        journal.author
      else
        association :user
      end
    }
    role { :member }
  end
end
