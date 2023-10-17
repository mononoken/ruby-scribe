class AddJournalToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_reference :memberships, :journal, foreign_key: true
  end
end
