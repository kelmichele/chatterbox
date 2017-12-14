class EditCustomerChat < ActiveRecord::Migration[5.1]
  def change
  	remove_column :customer_chats, :boss_admin_id, :integer
  	remove_column :customer_chats, :guest_user_id, :integer

  	add_column :customer_chats, :recipient_id, :integer
  	add_column :customer_chats, :sender_id, :integer
  end
end
