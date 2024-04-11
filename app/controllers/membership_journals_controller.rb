class MembershipJournalsController < ApplicationController
  before_action :set_campaign, only: %i[new create]
  before_action :context_authorize!, only: %i[new create]
  before_action :set_membership_journal, only: %i[destroy]

  def new
    @membership_journal = MembershipJournal.new
    @journals = current_user.journals
  end

  def create
    membership = Membership.find_by(campaign: @campaign, member: current_user)
    @membership_journal = MembershipJournal.new(
      membership_journal_params.merge(membership_id: membership.id)
    )

    if @membership_journal.save
      redirect_to campaign_path(@campaign)
    else
      flash.now[:error] = @membership_journal.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @membership_journal.destroy

    flash[:success] = "You successfully removed #{@membership_journal.journal.name}."
    redirect_to edit_campaign_path(@membership_journal.campaign)
  end

  private

  def membership_journal_params
    params.require(:membership_journal).permit(:membership_id, :journal_id)
  end

  def set_membership_journal
    @membership_journal = MembershipJournal.find(params[:id])

    authorize! @membership_journal
  rescue ActionPolicy::Unauthorized
    flash[:error] = "You do not have permission to do that action."
    redirect_to campaign_path(@membership_journal.campaign), status: :forbidden
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def context_authorize!
    authorize! MembershipJournal, context: {campaign: @campaign}
  end
end
