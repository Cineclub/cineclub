class AddImdbIdToDirectors < ActiveRecord::Migration[5.2]
  def change
    add_column :directors, :imdb_id, :bigint
    add_index :directors, :imdb_id, unique: true
  end
end
