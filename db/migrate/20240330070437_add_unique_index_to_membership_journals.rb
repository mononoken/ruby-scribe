class AddUniqueIndexToMembershipJournals < ActiveRecord::Migration[7.0]
  def change
    add_index :membership_journals, [:membership_id, :journal_id], unique: true
  end
end
