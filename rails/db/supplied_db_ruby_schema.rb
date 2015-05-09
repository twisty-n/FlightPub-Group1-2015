# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "Airlines", id: false, force: :cascade do |t|
    t.string "AirlineCode",  limit: 2,  null: false
    t.string "AirlineName",  limit: 30, null: false
    t.string "CountryCode3", limit: 3,  null: false
  end

  create_table "Availability", id: false, force: :cascade do |t|
    t.string   "AirlineCode",              limit: 2, null: false
    t.string   "FlightNumber",             limit: 6, null: false
    t.datetime "DepartureTime",                      null: false
    t.string   "ClassCode",                limit: 3, null: false
    t.string   "TicketCode",               limit: 1, null: false
    t.integer  "NumberAvailableSeatsLeg1", limit: 4, null: false
    t.integer  "NumberAvailableSeatsLeg2", limit: 4
  end

  create_table "Country", id: false, force: :cascade do |t|
    t.string "countryCode2",         limit: 2,               null: false
    t.string "countryCode3",         limit: 3,               null: false
    t.string "countryName",          limit: 80, default: "", null: false
    t.string "alternateName1",       limit: 80, default: "", null: false
    t.string "alternateName2",       limit: 80, default: "", null: false
    t.string "motherCountryCode3",   limit: 3,  default: "", null: false
    t.string "motherCountryComment", limit: 80, default: "", null: false
  end

  create_table "Destinations", id: false, force: :cascade do |t|
    t.string "DestinationCode", limit: 3,  null: false
    t.string "Airport",         limit: 30, null: false
    t.string "CountryCode3",    limit: 3,  null: false
  end

  create_table "Distances", id: false, force: :cascade do |t|
    t.string  "DestinationCode1", limit: 3, null: false
    t.string  "DestinationCode2", limit: 3, null: false
    t.integer "DistancesInKms",   limit: 4, null: false
  end

  create_table "Flights", id: false, force: :cascade do |t|
    t.string   "AirlineCode",           limit: 2,  null: false
    t.string   "FlightNumber",          limit: 6,  null: false
    t.string   "DepartureCode",         limit: 3,  null: false
    t.string   "StopOverCode",          limit: 3
    t.string   "DestinationCode",       limit: 3,  null: false
    t.datetime "DepartureTime",                    null: false
    t.datetime "ArrivalTimeStopOver"
    t.datetime "DepartureTimeStopOver"
    t.datetime "ArrivalTime",                      null: false
    t.string   "PlaneCode",             limit: 20, null: false
    t.integer  "Duration",              limit: 4,  null: false
    t.integer  "DurationSecondLeg",     limit: 4
  end

  create_table "PlaneType", id: false, force: :cascade do |t|
    t.string  "PlaneCode",         limit: 20, null: false
    t.string  "Details",           limit: 50, null: false
    t.integer "NumFirstClass",     limit: 4,  null: false
    t.integer "NumBusiness",       limit: 4,  null: false
    t.integer "NumPremiumEconomy", limit: 4,  null: false
    t.integer "Economy",           limit: 4,  null: false
  end

  create_table "Price", id: false, force: :cascade do |t|
    t.string   "AirlineCode",  limit: 2,                          null: false
    t.string   "FlightNumber", limit: 6,                          null: false
    t.string   "ClassCode",    limit: 3,                          null: false
    t.string   "TicketCode",   limit: 1,                          null: false
    t.datetime "StartDate",                                       null: false
    t.datetime "EndDate",                                         null: false
    t.decimal  "Price",                  precision: 10, scale: 2, null: false
    t.decimal  "PriceLeg1",              precision: 10, scale: 2
    t.decimal  "PriceLeg2",              precision: 10, scale: 2
  end

  create_table "TicketClass", id: false, force: :cascade do |t|
    t.string "ClassCode", limit: 3,  null: false
    t.string "Details",   limit: 20, null: false
  end

  create_table "TicketType", id: false, force: :cascade do |t|
    t.string "TicketCode",          limit: 1,  null: false
    t.string "Name",                limit: 50, null: false
    t.binary "Transferrable",       limit: 1,  null: false
    t.binary "Refundable",          limit: 1,  null: false
    t.binary "Exchangeable",        limit: 1,  null: false
    t.binary "FrequentFlyerPoints", limit: 1,  null: false
  end

end
