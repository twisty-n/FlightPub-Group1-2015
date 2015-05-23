class ConvertJounreyToSearch < ActiveRecord::Migration
  def change
    # Remove the user column from the journey
    remove_foreign_key :journeys, column: :user_id
    remove_column :journeys, :user_id

    # Add in the fields that would otherwise have to be computed
    add_column :journeys, :price, :integer
    add_column :journeys, :flight_time, :integer

    add_column :journeys, :origin_id, :integer
    add_column :journeys, :destination_id, :integer

    add_foreign_key :journeys, :destinations, column:  :origin_id, primary_key: :id
    add_foreign_key :journeys, :destinations, column:  :destination_id, primary_key: :id

  end
end
