class AddSenderToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_reference :invitations, :sender, null: false,
      foreign_key: {to_table: :users}
  end
end
