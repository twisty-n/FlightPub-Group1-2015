class Api::DestinationsController < ApplicationController

    # Returns JSON form of all destinations, in the form of the following
=begin
    {"destinations":[
        {   "destination_code":"HBA",
            "airport":"Hobart",
            "country":{
                "country_code_2":"AU",
                "country_code_3":"AUS",
                "country_name":"Australia",
                "alternate_name_1":"Commonwealth of Australia"
            }
        },
        {   "destination_code":"ATL",
            "airport":"Atlanta",
            "country":{
                "country_code_2":"US",
                "country_code_3":"USA",
                "country_name":"United States",
                "alternate_name_1":"United States of America"
            }
        }
=end
    def index
        Destination.include_root_in_json = false
        render :json => Destination.all
    end
end