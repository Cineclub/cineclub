class CreateDirectors < ActiveRecord::Migration[5.2]
  def change
    create_table :directors do |t|
      t.string :name, null: false
      t.bigint :tmdb_id
      t.string :imdb_id

      t.timestamps
    end

    add_index :directors, :name
    add_index :directors, :tmdb_id, unique: true
    add_index :directors, :imdb_id, unique: true
  end
end
