FactoryBot.define do
  factory :journal do
    # Use Tolkien generator for fun
    name { "#{Faker::Fantasy::Tolkien.character}'s Adventure" }
    author
  end
end
