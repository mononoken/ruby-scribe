FactoryBot.define do
  factory :collection do
    owner
    name { "#{owner.username}'s Party" }

    transient do
      owner_journal { nil }
    end

    trait :with_owner_journal do
      transient do
        owner_journal { build(:journal, author: owner) }
      end
    end

    after(:build) do |collection, context|
      create(:membership,
        collection: collection,
        member: collection.owner,
        journal: context.owner_journal,
        role: :owner)
    end
  end
end

def collection_with_members(members:, owner: FactoryBot.create(:user),
  name: "#{owner.username}'s Party")
  FactoryBot.create(:collection, name:, owner:) do |collection|
    members.each do |member|
      FactoryBot.create(:membership, member: member,
        collection:, role: :member)
    end
  end
end

def collection_with_journals(journals:, owner: journals.first.author,
  name: "#{owner.username}'s Party", owner_journal: journals.first)
  FactoryBot.create(:collection, :with_owner_journal,
    name:, owner:, owner_journal:) do |collection|
    journals.each do |journal|
      next if journal.author == owner

      FactoryBot.create(:membership, journal:, member: journal.author,
        collection:, role: :member)
    end
  end
end
