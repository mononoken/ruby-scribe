class ChangeRoleNullForMemberships < ActiveRecord::Migration[7.0]
  def change
    change_column :memberships, :role, :integer, null: false
  end
end
