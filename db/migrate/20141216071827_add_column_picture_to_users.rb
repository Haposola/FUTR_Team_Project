class AddColumnPictureToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :picture, :string
  end
end
