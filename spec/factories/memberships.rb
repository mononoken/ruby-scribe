FactoryBot.define do
  factory :membership do
    collection
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
