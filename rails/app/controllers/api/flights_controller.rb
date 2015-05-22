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
    befDate = tryDate.advance(:minutes => -1)

    affDate = tryDate.advance(:days => 1)
    affDate = affDate.advance(:minutes => -1)

    #puts "Aff date #{affDate}"
    #puts "bff date #{befDate}"

    befDate = befDate.strftime('%Y-%m-%d %H:%M:%S UTC')
    affDate = affDate.strftime('%Y-%m-%d %H:%M:%S UTC')

    # Now fDate contains a correctly formatted date to query with
    
    
    render json: Flight.departs_on_day(befDate, affDate)
  end

  def show
    render json: Flight.find(params[:id])
  end

  def search

  end

end
