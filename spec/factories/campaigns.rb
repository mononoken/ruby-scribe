FactoryBot.define do
  factory :campaign do
    name { "#{Faker::Fantasy::Tolkien.character}'s Adventure" }
    # need to add user here when I have internet to look at FactoryBot docs
  end
end
