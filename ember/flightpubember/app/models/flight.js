import DS from 'ember-data';

export default DS.Model.extend({
    flightNumber: 		DS.attr('string'),
    price:              DS.attr('number'),
    departureTime:      DS.attr('number'),
    arrivalTime:        DS.attr('number'), //number for now, we probably want date-time
    seatsAvailable:     DS.attr('number'),
  	tripLength: 		DS.attr('number'),

});