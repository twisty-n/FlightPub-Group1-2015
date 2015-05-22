class Flight < ActiveRecord::Base

    belongs_to :airline
    belongs_to :destination, class_name: "Destination"
    belongs_to :origin, class_name: "Destination"

    belongs_to :leg_1, class_name: "Flight", foreign_key: "leg_1_id"
    belongs_to :leg_2, class_name: "Flight", foreign_key: "leg_2_id"

    has_many :ticket_availabilities
    has_many :saved_flights
    has_many :users, :through => :saved_flights

    # We create some custom scopes that represnt common queries
    
    scope :departs_on_day, -> (affDate, befDate) { where(" departure_time > ? AND departure_time < ?", affDate, befDate) }

    scope :economy,         -> { joins(:ticket_availabilities).merge(TicketAvailability.economy) }
    scope :premium_economy, -> { joins(:ticket_availabilities).merge(TicketAvailability.premium_economy) }
    scope :business,        -> { joins(:ticket_availabilities).merge(TicketAvailability.business) }
    scope :first_class,     -> { joins(:ticket_availabilities).merge(TicketAvailability.first_class) }

=begin

scope :awaiting_quote, -> { joins(:surveys).
  joins('LEFT OUTER JOIN quotes ON quotes.job_id = jobs.id').
  where('survey_date < :current_time', { current_time: Time.current }).
  where('quotes.id IS NULL')
}

Client.joins(:orders).where('orders.created_at' => time_range)

 SELECT  `flights`.* FROM `flights` INNER JOIN `destinations` ON `destinations`.`id` = `flights`.`destination_id` WHERE `destinations`.`destination_code` = 'LGA'

 Client.joins(:orders).where(orders: { created_at: time_range })

 "INNER JOIN pricing_points \
    ON pricing_points.minimum < products.price \
    AND pricing_points.maximum >= products.price"

=end
    scope :destination, -> (dest_code) { joins(:destination).where('destinations.destination_code' => dest_code) }

    scope :origin, -> (origin_code) { joins( 'LEFT JOIN destinations ON destinations.id = flights.origin_id' ).where(destinations: { destination_code: origin_code }) }

    # scope :org_and_dest(org_code, dest_code) { joins( 'LEFT JOIN destinations ON destinations.id = flights.origin_id' ) }

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
            :origin => self.origin.destination_code,
            :is_return_flight => [false].sample
        }

    end 

end
