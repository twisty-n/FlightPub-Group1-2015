import DS from 'ember-data';

export default DS.Model.extend({
    flightNumber: 		DS.attr('string'),
    price:              DS.attr('number'),
    departureTime:      DS.attr('date'),
    arrivalTime:        DS.attr('date'), //number for now, we probably want date-time
    seatsAvailable:     DS.attr('number'),
  	tripLength: 		DS.attr('number'),
  	origin: 			DS.attr('string'),
  	destination: 		DS.attr('string'),

});