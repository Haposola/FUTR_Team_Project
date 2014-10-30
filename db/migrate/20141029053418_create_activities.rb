class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :owner
      t.string :name
      t.time :tim
      t.string :tag
      t.integer :peoNum
      t.string :contact
      t.string :description

      t.timestamps
    end
  end
end
