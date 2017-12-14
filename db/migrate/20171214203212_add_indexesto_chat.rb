class AddIndexestoChat < ActiveRecord::Migration[5.1]
  def change
	  add_index :customer_chats, :recipient_id
	  add_index :customer_chats, :sender_id
	  add_index :customer_chats, [:recipient_id, :sender_id], unique: true
  end
end
