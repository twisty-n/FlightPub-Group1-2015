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

ActiveRecord::Schema.define(version: 20150523033403) do

  create_table "airlines", force: :cascade do |t|
    t.string   "airline_code", limit: 255
    t.string   "airline_name", limit: 255
    t.integer  "country_id",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "airlines", ["country_id"], name: "index_airlines_on_country_id", using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "access_token", limit: 255
    t.string   "scope",        limit: 255
    t.datetime "expired_at"
    t.datetime "created_at"
  end

  add_index "api_keys", ["access_token"], name: "index_api_keys_on_access_token", unique: true, using: :btree
  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "country_code_2",         limit: 255
    t.string   "country_code_3",         limit: 255
    t.string   "country_name",           limit: 255
    t.string   "alternate_name_1",       limit: 255
    t.string   "alternate_name_2",       limit: 255
    t.string   "mother_country_code_3",  limit: 255
    t.text     "mother_country_comment", limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "countries", ["country_code_2"], name: "index_countries_on_country_code_2", unique: true, using: :btree
  add_index "countries", ["country_code_3"], name: "index_countries_on_country_code_3", unique: true, using: :btree

  create_table "destinations", force: :cascade do |t|
    t.integer  "country_id",       limit: 4
    t.string   "destination_code", limit: 255
    t.string   "airport",          limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "destinations", ["country_id"], name: "index_destinations_on_country_id", using: :btree

  create_table "flights", force: :cascade do |t|
    t.string   "flight_number",       limit: 255
    t.string   "departure_time",      limit: 255
    t.string   "arrival_time",        limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "flight_time",         limit: 4
    t.boolean  "is_composite_flight", limit: 1
    t.integer  "leg_1_id",            limit: 4
    t.integer  "leg_2_id",            limit: 4
    t.integer  "destination_id",      limit: 4
    t.integer  "origin_id",           limit: 4
    t.integer  "airline_id",          limit: 4
  end

  add_index "flights", ["airline_id"], name: "index_flights_on_airline_id", using: :btree
  add_index "flights", ["destination_id"], name: "fk_rails_ae9de3d0f9", using: :btree
  add_index "flights", ["leg_1_id"], name: "fk_rails_addabd29ea", using: :btree
  add_index "flights", ["leg_2_id"], name: "fk_rails_739ad5a492", using: :btree
  add_index "flights", ["origin_id"], name: "fk_rails_34f4351407", using: :btree

  create_table "journey_maps", force: :cascade do |t|
    t.integer  "journey_id",       limit: 4
    t.integer  "flight_id",        limit: 4
    t.integer  "order_in_journey", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "journey_maps", ["flight_id"], name: "index_journey_maps_on_flight_id", using: :btree
  add_index "journey_maps", ["journey_id"], name: "index_journey_maps_on_journey_id", using: :btree

  create_table "journeys", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "price",           limit: 4
    t.integer  "flight_time",     limit: 4
    t.integer  "origin_id",       limit: 4
    t.integer  "destination_id",  limit: 4
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.integer  "ticket_class_id", limit: 4
  end

  add_index "journeys", ["destination_id"], name: "fk_rails_df6c4aabe5", using: :btree
  add_index "journeys", ["origin_id"], name: "fk_rails_6b5c29487e", using: :btree
  add_index "journeys", ["ticket_class_id"], name: "index_journeys_on_ticket_class_id", using: :btree

  create_table "save_identifiers", force: :cascade do |t|
    t.string "s_type",       limit: 255
    t.string "account_type", limit: 255
  end

  create_table "saved_journeys", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "journey_id",         limit: 4
    t.integer  "save_identifier_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "saved_journeys", ["journey_id"], name: "index_saved_journeys_on_journey_id", using: :btree
  add_index "saved_journeys", ["save_identifier_id"], name: "index_saved_journeys_on_save_identifier_id", using: :btree
  add_index "saved_journeys", ["user_id"], name: "index_saved_journeys_on_user_id", using: :btree

  create_table "ticket_availabilities", force: :cascade do |t|
    t.integer  "flight_id",       limit: 4
    t.integer  "ticket_type_id",  limit: 4
    t.integer  "ticket_class_id", limit: 4
    t.integer  "seats_available", limit: 4
    t.integer  "price",           limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "ticket_availabilities", ["flight_id"], name: "index_ticket_availabilities_on_flight_id", using: :btree
  add_index "ticket_availabilities", ["ticket_class_id"], name: "index_ticket_availabilities_on_ticket_class_id", using: :btree
  add_index "ticket_availabilities", ["ticket_type_id"], name: "index_ticket_availabilities_on_ticket_type_id", using: :btree

  create_table "ticket_classes", force: :cascade do |t|
    t.string   "class_code", limit: 255
    t.string   "details",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ticket_types", force: :cascade do |t|
    t.string   "ticket_code",           limit: 255
    t.string   "name",                  limit: 255
    t.boolean  "transferable",          limit: 1
    t.boolean  "refundable",            limit: 1
    t.boolean  "exchangeable",          limit: 1
    t.boolean  "frequent_flyer_points", limit: 1
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",       limit: 255, default: ""
    t.string   "last_name",        limit: 255, default: ""
    t.string   "info_string",      limit: 200
    t.string   "password_digest",  limit: 255
    t.string   "role",             limit: 255
    t.string   "email",            limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.string   "uid",              limit: 255
    t.string   "provider",         limit: 255
    t.string   "account_status",   limit: 255
  end

  add_index "users", ["email"], name: "index_Users_on_email", unique: true, using: :btree
  add_index "users", ["id"], name: "userID", unique: true, using: :btree

  add_foreign_key "airlines", "countries"
  add_foreign_key "api_keys", "users"
  add_foreign_key "flights", "destinations"
  add_foreign_key "flights", "destinations", column: "origin_id"
  add_foreign_key "flights", "flights", column: "leg_1_id"
  add_foreign_key "flights", "flights", column: "leg_2_id"
  add_foreign_key "journey_maps", "flights"
  add_foreign_key "journey_maps", "journeys"
  add_foreign_key "journeys", "destinations"
  add_foreign_key "journeys", "destinations", column: "origin_id"
  add_foreign_key "journeys", "ticket_classes"
  add_foreign_key "saved_journeys", "journeys"
  add_foreign_key "saved_journeys", "save_identifiers"
  add_foreign_key "saved_journeys", "users"
end
