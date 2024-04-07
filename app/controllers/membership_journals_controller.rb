class MembershipJournalsController < ApplicationController
  skip_verify_authorized # TEMP FIX_ME

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @membership_journal = MembershipJournal.new
    @journals = current_user.journals
  end

  def create
    @campaign = Campaign.find(params[:campaign_id])
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
    @membership_journal = MembershipJournal.find(params[:id])
    @membership_journal.destroy

    flash[:success] = "You successfully removed #{@membership_journal.journal.name}."
    redirect_to edit_campaign_path(@membership_journal.campaign)
  end

  private

  def membership_journal_params
    params.require(:membership_journal).permit(:membership_id, :journal_id)
  end
end
