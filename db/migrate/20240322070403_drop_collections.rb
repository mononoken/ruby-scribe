class DropCollections < ActiveRecord::Migration[7.0]
  def change
    remove_index :invitations, [:collection_id, :recipient_id], unique: true
    remove_reference :invitations, :collection, foreign_key: true, null: false
    remove_reference :memberships, :collection, foreign_key: true, null: false
    drop_table :collections
  end
end
