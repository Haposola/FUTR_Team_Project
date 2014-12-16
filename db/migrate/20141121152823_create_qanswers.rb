class CreateQanswers < ActiveRecord::Migration
  def change
    create_table :qanswers do |t|
      t.string :Nickname
      t.text :Answer
      t.references :question
      t.timestamps
    end
    add_index :qanswers, :question_id  
  end
end
