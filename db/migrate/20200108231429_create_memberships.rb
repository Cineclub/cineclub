class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.references :team, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end

    add_index :memberships, [:team_id, :user_id], unique: true
  end
end
