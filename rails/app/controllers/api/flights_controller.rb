class Api::FlightsController < ApplicationController

  skip_authorize_resource :only => [:index, :show]
  skip_authorization_check 

  # Render all of the flight
  # This is used only for testing
  def index
    render json: Flight.all
  end

  def show
    render json: Flight.find(params[:id])
  end

end
