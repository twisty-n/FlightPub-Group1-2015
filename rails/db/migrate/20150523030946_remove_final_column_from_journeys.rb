class RemoveFinalColumnFromJourneys < ActiveRecord::Migration
  def change
    remove_foreign_key :journeys, column: :save_identifier_id
    remove_column :journeys, :save_identifier_id
  end
end
