class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.string :name, null: false

      t.timestamps
    end
  end
end
