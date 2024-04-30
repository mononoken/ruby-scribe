require "rails_helper"

RSpec.describe JournalPolicy, type: :policy do
  let(:user) { build_stubbed :user }
  let(:record) { create :journal }
  let(:context) { {user:} }

  describe_rule "new?" do
    succeed "when user is present"

    # This is authentication and implemented via Devise
    # failed "when is not present"
  end

  describe_rule :create? do
    succeed "when user is author" do
      let(:user) { record.author }
    end

    failed "when user is not author"
  end

  describe_rule "index?" do
    succeed "when user is present"

    # This is authentication and implemented via Devise
    # failed "when is not present"
  end

  describe_rule :manage? do
    succeed "when user is author" do
      let(:user) { record.author }
    end

    failed "when user is not journal author"
  end

  describe "edit?" do
    let(:policy) { described_class.new(record, user:) }

    it "is an alias of :manage? rule" do
      expect(:edit?).to be_an_alias_of(policy, :manage?)
    end
  end

  describe "update?" do
    let(:policy) { described_class.new(record, user:) }

    it "is an alias of :manage? rule" do
      expect(:update?).to be_an_alias_of(policy, :manage?)
    end
  end

  describe "destroy?" do
    let(:policy) { described_class.new(record, user:) }

    it "is an alias of :manage? rule" do
      expect(:destroy?).to be_an_alias_of(policy, :manage?)
    end
  end
end
