require "rails_helper"

RSpec.describe MembershipJournalsController, type: :controller do
  describe "authorization" do
    let!(:user) { create :user }
    let!(:membership) { create :membership, member: user }
    let!(:journal) { create :journal, author: user }
    let(:membership_journal) { build :membership_journal, membership:, journal: }

    before do
      sign_in user
    end

    describe "new" do
      let(:params) { {campaign_id: membership_journal.campaign.id} }
      subject { get :new, params: params }

      it "is authorized" do
        expect { subject }.to be_authorized_to(:create?, MembershipJournal)
          .with(MembershipJournalPolicy)
      end
    end

    describe "create" do
      let(:params) do
        {
          campaign_id: membership_journal.campaign.id,
          membership_journal: {journal_id: journal.id}
        }
      end
      subject { post :create, params: params }

      it "is authorized" do
        expect { subject }.to be_authorized_to(:create?, MembershipJournal)
          .with(MembershipJournalPolicy)
      end
    end

    describe "destroy" do
      let!(:membership_journal) { create :membership_journal, membership:, journal: }
      let(:params) { {id: membership_journal.id} }
      subject { delete :destroy, params: params }

      it "is authorized" do
        expect { subject }.to be_authorized_to(:destroy?, membership_journal)
          .with(MembershipJournalPolicy)
      end
    end
  end
end
