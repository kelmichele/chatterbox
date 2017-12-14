class DropGuestTable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :guest_users
  end
end
