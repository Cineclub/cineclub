class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :invitee, foreign_key: { to_table: :users }, index: true, null: false
      t.references :inviter, foreign_key: { to_table: :users }, index: true, null: false
      t.references :team, foreign_key: true, index: true, null: false
      t.datetime :dismissed_at, index: true

      t.timestamps
    end

    add_index :invitations, [:invitee_id, :team_id, :dismissed_at]
    add_index :invitations, [:invitee_id, :dismissed_at]
  end
end
