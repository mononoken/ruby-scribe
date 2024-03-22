class CampaignsController < ApplicationController
  before_action :set_campaign, only: %i[show edit update destroy]

  def new
    authorize!
    @campaign = Campaign.new
    @campaign.memberships.build

    @journals = current_user.journals
  end

  def create
    @campaign = Campaign.new(campaign_params
      .with_defaults(owner: current_user))

    @campaign.memberships.first.member = current_user
    @campaign.memberships.first.role = :owner

    authorize! @campaign

    if @campaign.save
      redirect_to @campaign
    else
      flash.now[:error] = @campaign.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @campaigns = current_user.campaigns
    authorize! @campaigns
  end

  def show
    @members = @campaign.members
    @invitation = @campaign.invitations.build
    @membership = Membership.find_by(
      member: current_user, campaign: @campaign
    )
  end

  def edit
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to @campaign
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @campaign.destroy

    flash[:success] = "Campaign successfully deleted."
    redirect_to campaigns_path, status: :see_other
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])

    authorize! @campaign
  end

  def campaign_params
    params.require(:campaign)
      .permit(:name, :owner_id,
        memberships_attributes:
          [:campaign_id, :member_id, :journal_id, :role])
  end
end
