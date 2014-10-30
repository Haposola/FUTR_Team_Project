class AddRestaurantComment < ActiveRecord::Migration
  def change
    create_table :restaurant_comments do |t|
    	t.string :nickname
    	t.string :restaurant_name
    	t.text :comment
    	t.integer :star
      t.timestamps
    end
  end
end
