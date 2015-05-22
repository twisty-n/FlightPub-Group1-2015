class FixFlightsAirlinesColumnName < ActiveRecord::Migration
  def change
    rename_column :flights, :airlines_id, :airline_id
  end
end
