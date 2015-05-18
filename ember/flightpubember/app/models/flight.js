import DS from 'ember-data';

export default DS.Model.extend({
    flightNumber: 		DS.attr('string'),
    price:              DS.attr('number'),
    departureTime:      DS.attr('number'),
    arrivalTime:        DS.attr('number'), //number for now, we probably want date-time
    seatsAvailable:     DS.attr('number'),
  
    /*legs: DS.attr('array') I'm hoping this is a thing, we need to get all the legs of the flight*/
});

/*
let Flight = DS.Model.extend({
	flightNumber: 		DS.attr('string'),
    price:              DS.attr('string'),
});

export default Flight;
*/
