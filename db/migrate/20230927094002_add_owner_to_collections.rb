class AddOwnerToCollections < ActiveRecord::Migration[7.0]
  def change
    add_reference :collections, :owners, null: false,
      foreign_key: {to_table: :users}
  end
end
