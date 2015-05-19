class CreateAirlines < ActiveRecord::Migration
  def change
    create_table :airlines do |t|
      t.string :airline_code
      t.string :airline_name
      t.references :country, index: true

      t.timestamps null: false
    end
    add_foreign_key :airlines, :countries
  end
end
