class AddCommentsCountToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :comments_count, :integer, default: 0
  end
end
