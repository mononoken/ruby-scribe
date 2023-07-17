FactoryBot.define do
  factory :note do
    title { Faker::Lorem.sentence(word_count: rand(1..8)) }
    body { Faker::Lorem.paragraph }
  end
end
