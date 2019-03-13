class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :code, null: false

      t.timestamps
    end

    add_unique_constraint :countries, :name
    add_unique_constraint :countries, :code
  end
end
