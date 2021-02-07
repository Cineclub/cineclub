class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :original_title, null: false
      t.integer :year, null: false

      t.timestamps
    end

    add_index :movies, :original_title
    add_index :movies, :year
  end
end
