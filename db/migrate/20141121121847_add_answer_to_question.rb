class AddAnswerToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :Answer, :text
  end
end
