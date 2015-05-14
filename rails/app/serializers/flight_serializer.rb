class FlightSerializer < ActiveModel::Serializer
  attributes :id, :flight_number, :price, :seats_available, :departure_time, :arrival_time, :origin, :destination
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
