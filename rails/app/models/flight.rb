class Flight < ActiveRecord::Base

    belongs_to :airline
    belongs_to :ticket_availability
    belongs_to :destination, class_name: "Destination"
    belongs_to :origin, class_name: "Destination"

    has_many :saved_flights
    has_many :users, :through => :saved_flights

end
