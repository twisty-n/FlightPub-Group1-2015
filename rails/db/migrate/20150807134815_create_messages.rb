class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.references :user_conversation, index: true
      t.references :user, index: true
      t.integer :message_number

      t.timestamps null: false
    end
    add_foreign_key :messages, :user_conversations
    add_foreign_key :messages, :users
  end
end
