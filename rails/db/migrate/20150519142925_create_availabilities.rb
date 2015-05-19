class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.string :AirlineCode
      t.string :FlightNumber
      t.datetime :DepartureTime
      t.string :ClassCode
      t.string :TicketCode
      t.integer :NumberAvailableSeatsLeg1
      t.integer :NumberAvailableSeatsLeg2

      t.timestamps null: false
    end
  end
end
