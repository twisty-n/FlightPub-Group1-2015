require 'date'

class Api::FlightsController < ApplicationController

  skip_authorize_resource :only => [:index, :show]
  skip_authorization_check 

=begin

  Render all of the flights, this will just be an example route
  The json form of the response is

  {"flights":[{ "id":178523975,"flight_number":"DDD111",
                "price":1340,"seats_available":"25","departure_time":"64",
                "arrival_time":"1300","origin":"Orange","destination":"Orgeon",
                "flight_time":2700}, ... ]

=end
  def index

    # Search will need to be done here and accept params
    Rails.logger.info(params)

    # Started GET "/api/flights?
    #     originCode=HBA&
    #     destinationCode=VIE&
    #     departureDate=25-05-2015&
    #     returnDate=27-05-2015&
    #     ticketClass=&
    #     numberOfPeople=4" 

    # render json: Flight.take(10)
    
    # formatted_date = date.strftime('%a %b %d %H:%M:%S %Z %Y')
     
    tryDate = DateTime.parse(params['departureDate']).utc
    depDate = Time.utc(params['departureDate'])
    
    puts depDate
    puts tryDate

    fDate = tryDate.strftime('%Y-%m-%d %H:%M:%S %Z')
    puts "After formatting #{fDate}"
    
    render json: Flight.take(1)
  end

  def show
    render json: Flight.find(params[:id])
  end

  def search

  end

end
