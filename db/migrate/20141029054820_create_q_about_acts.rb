class CreateQAboutActs < ActiveRecord::Migration
  def change
    create_table :q_about_acts do |t|
      t.integer :activity_id
      t.string :qustioner
      t.string :qustion

      t.timestamps
    end
  end
end
