class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :user_id
      t.integer :advertiser_id

      t.timestamps
    end
  end
end
