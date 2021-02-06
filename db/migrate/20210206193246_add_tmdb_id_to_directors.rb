class AddTmdbIdToDirectors < ActiveRecord::Migration[5.2]
  def change
    add_column :directors, :tmdb_id, :bigint
    add_index :directors, :tmdb_id, unique: true
  end
end
