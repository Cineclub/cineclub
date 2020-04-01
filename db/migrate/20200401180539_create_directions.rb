class CreateDirections < ActiveRecord::Migration[5.2]
  def change
    create_table :directions do |t|
      t.references :director, foreign_key: true, null: false
      t.references :movie, foreign_key: true, null: false

      t.timestamps
    end

    add_index :directions, [:director_id, :movie_id], unique: true
  end
end
