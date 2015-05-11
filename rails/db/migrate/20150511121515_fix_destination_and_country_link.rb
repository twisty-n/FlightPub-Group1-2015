class FixDestinationAndCountryLink < ActiveRecord::Migration
  def change
    remove_foreign_key :destinations, column: :country_code_3
    drop_table :destinations

    create_table :destinations do |t|
      t.references :country, index: true
      t.string :destination_code
      t.string :airport
      t.timestamps null: false
    end

  end
end
