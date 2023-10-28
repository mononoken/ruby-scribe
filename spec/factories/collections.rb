FactoryBot.define do
  factory :collection do
    name { "#{owner.username}'s Party" }
    owner
  end
end

def collection_with_members(members:, owner: FactoryBot.create(:user),
  name: "#{owner.username}'s Party")
  FactoryBot.create(:collection, name:, owner:) do |collection|
    members.each do |member|
      FactoryBot.create(:membership, member: member,
        collection:)
    end
  end
end

def collection_with_journals(journals:, owner: journals.first.author,
  name: "#{owner.username}'s Party")
  FactoryBot.create(:collection, name:, owner:) do |collection|
    journals.each do |journal|
      FactoryBot.create(:membership, journal:, member: journal.author,
        collection:)
    end
  end
end
