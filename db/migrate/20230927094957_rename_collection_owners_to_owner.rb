class RenameCollectionOwnersToOwner < ActiveRecord::Migration[7.0]
  def change
    rename_column :collections, :owners_id, :owner_id
  end
end
