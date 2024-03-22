class Campaigns::ApplicationController < ApplicationController
  before_action :set_campaign, only: %i[index new create]

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])

    authorize! context: {campaign: @campaign}
  end
end
