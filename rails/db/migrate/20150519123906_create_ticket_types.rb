class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.string :ticket_code
      t.string :name
      t.boolean :transferable
      t.boolean :refundable
      t.boolean :exchangeable
      t.boolean :frequent_flyer_points

      t.timestamps null: false
    end
  end
end
