class AddUniqueIndexToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_index :invitations, [:collection_id, :recipient_id], unique: true
  end
end
