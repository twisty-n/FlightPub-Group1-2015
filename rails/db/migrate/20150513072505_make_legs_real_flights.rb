class MakeLegsRealFlights < ActiveRecord::Migration
  def change
    change_table :flights do |t|
      t.remove :has_stopover, :stopover_arrival_time, :stopover_departure_time, :stopover_destination, :stopover_origin
      t.boolean :is_composite_flight
      t.integer :leg_1_id, :leg_2_id
    end
  end
end



# What we need to do:
# Retool the flights table so that legs are bonda fide flights.
#
# 1) Remove:
#    Has_stopover, stopover_arrival_time, stopover_departure_time, stopover_destination, stopover_origin.
#  2) Add:
#      is_composite_flight, leg_1_id, leg_2_id