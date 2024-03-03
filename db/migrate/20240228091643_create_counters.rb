class CreateCounters < ActiveRecord::Migration[7.0]
  def change
    create_table :counters do |t|
      t.text :label
      t.integer :count, default: 0
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
