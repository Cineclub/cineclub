class AddConfirmedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :email_confirmation_token, null: false, default: ""
      t.datetime :email_confirmed_at
      t.index :email_confirmation_token
      t.index :email_confirmed_at
    end
  end
end
