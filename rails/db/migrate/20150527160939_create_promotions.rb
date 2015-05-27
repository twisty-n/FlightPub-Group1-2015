class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.references :flight, index: true
      t.integer :discount

      t.timestamps null: false
    end
    add_foreign_key :promotions, :flights
  end
end
