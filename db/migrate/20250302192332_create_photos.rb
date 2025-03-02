class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.text :caption
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0
      t.string :image
      t.integer :owner_id, null: false
      t.timestamps
    end

    add_foreign_key :photos, :users, column: :owner_id
    add_index :photos, :owner_id
  end
end
