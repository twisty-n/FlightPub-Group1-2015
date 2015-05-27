class AddUrlToAirline < ActiveRecord::Migration
  def change
    change_table :airlines do |a|
        a.string :terms_url
    end
  end
end
