FactoryBot.define do
  factory :campaign do
    # Use Tolkien generator for fun
    name { "#{Faker::Fantasy::Tolkien.character}'s Adventure" }
    user
  end
end
