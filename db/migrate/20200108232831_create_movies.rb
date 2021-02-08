class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :original_title, null: false
      t.integer :year, null: false
      t.bigint :tmdb_id, null: false
      t.string :imdb_id

      t.timestamps
    end

    add_index :movies, :original_title
    add_index :movies, :year
    add_index :movies, :tmdb_id, unique: true
    add_index :movies, :imdb_id, unique: true
  end
end
