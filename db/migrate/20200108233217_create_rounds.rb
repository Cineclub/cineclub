class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.references :user, foreign_key: true, null: false
      t.references :team, foreign_key: true, null: false
      t.references :movie, foreign_key: true
      t.integer :index_in_team, null: false

      t.timestamps
    end

    add_index :rounds, [:team_id, :index_in_team], unique: true
  end
end
