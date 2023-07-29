class CampaignsController < ApplicationController
  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.user = current_user

    if @campaign.save
      redirect_to action: :index
    else
      # render :new, status: :unprocessable_entity
    end
  end

  def index
    @campaigns = current_user.campaigns
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :user_id)
  end
end
