class AddExtraInfoToFlight < ActiveRecord::Migration
  def change

  	add_column :flights, :destination, :string
  	add_column :flights, :origin, :string

  end
end
