FactoryBot.define do
  factory :campaign do
    name { "#{Faker::Fantasy::Tolkien.character}'s Adventure" }
  end
end
