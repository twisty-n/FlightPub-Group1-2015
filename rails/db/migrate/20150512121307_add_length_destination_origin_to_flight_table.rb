class AddLengthDestinationOriginToFlightTable < ActiveRecord::Migration
  def change
    change_table :flights do |t|
      t.integer :trip_length
      t.string :destination
      t.string :origin
    end
  end
end
