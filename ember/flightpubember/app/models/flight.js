import DS from 'ember-data';

// Note that this no longer really represents a flight
// Rather, it represents a trip that is made up of 
// flights

export default DS.Model.extend({
    flightNumber: 		DS.attr('string'),
    price:              DS.attr('number'),
    departureTime:      DS.attr('date'),
    arrivalTime:        DS.attr('date'),
    seatsAvailable:     DS.attr('number'),
  	flightTime: 		DS.attr('number'),
  	origin: 			DS.attr('string'),
  	destination: 		DS.attr('string'),
  	isReturnFlight:		DS.attr('boolean'),
    ticketClass:        DS.attr('string'),

    // Each leg of the flight is represented as a hash
    // that we can pull values from
    legs:               DS.attr()

});