class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :AirlineCode
      t.string :FlightNumber
      t.string :ClassCode
      t.string :TicketCode
      t.datetime :StartDate
      t.datetime :EndDate
      t.decimal :Price
      t.decimal :PriceLeg1
      t.decimal :PriceLeg2

      t.timestamps null: false
    end
  end
end
