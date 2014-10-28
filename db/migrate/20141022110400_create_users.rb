class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :pwd_key
      t.string :nickname
      t.string :name
      t.string :nation

      t.timestamps
    end
  end
end
