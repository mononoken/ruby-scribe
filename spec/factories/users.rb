FactoryBot.define do
  factory :user, aliases: [:author] do
    sequence(:email) { |n| "user#{n}@example.com" }
    username { Faker::Name.first_name + rand(0..99).to_s }
    password { Faker::Internet.password }
  end
end
