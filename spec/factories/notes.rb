FactoryBot.define do
  factory :note do
    name { Faker::Lorem.sentence(word_count: rand(1..4)) }
    body { Faker::Lorem.paragraph }
    author { @overrides[:journal]&.author || association(:author) }
    journal { association :journal, author: author }
  end
end
