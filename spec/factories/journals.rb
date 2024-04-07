FactoryBot.define do
  factory :journal do
    # Use Tolkien generator for fun
    name { "#{Faker::Fantasy::Tolkien.character}'s Adventure" }
    author

    factory :journal_with_notes do
      transient do
        notes_count { 1 }
      end

      after(:create) do |journal, context|
        create_list(:note, context.notes_count, journal:)
      end
    end
  end
end
