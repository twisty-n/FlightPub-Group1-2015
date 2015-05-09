class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      #t.references :country, index: true
      t.string :destination_code
      t.string :airport
      t.string :country_code_3

      #t.belongs_to :country, foreign_key: :country_code_3, primary_key: :country_id

      t.timestamps null: false
    end
    add_foreign_key :destinations, :countries, column: :country_code_3, primary_key: :country_code_3
  end
end
