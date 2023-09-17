class CreateCollectionInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :collection_invitations do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :journal, null: false, foreign_key: true
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
