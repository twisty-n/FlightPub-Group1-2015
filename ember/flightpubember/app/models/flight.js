import DS from 'ember-data';

// Note that this no longer really represents a flight
// Rather, it represents a trip that is made up of 
// flights, which is what i like to say, a 'JOURNEY'
// 
// NOTE: The default ID that we get now on the front end is for a 
// journey, allowing us to save them as we go

export default DS.Model.extend({
    //Represents the flightNumber of the first flight in the trip
    flightNumber: 		DS.attr('string'),     
    //Composite price of the trip
    price:              DS.attr('number'),
    departureTime:      DS.attr('date'),
    arrivalTime:        DS.attr('date'),
    //Floor of the seats available for the trip
    seatsAvailable:     DS.attr('number'),
    //Total time in the air for the trip
    flightTime: 		DS.attr('number'),
    origin: 			DS.attr('string'),
    destination: 		DS.attr('string'),
    isReturnFlight:		DS.attr('boolean'),
    //The searched for ticket class for the trip
    ticketClass:        DS.attr('string'),

    // Each leg of the flight is represented as a hash
    // that we can pull values from
    legs:               DS.attr(),

    flightLengthMinutes: Ember.computed('legs', function(){
      // var departureTime = this.get('departureTime');
      // var arrivalTime = this.get('arrivalTime');
      function parseDate(input) {
        var parts = input.match(/(\d+)/g);
        // new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
        return new Date(Date.UTC(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5])); // months are 0-based
      }

          var departureTime = parseDate(this.get('legs').get('firstObject').departure_time);
          var arrivalTime = parseDate(this.get('legs').get('lastObject').arrival_time);

          console.log(departureTime);

          var milliseconds = arrivalTime - departureTime;

          var minutes = Math.floor(milliseconds / 1000 / 60);

          return Math.floor(minutes); 
    }),

  });