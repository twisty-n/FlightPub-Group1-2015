class Airline < ActiveRecord::Base
  belongs_to :country
  has_many :flights
  
end
