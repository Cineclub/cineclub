class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name
      t.date :birthdate
      t.references :country, foreign_key: true

      t.timestamps
    end

    add_presence_constraint :users, :email
    add_presence_constraint :users, :first_name
    add_unique_constraint :users, :email
  end
end
