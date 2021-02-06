class AddTmdbIdToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :tmdb_id, :bigint
    add_index :movies, :tmdb_id, unique: true
  end
end
