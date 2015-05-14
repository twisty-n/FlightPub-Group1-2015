class FlightSerializer < ActiveModel::Serializer
  attributes :id, :flight_number, :price, :seatsAvailable, :departureTime, :arrivalTime, :origin, :destination
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
