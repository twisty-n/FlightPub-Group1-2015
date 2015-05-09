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

ActiveRecord::Schema.define(version: 20150509093731) do

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

  create_table "flights", force: :cascade do |t|
    t.string   "flight_number",  limit: 255
    t.decimal  "price",                      precision: 10
    t.string   "seatsAvailable", limit: 255
    t.string   "departureTime",  limit: 255
    t.string   "arrivalTime",    limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",       limit: 40,  default: "", null: false
    t.string   "last_name",        limit: 40,  default: "", null: false
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

  add_foreign_key "api_keys", "users"
end
