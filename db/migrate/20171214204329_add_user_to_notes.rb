class AddUserToNotes < ActiveRecord::Migration[5.1]
  def change
    add_reference :notes, :user, foreign_key: true
    add_reference :notes, :customer_chat, foreign_key: true
    remove_reference :notes, :conversation
  end
end
