class CreateSignedInLogs < ActiveRecord::Migration
  def change
    create_table :signed_in_logs do |t|
      t.string :email
      t.string :token

      t.timestamps
    end
  end
end
