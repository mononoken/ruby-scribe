class AddUserToJournals < ActiveRecord::Migration[7.0]
  def change
    add_reference :journals, :user, null: false, foreign_key: true
  end
end
