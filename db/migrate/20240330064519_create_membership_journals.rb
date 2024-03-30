class CreateMembershipJournals < ActiveRecord::Migration[7.0]
  def change
    create_table :membership_journals do |t|
      t.references :membership, null: false, foreign_key: true
      t.references :journal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
