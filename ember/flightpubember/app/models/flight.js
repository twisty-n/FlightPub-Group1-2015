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

let Flight = DS.Model.extend({
	flightNumber: 		DS.attr('string'),
    price:              DS.attr('string'), 
});


Flight.reopenClass({
    FIXTURES: [
		{ id: 1, flightNumber: 'A301', price : 999 },
        { id: 2, flightNumber: 'A302', price : 910 },
        { id: 3, flightNumber: 'A303', price : 999 },
		{ id: 4, flightNumber: 'A304', price : 910 }
	]
});



export default Flight;