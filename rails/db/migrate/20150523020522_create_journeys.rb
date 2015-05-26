class CreateJourneys < ActiveRecord::Migration
  def change
    create_table :journeys do |t|
      t.references :user, index: true
      t.references :save_identifier, index: true

      t.timestamps null: false
    end
    add_foreign_key :journeys, :users
    add_foreign_key :journeys, :save_identifiers
  end
end
