class FlightChangePriceFromStringToInt < ActiveRecord::Migration
  def change
  	change_column :flights, :price, :decimal
  end
end
