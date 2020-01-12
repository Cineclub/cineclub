class CreateDirectors < ActiveRecord::Migration[5.2]
  def change
    create_table :directors do |t|
      t.references :country, foreign_key: true, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :directors, :name
  end
end
