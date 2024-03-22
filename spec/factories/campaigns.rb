FactoryBot.define do
  factory :campaign do
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

    after(:build) do |campaign, context|
      create(:membership,
        campaign: campaign,
        member: campaign.owner,
        journal: context.owner_journal,
        role: :owner)
    end
  end
end

def campaign_with_members(members:, owner: FactoryBot.create(:user),
  name: "#{owner.username}'s Party")
  FactoryBot.create(:campaign, name:, owner:) do |campaign|
    members.each do |member|
      FactoryBot.create(:membership, member: member,
        campaign:, role: :member)
    end
  end
end

def campaign_with_journals(journals:, owner: journals.first.author,
  name: "#{owner.username}'s Party", owner_journal: journals.first)
  FactoryBot.create(:campaign, :with_owner_journal,
    name:, owner:, owner_journal:) do |campaign|
    journals.each do |journal|
      next if journal.author == owner

      FactoryBot.create(:membership, journal:, member: journal.author,
        campaign:, role: :member)
    end
  end
end
