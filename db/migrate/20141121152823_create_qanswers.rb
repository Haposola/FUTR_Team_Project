class CreateQanswers < ActiveRecord::Migration
  def change
    create_table :qanswers do |t|
      t.string :Nickname
      t.text :Answer

      t.timestamps
    end
  end
end
