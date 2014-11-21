class Addrestaurant < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
    	t.string :name
    	t.string :picture_addr
    	t.text :description
    	t.integer :star
      t.timestamps
    end
  end
end
