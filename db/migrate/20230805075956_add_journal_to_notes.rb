class AddJournalToNotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :notes, :journal, null: false, foreign_key: true
  end
end
