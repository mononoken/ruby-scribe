require "rails_helper"

RSpec.describe CommentPolicy, type: :policy do
  let(:user) { build_stubbed :user }
  let(:record) { create :comment }
  let(:context) { {user:} }

  describe "new?" do
    it "is an alias of :create? rule" do
      expect(:new?).to be_an_alias_of(policy, :create?)
    end
  end

  describe_rule :create? do
    let(:context) { {user:, note: record.note} }

    succeed "when user is allowed to manage the comment's note" do
      before do
        allow(policy).to receive(:allowed_to?)
          .with(:manage?, record.note)
          .and_return(true)
      end
    end

    failed "when user is not allowed to manage the comment's note" do
      before do
        allow(policy).to receive(:allowed_to?)
          .with(:manage?, record.note)
          .and_return(false)
      end
    end
  end

  describe_rule "index?" do
    let(:context) { {user:, note: record.note} }

    succeed "when user is allowed to manage the comment's note" do
      before do
        allow(policy).to receive(:allowed_to?)
          .with(:manage?, record.note)
          .and_return(true)
      end
    end

    failed "when user is not allowed to manage the comment's note" do
      before do
        allow(policy).to receive(:allowed_to?)
          .with(:manage?, record.note)
          .and_return(false)
      end
    end
  end

  describe_rule :manage? do
    succeed "when user is author" do
      let(:user) { record.author }
    end

    failed "when user is not author"
  end

  describe "edit?" do
    let(:policy) { described_class.new(record, user:) }

    it "is an alias of :manage? rule" do
      expect(:edit?).to be_an_alias_of(policy, :manage?)
    end
  end

  describe "update?" do
    it "is an alias of :manage? rule" do
      expect(:update?).to be_an_alias_of(policy, :manage?)
    end
  end

  describe "destroy?" do
    it "is an alias of :manage? rule" do
      expect(:destroy?).to be_an_alias_of(policy, :manage?)
    end
  end

  describe "show?" do
    it "is an alias of :manage? rule" do
      expect(:show?).to be_an_alias_of(policy, :manage?)
    end
  end
end
