require "rails_helper"

RSpec.describe MembershipJournalPolicy, type: :policy do
  let(:user) { build_stubbed :user }
  let(:record) { create :membership_journal }
  let(:context) { {user:} }

  describe "new?" do
    let(:policy) { described_class.new(record, user:) }

    it "is an alias of :create? rule" do
      expect(:new?).to be_an_alias_of(policy, :create?)
    end
  end

  describe_rule :create? do
    let(:context) { {user:, campaign: record.campaign} }

    succeed "when user is owner of campaign" do
      let(:user) { record.campaign.owner }
    end

    succeed "when user is member of campaign" do
      let(:user_membership) {
        create :membership, campaign: record.campaign, member: user
      }
      let(:user) { record.campaign.owner }
    end

    failed "when user is not member of campaign"
  end

  describe_rule :destroy? do
    succeed "when user is owner" do
      let(:user) { record.campaign.owner }
    end

    succeed "when member is journal author" do
      let(:user) { record.journal.author }
    end

    failed "when member is not journal author"
  end
end
