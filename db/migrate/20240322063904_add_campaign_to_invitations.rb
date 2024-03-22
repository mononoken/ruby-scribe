class AddCampaignToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_reference :invitations, :campaign, null: false, foreign_key: true
    add_index :invitations, [:campaign_id, :recipient_id], unique: true
  end
end
