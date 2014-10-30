class CreateReForQuesForActs < ActiveRecord::Migration
  def change
    create_table :re_for_ques_for_acts do |t|
      t.integer :q_about_act_id
      t.string :replier
      t.string :answer

      t.timestamps
    end
  end
end
