class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.text :body
      t.references :conversation, foreign_key: true

      t.timestamps
    end
  end
end
