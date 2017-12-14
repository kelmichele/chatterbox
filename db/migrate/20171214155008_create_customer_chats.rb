class CreateCustomerChats < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_chats do |t|
      t.integer :boss_admin_id
      t.integer :guest_user_id

      t.timestamps
    end

    add_index :customer_chats, :guest_user_id
  end
end
