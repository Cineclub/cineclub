class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.references :membership, foreign_key: true, null: false
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
