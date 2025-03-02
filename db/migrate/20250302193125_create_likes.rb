class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.integer :photo_id, null: false
      t.integer :fan_id, null: false
      t.timestamps
    end

    add_foreign_key :likes, :photos
    add_foreign_key :likes, :users, column: :fan_id
    add_index :likes, :photo_id
    add_index :likes, :fan_id
  end
end
