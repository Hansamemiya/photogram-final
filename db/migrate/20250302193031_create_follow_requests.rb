class CreateFollowRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :follow_requests do |t|
      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false
      t.string :status
      t.timestamps
    end

    add_foreign_key :follow_requests, :users, column: :sender_id
    add_foreign_key :follow_requests, :users, column: :recipient_id
    add_index :follow_requests, :sender_id
    add_index :follow_requests, :recipient_id
  end
end
