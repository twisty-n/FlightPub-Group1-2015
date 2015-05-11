import DS from 'ember-data';

export default DS.Model.extend({
    flightNumber: DS.attr('string'),
    price:              DS.attr('string'),
    departureTime:      DS.attr('string'),
    arrivalTime:        DS.attr('string'),
    seatsAvailable:     DS.attr('string'),
  
    /*legs: DS.attr('array') I'm hoping this is a thing, we need to get all the legs of the flight*/
});

/*
let Flight = DS.Model.extend({
	flightNumber: 		DS.attr('string'),
    price:              DS.attr('string'),
});

export default Flight;
*/
