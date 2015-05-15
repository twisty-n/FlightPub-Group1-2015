class FlightSerializer < ActiveModel::Serializer

# NOTE: Be careful when accessing leg IDs, they will be null if the flight is not a composite.
  attributes :id, :flight_number, :price, :seatsAvailable, :departureTime, :arrivalTime, :trip_length, :destination, :origin, :is_composite_flight, :leg_1_id, :leg_2_id
end


=begin
export default DS.Model.extend({
    flightNumber: DS.attr('string'),
    price:              DS.attr('string'),
    seatsAvailable:     DS.attr('string'),
    departureTime:      DS.attr('string'),
    arrivalTime:        DS.attr('string')
});
=end
