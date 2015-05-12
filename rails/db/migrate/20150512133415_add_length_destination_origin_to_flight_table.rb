class AddLengthDestinationOriginToFlightTable < ActiveRecord::Migration
  def change
    change_table :flights do |t|
      t.integer :trip_length
      t.string :destination
      t.string :origin
      t.boolean :has_stopover
      t.datetime :stopover_arrival_time
      t.datetime :stopover_departure_time
      t.string :stopover_destination
      t.string :stopover_origin
    end
  end
end
