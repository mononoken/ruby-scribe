FactoryBot.define do
  factory :notification do
    recipient { user }
    type { "" }
    params { "" }
    read_at { "2023-12-08 23:31:33" }
  end
end
