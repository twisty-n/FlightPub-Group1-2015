class RemoveForiegnKeysOnSavedFlights < ActiveRecord::Migration
  def change
  	remove_foreign_key :saved_journeys, :users
    remove_foreign_key :saved_journeys, :journeys
  end
end
