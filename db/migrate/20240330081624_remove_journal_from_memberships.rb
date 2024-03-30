class RemoveJournalFromMemberships < ActiveRecord::Migration[7.0]
  def change
    remove_reference :memberships, :journal, foreign_key: true
  end
end
