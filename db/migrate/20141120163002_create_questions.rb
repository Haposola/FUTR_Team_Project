class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :Nickname
      t.string :Lable
      t.string :Topic
      t.text :Description

      t.timestamps
    end
  end
end
