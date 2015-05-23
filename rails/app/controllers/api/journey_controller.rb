class Api::JourneyController < ApplicationController
=begin
    This controller will be used to manage the saving and purchasing of journeys
    Remember that a journey is a group of flights

=end

    def save
        # Called to save a journey via a common flight or standard
        # save. A saved journey is mapped to a user account
        # 
        print ("called params #{params}")

        render json: {
                "status" => "success"
                }, status: 201
    end

    def purchase
        # Called to purchase a journey
        # Purchasing a flight will map the flight to the users account
        # It will also adjust the availabilities for each of flights that make up a journey
    end

    def user_saved_flights
        # View a set of juorneys that are mapped to a user account

    end

end
