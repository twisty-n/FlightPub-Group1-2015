class AddColumnsToJorney < ActiveRecord::Migration
  def change
    add_column :journeys, :departure_time, :datetime
    add_column :journeys, :arrival_time, :datetime
  end
end
