class FixSavedFlightsSavedIdentifier < ActiveRecord::Migration
  def change
    remove_column :saved_flights, :save_types_id
    add_reference :saved_flights, :save_identifier, index: true
  end
end
