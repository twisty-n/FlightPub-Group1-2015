import Ember from 'ember';

export default Ember.ObjectController.extend({
	needs: ['flights'],

	flightLengthMinutesHours: function(){
		var flightTime = this.get('flightTime');

		var hours = Math.floor(flightTime/60);
		var minutes = flightTime - (hours*60);

		if(hours > 0)
		{
			var result = hours+"h ";
		}
		if(minutes > 0)
		{
			result += minutes+"m";
		}

		return result;
	}.property('flightTime'),


	departureTimeHourDay: Ember.computed('depatureTime', function(){
		var flightTime = this.get('departureTime');

		var hour = flightTime.getHours();
		var period = "am";
		var day = flightTime.getDay();

		if(hour == 0){
			hour = 12;
		}
		else if(hour >= 12)
		{
			period = "pm";
			if(hour > 12)
			{
				hour -= 12;
			}
		}

		switch(day)
		{
			case 0: day = "Sun"; break;
			case 1: day = "Mon"; break;
			case 2: day = "Tue"; break;
			case 3: day = "Wed"; break;
			case 4: day = "Thu"; break;
			case 5: day = "Fri"; break;
			case 6: day = "Sat"; break;
		}

		return hour+" "+period+" "+day;
	}),

	arrivalTimeHour: Ember.computed('arrivalTime', function(){
		var flightTime = this.get('arrivalTime');

		var hour = flightTime.getHours();

		if(hour == 0){
			hour = 12;
		}
		else if(hour > 12)
		{
			hour -= 12;
		}

		return hour;
	}),

	arrivalTimePeriod: Ember.computed('arrivalTimeHour', function(){
		
		if(this.get('arrivalTimeHour') >= 12)
		{
			return "pm";
		}

		return "am";
	}),

	arrivalTimeDay: Ember.computed('arrivalTime', function(){
		var flightTime = this.get('arrivalTime');
		var day = flightTime.getDay();

		switch(day)
		{
			case 0: day = "Sun"; break;
			case 1: day = "Mon"; break;
			case 2: day = "Tue"; break;
			case 3: day = "Wed"; break;
			case 4: day = "Thu"; break;
			case 5: day = "Fri"; break;
			case 6: day = "Sat"; break;
		}

		return day;
	}),

	//remove this and just call the sections from the handlebars
	arrivalTimeHourDay: Ember.computed('arrivalTimeHour', 'arrivalTimePeriod', 'arrivalTimeDay', function(){
		return this.get('arrivalTimeHour')+" "+this.get('arrivalTimePeriod')+" "+this.get('arrivalTimeDay');
	}),


	timeBarStyle: function(){
		var avgLength = this.get('controllers.flights.averageFlightTime');

		var flightTime = this.get('flightTime');

		var lengthRatio = flightTime/avgLength;

		var widthPercent = 100;


		widthPercent *= Math.log10(lengthRatio+1);
		widthPercent += Math.pow(10, Math.log10(lengthRatio)); 
		//widthPercent += 10; 
		


		//widthPercent *= widthChange;


		var leftPercent = 8; // we have a base of 8 for style


		return "width:"+widthPercent+"%; left: "+leftPercent+"%; min-width:100px;";

	}.property('controllers.flights.averageFlightTime'),

	legStyle: function(){
		var legs = this.get('legs');
		return "width: "+(55/legs.length-1)+"%;";
	}.property('legs'),

	layovers: Ember.computed('controllers.flights', function(){
		var layovers = Ember.A([]);

		var legs = this.get('legs');


		if(legs.length > 1)
		{

			//create a layover object which we use
			// to create instances of and insert into
			// the layovers array

			//this should probably be turned into a controller, but for
			// now this was way easier
			var layover = Ember.Object.extend({
				arrivalFlight: null,
				departureFlight: null,
				flightLength: null,
				flightDepartTime: null,
				flightArrivalTime: null,

				destination: Ember.computed('arrivalFlight', function(){
					return this.get('arrivalFlight.destination');
				}),

				layoverDuration: Ember.computed('arrivalFlight', 'departureFlight', function(){
					function parseDate(input) {
						var parts = input.match(/(\d+)/g);
						// new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
						return new Date(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5]); // months are 0-based
					}

					var arrival = parseDate(this.get('arrivalFlight.arrival_time'));
					var departure = parseDate(this.get('departureFlight.departure_time'));

					var diff = Math.abs(departure-arrival)/(1000*60);

					return diff;
				}),

				time: Ember.computed('arrivalFlight', 'departureFlight', function(){
					return Math.floor(this.get('layoverDuration')/60)+"h";
				}),

				arrivalHour: Ember.computed('arrivalFlight', function(){
					function parseDate(input) {
						var parts = input.match(/(\d+)/g);
						// new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
						return new Date(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5]); // months are 0-based
					}

					var layoverTime = parseDate(this.get('arrivalFlight.arrival_time'));

					var hour = layoverTime.getHours();

					if(hour == 0){
						hour = 12;
					}
					else if(hour > 12)
					{
						hour -= 12;
					}

					return hour;
				}),

				departureHour: Ember.computed('departureFlight', function(){
					function parseDate(input) {
						var parts = input.match(/(\d+)/g);
						// new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
						return new Date(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5]); // months are 0-based
					}

					var layoverTime = parseDate(this.get('departureFlight.arrival_time'));

					var hour = layoverTime.getHours();

					if(hour == 0){
						hour = 12;
					}
					else if(hour > 12)
					{
						hour -= 12;
					}

					return hour;
				}),

				arrivalPeriod: Ember.computed('arrivalFlight', function(){
					if(this.get('arrivalHour') >= 12)
					{
						return "pm";
					}

					return "am";
				}),

				departurePeriod: Ember.computed('departurePeriod', function(){
					if(this.get('departureHour') >= 12)
					{
						return "pm";
					}

					return "am";
				}),

				layoverStyle: function(){
					function parseDate(input) {
						var parts = input.match(/(\d+)/g);
						// new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
						return new Date(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5]); // months are 0-based
					}

					
					var layoverTimeMins = this.get('layoverDuration');
					var tripTimeMins = this.get('flightLength');
					



					var width = (layoverTimeMins/tripTimeMins); 

					var left = 8;

					var layoverStartDate = parseDate(this.get('arrivalFlight.arrival_time'));

					var flightDepartureDate = this.get('flightDepartTime');
					var flightArrivalDate = this.get('flightArrivalTime');
					
					left = Math.round(((flightArrivalDate - flightDepartureDate) * 100 ) / layoverStartDate);

					return "width: "+width+"%; left: "+left+"%; min-width:40px; max-width:100%;";
				}.property('layoverDuration', 'flightLength')

			});

			//we start at null, because each layover
			// needs to display data from the previous and 
			// current leg of the flight.
			var prevLeg = null;

			var self = this;
			legs.forEach(function(leg){
				
				if(prevLeg)
				{
					var l = layover.create({
						arrivalFlight: prevLeg,
						departureFlight: leg,
						flightLength: self.get('flightTime'),
						flightDepartTime: self.get('departureTime'),
						flightArrivalTime: self.get('arrivalTime'),

					});
					layovers.pushObject(l);
				}

				prevLeg = leg;
			});
			
		}

		return layovers;		
	}),

selected: false,

actions: {

}
});
