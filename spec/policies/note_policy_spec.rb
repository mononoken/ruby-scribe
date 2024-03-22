require "rails_helper"

RSpec.describe NotePolicy, type: :policy do
  # let(:user) { create(:user) }
  # let(:record) { create(:note) }
  #
  # describe :index? do
  #   let(:policy) { NotePolicy.new(record, user: user, journal: record.journal) }
  #
  #   subject { policy.apply(:index?) }
  #
  #   context "when user is allowed to show journal" do
  #     before do
  #       allow(policy).to receive(:allowed_to?)
  #         .with(:show?, record.journal)
  #         .and_return(true)
  #     end
  #
  #     it "returns true" do
  #       is_expected.to be(true)
  #     end
  #   end
  #
  #   context "when user is not allowed to show journal" do
  #     before do
  #       allow(policy).to receive(:allowed_to?)
  #         .and_return(false)
  #     end
  #
  #     it "returns false" do
  #       is_expected.to be(false)
  #     end
  #   end
  # end
  #
  # describe_rule :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
  #
  # describe_rule :manage? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
  #
  # describe :show? do
  #   let(:policy) { NotePolicy.new(record, user: user) }
  #
  #   subject { policy.apply(:show?) }
  #
  #   context "when user is note's author" do
  #     let(:user) { record.author }
  #
  #     it "returns true" do
  #       is_expected.to be(true)
  #     end
  #   end
  #
  #   context "when user is not author" do
  #     context "when user has membership to same collection as note's journal" do
  #       before do
  #         @journal_membership = create(:membership,
  #           journal: record.journal)
  #         @user_membership = create(:membership,
  #           member: user, collection: @journal_membership.collection)
  #       end
  #
  #       it "returns true" do
  #         is_expected.to be(true)
  #       end
  #     end
  #
  #     context "when user is not a member of the journal's collection" do
  #       it "returns false" do
  #         is_expected.to be(false)
  #       end
  #     end
  #   end
  # end
end
