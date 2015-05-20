class Flight < ActiveRecord::Base

    belongs_to :airline
    belongs_to :destination, class_name: "Destination"
    belongs_to :origin, class_name: "Destination"

    belongs_to :leg_1, class_name: "Flight", foreign_key: "leg_1_id"
    belongs_to :leg_2, class_name: "Flight", foreign_key: "leg_2_id"

    has_many :ticket_availabilities
    has_many :saved_flights
    has_many :users, :through => :saved_flights

end
