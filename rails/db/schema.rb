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

ActiveRecord::Schema.define(version: 20150324235510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", primary_key: "userID", force: :cascade do |t|
    t.string   "fName",            limit: 40,  default: "", null: false
    t.string   "lName",            limit: 40,  default: "", null: false
    t.string   "infoString",       limit: 200
    t.string   "password_digest",  limit: 255
    t.string   "role",             limit: 255
    t.string   "email",            limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.string   "uid",              limit: 255
    t.string   "provider",         limit: 255
    t.string   "account_status"
  end

  add_index "users", ["email"], name: "index_Users_on_email", unique: true, using: :btree
  add_index "users", ["userID"], name: "userID", unique: true, using: :btree

end
