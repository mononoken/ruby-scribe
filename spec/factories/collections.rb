FactoryBot.define do
  factory :collection do
    name { "#{owner.username}'s Party" }
    owner
  end
end

def collection_with_journals(journals:, owner: journals.first.author, name: "#{owner.username}'s Party")
  FactoryBot.create(:collection, name:, owner:) do |collection|
    journals.each do |journal|
      FactoryBot.create(:invitation, journal:, collection:, accepted_at: DateTime.now)
    end
  end
end
