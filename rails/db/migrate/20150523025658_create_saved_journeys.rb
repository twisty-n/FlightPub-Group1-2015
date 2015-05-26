class CreateSavedJourneys < ActiveRecord::Migration
  def change
    create_table :saved_journeys do |t|
      t.references :user, index: true
      t.references :journey, index: true
      t.references :save_identifier, index: true

      t.timestamps null: false
    end
    add_foreign_key :saved_journeys, :users
    add_foreign_key :saved_journeys, :journeys
    add_foreign_key :saved_journeys, :save_identifiers
  end
end
