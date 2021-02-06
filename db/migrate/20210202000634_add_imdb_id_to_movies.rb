class AddImdbIdToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :imdb_id, :string
    add_index :movies, :imdb_id, unique: true
  end
end
