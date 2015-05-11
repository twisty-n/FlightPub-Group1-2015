require 'active_record/fixtures'

class AddCountryIdToDesintation < ActiveRecord::Migration
  def change
    add_column :destinations, :country_id, :string

     # Now we will go through and update the information as well
=begin
    
rescue Exception => e
    
end
    Destination.reset_column_information

    dest = Destination.all
    if dest.length == 0
        # If there is no information there, go and add it
        Fixtures.create_fixtures('test/fixtures', File.basename("destinations.yml", '.*'))
        dest = Destination.all
        puts 'DID THE THING'
    end

    dest.each do |d|
        d.country_id = d.country_code_3
        d.save!
    end
=end
  end
end
