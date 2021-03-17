class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :invitee, foreign_key: { to_table: :users }, index: true, null: false
      t.references :inviter, foreign_key: { to_table: :users }, index: true, null: false
      t.references :team, foreign_key: true, index: true, null: false
      t.boolean :accepted, null: false, default: false

      t.timestamps
    end

    add_index :invitations, [:inviter_id, :invitee_id, :team_id]
  end
end
