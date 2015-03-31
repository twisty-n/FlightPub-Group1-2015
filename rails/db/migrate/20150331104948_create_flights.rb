class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :flightNumber
      t.string :price
      t.string :seatsAvailable
      t.string :departureTime
      t.string :arrivalTime

      t.timestamps null: false
    end
  end
end
