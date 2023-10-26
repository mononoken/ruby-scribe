class AddUniqueIndexToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_index :memberships, [:member_id, :collection_id], unique: true
  end
end
