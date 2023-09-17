class AddNameToCollections < ActiveRecord::Migration[7.0]
  def change
    add_column :collections, :name, :string, null: false
  end
end
