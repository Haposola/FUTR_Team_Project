class AddOutservicePlaces < ActiveRecord::Migration
  def change
    create_table :outservice_places do |t|
    	t.string :service_kind
    	t.string :name
    	t.string :picture_addr
    	t.text :description
    	t.float :star
      t.integer :cnt
      t.timestamps
    end

    create_table :outservice_comments do |t|
    	t.string :service_kind
    	t.string :nickname
    	t.string :name
    	t.text :comment
    	t.integer :star
      t.timestamps
    end
  end
end
