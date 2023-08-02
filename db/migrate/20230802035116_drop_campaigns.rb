class DropCampaigns < ActiveRecord::Migration[7.0]
  def change
    drop_table :campaigns do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
