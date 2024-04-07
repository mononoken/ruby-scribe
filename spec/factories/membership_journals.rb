FactoryBot.define do
  factory :membership_journal do
    membership
    journal { association(:journal, author: membership.member) }
  end
end
