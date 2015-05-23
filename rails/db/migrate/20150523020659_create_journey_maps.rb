class CreateJourneyMaps < ActiveRecord::Migration
  def change
    create_table :journey_maps do |t|
      t.references :journey, index: true
      t.references :flight, index: true
      t.integer :order_in_journey

      t.timestamps null: false
    end
    add_foreign_key :journey_maps, :journeys
    add_foreign_key :journey_maps, :flights
  end
end
