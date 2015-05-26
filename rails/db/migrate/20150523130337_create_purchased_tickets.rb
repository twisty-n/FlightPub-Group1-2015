class CreatePurchasedTickets < ActiveRecord::Migration
  def change
    create_table :purchased_tickets do |t|
      t.references :ticket_availability, index: true
      t.references :user, index: true
      t.integer :number_purchased

      t.timestamps null: false
    end
    add_foreign_key :purchased_tickets, :ticket_availabilities
    add_foreign_key :purchased_tickets, :users
  end
end
