class Flight < ActiveRecord::Base

    belongs_to :airline
    belongs_to :destination, class_name: "Destination"
    belongs_to :origin, class_name: "Destination"

    belongs_to :leg_1, class_name: "Flight", foreign_key: "leg_1_id"
    belongs_to :leg_2, class_name: "Flight", foreign_key: "leg_2_id"

    has_many :ticket_availabilities
    has_many :saved_flights
    has_many :users, :through => :saved_flights

=begin
    Custom JSON method for a flight
=end
    
    # TODO: edit this later to return information based on the search
    def as_json(options={})
        
        {   
            :id => self.id,
            :flightNumber => self.flight_number,
            :price => self.ticket_availabilities.first.price,
            :departure_time => self.departure_time,
            :arrival_time => self.arrival_time,
            :seats_available => self.ticket_availabilities.first.seats_available,
            :flight_time => self.flight_time,
            :destination => self.destination.destination_code,
            :origin => self.origin.destination_code
        }

    end 

end
