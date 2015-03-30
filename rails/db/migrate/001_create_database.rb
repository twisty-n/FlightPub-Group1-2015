class CreateDatabase < ActiveRecord::Migration
  def self.up
    ActiveRecord::Schema.define(version: 0) do

		  create_table "users", primary_key: "userID", force: :cascade do |t|
		    t.string "fName",      limit: 40,  null: false
		    t.string "lName",      limit: 40,  null: false
		    t.string "infoString", limit: 200
		    t.string "password",   limit: 20,  null: false
		  end

	end
  end
 
  def self.down
    # drop all the tables if you really need
    # to support migration back to version 0
  end
end


