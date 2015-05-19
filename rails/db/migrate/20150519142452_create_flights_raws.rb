class CreateFlightsRaws < ActiveRecord::Migration
  def change
    create_table :flights_raws do |t|
      t.string :AirlineCode
      t.string :FlightNumber
      t.string :DepartureCode
      t.string :StopOverCode
      t.string :DestinationCode
      t.datetime :DepartureTime
      t.datetime :ArrivalTimeStopOver
      t.datetime :DepartureTimeStopOver
      t.datetime :ArrivalTime
      t.string :PlaneCode
      t.integer :Duration
      t.integer :DurationSecondLeg

      t.timestamps null: false
    end
  end
end
