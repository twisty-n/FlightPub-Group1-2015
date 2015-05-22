class CreateTicketAvailabilities < ActiveRecord::Migration
  def change
    create_table :ticket_availabilities do |t|

        t.references :flight, index: true
        t.references :ticket_type, index: true
        t.references :ticket_class, index: true

        t.integer :seats_available
        t.integer :price

      t.timestamps null: false
    end
  end
end
