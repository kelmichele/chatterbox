class GuestUsers < ActiveRecord::Migration[5.1]
  def change
  	create_table :guest_users do |t|
  	  t.timestamps
  	end
  end
end
