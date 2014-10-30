class CreateComForActs < ActiveRecord::Migration
  def change
    create_table :com_for_acts do |t|
      t.integer :activity_id
      t.string :speaker
      t.string :content

      t.timestamps
    end
  end
end
