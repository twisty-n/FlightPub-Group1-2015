class CreateUserConversations < ActiveRecord::Migration
  def change
    create_table :user_conversations do |t|
      
      t.integer :participant_1_id
      t.integer :participant_2_id

      t.integer :message_count

      t.timestamps null: false
    end

    add_foreign_key :user_conversations, :users, column:  :participant_1_id, primary_key: :id
    add_foreign_key :user_conversations, :users, column:  :participant_2_id, primary_key: :id
  end
end

=begin

    remove_foreign_key :journeys, column: :user_id
    remove_column :journeys, :user_id

    # Add in the fields that would otherwise have to be computed
    add_column :journeys, :price, :integer
    add_column :journeys, :flight_time, :integer

    add_column :journeys, :origin_id, :integer
    add_column :journeys, :destination_id, :integer

    add_foreign_key :journeys, :destinations, column:  :origin_id, primary_key: :id
    add_foreign_key :journeys, :destinations, column:  :destination_id, primary_key: :id


=end