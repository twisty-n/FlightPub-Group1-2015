class AlignFlightDestAndOrgWithIds < ActiveRecord::Migration
  def change
    #remove_column :flights, :origin
    #remove_column :flights, :destination

    #add_column :flights, :destination_id, :int, index: true
    #add_column :flights, :origin_id, :int, index: true

    add_foreign_key :flights, :destinations, column:  :destination_id, primary_key: :id
    add_foreign_key :flights, :destinations, column:  :origin_id, primary_key: :id
  end
end
