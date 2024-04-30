FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence(word_count: rand(1..10)) }
    note
    author { @overrides[:note]&.author || association(:author) }
  end
end
