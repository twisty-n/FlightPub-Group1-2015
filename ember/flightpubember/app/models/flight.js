import DS from 'ember-data';

export default DS.Model.extend({
    flightNumber: DS.attr('string'),
    price:              DS.attr('string')
    /*seatsAvailable:     DS.attr('string'),
    departureTime:      DS.attr('string'),
    arrivalTime:        DS.attr('string')*/
});

/*
let Flight = DS.Model.extend({
	flightNumber: 		DS.attr('string'),
    price:              DS.attr('string'),
});

export default Flight;
*/
