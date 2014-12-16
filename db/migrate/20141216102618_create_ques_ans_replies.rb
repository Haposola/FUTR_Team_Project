class CreateQuesAnsReplies < ActiveRecord::Migration
  def change
    create_table :ques_ans_replies do |t|
      t.string :anser
      t.text :body
      t.references :qanswer

      t.timestamps
    end
    add_index :ques_ans_replies, :qanswer_id
  end
end
