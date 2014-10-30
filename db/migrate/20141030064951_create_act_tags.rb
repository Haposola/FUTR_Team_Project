class CreateActTags < ActiveRecord::Migration
  def change
    create_table :act_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
