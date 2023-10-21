class RemoveJournalFromInvitations < ActiveRecord::Migration[7.0]
  def change
    remove_reference :invitations, :journal, null: false, foreign_key: true
  end
end
