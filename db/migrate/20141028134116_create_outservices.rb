class CreateOutservices < ActiveRecord::Migration
  def change
    create_table :outservices do |t|

      t.timestamps
    end
  end
end
