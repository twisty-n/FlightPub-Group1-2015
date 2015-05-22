import DS from 'ember-data';

export default DS.Model.extend({
    flightNumber: 		DS.attr('string'),
    price:              DS.attr('number'),
    departureTime:      DS.attr('date'),
    arrivalTime:        DS.attr('date'), //number for now, we probably want date-time
    seatsAvailable:     DS.attr('number'),
  	flightTime: 		DS.attr('number'),
  	origin: 			DS.attr('string'),
  	destination: 		DS.attr('string'),
  	isReturnFlight:		DS.attr('boolean'),
    legs:               DS.attr()

});