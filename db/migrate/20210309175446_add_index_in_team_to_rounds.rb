class AddIndexInTeamToRounds < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :index_in_team, :integer, null: false
    add_index :rounds, [:team_id, :index_in_team], unique: true
  end
end
