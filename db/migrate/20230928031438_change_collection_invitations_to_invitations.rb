class ChangeCollectionInvitationsToInvitations < ActiveRecord::Migration[7.0]
  def change
    rename_table :collection_invitations, :invitations
  end
end
