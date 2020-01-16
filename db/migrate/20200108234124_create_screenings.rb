class CreateScreenings < ActiveRecord::Migration[5.2]
  def change
    create_table :screenings do |t|
      t.references :user, foreign_key: true, null: false
      t.references :round, foreign_key: true, null: false

      t.timestamps
    end
  end
end
