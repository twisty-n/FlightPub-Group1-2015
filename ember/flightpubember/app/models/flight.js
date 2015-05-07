import DS from 'ember-data';
/*
export default DS.Model.extend({
    flightNumber: DS.attr('string'),
    price:              DS.attr('string'),
    seatsAvailable:     DS.attr('string'),
    departureTime:      DS.attr('string'),
    arrivalTime:        DS.attr('string') 
});
*/

let flight = DS.Model.extend({
	flightNumber: 		DS.attr('string'),
    price:              DS.attr('string'), 
});

flight.reopenClass({
	FIXTURES: [
		{ id: 1, flightNumber: 'A301', price : 999 },
		{ id: 2, flightNumber: 'A302', price : 910 }
	]
});

export default flight;