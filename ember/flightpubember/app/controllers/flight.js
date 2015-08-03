import Ember from 'ember';

export default Ember.ObjectController.extend({
	needs: ['flights'],

	flightLengthMinutesHours: function(){
		var flightTime = this.get('flightLengthMinutes');
		console.log(this.get('flightLengthMinutes'));
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
	}.property('flightLengthMinutes'),

	promoDiscountAmount: Ember.computed('legs', function(){
		var legs = this.get('legs');
		var discount = 0;

		legs.forEach(function(leg){
			if(leg.promotions.length > 0)
			{	
				var d = 0;
				leg.promotions.forEach(function(promoObj){
					d += promoObj.promotion.discount;
				})
				leg.discountPrice = d;
				discount += d;
			}
		});

		return discount;
	}),

	priceWithPromotion: Ember.computed('price', 'promoDiscountAmount', function(){
		var price = this.get('price');
		var discount = this.get('promoDiscountAmount');
		return (price-discount);
	}),

	hasPromotion: Ember.computed('promoDiscountAmount', 'priceWithPromotion', function(){
		//return true;
		//TODO: REINSTATE THIS RETURN WE JUST NEED TO DISABLE FOR DISPLAY SUTFF
		return this.get('priceWithPromotion') > 0 && this.get('promoDiscountAmount') > 0;
	}),

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

	arrivalTimeHourPeriod: Ember.computed('arrivalTime', function(){
		var flightTime = this.get('arrivalTime');
		var period = "am";
		var hour = flightTime.getHours();

		if(hour >= 12)
		{
			period = "pm";
		}

		if(hour == 0){
			hour = 12;
		}
		else if(hour > 12)
		{
			hour -= 12;
		}

		return hour+" "+period;
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
	arrivalTimeHourDay: Ember.computed('arrivalTimeHourPeriod', 'arrivalTimePeriod', 'arrivalTimeDay', function(){
		return this.get('arrivalTimeHourPeriod')+" "+this.get('arrivalTimeDay');
	}),


	timeBarStyle: function(){
		var avgLength = this.get('controllers.flights.averageFlightTime');

		var flightTime = this.get('flightLengthMinutes');

		var lengthRatio = flightTime/avgLength;

		var widthPercent = 100;


		widthPercent *= Math.log10(lengthRatio+1);
		widthPercent += Math.pow(10, Math.log10(lengthRatio)); 

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
				flightLengthMinutes: null,
				flightDepartTime: null,
				flightArrivalTime: null,

				destination: Ember.computed('arrivalFlight', function(){
					return this.get('arrivalFlight.destination');
				}),

				layoverDuration: Ember.computed('arrivalFlight', 'departureFlight', function(){
					function parseDate(input) {
						var parts = input.match(/(\d+)/g);
						// new Date(Date.UTC(year, month [, date [, hours[, minutes[, seconds[, ms]]]]]))
						return new Date(Date.UTC(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5])); // months are 0-based
					}

					var arrival = parseDate(this.get('arrivalFlight.arrival_time'));
					var departure = parseDate(this.get('departureFlight.departure_time'));

					var milliseconds = departure - arrival;

					var minutes = Math.round(milliseconds / 1000 / 60);

					return minutes;
				}),

				time: Ember.computed('arrivalFlight', 'departureFlight', function(){
					return Math.floor(this.get('layoverDuration')/60)+"h";
				}),

				arrivalHourPeriod: Ember.computed('arrivalFlight', function(){
					function parseDate(input) {
						var parts = input.match(/(\d+)/g);
						// new Date(Date.UTC(year, month [, date [, hours[, minutes[, seconds[, ms]]]]]))
						return new Date(Date.UTC(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5])); // months are 0-based
					}

					var layoverTime = parseDate(this.get('arrivalFlight.arrival_time'));

					var hour = layoverTime.getHours();
					var period = "am";

					if(hour >= 12)
					{
						period = "pm";
					}

					if(hour == 0){
						hour = 12;
					}
					else if(hour > 12)
					{
						hour -= 12;
					}

					return hour+" "+period;
				}),

				departureHourPeriod: Ember.computed('departureFlight', function(){
					function parseDate(input) {
						var parts = input.match(/(\d+)/g);
						// new Date(Date.UTC(year, month [, date [, hours[, minutes[, seconds[, ms]]]]]))
						return new Date(Date.UTC(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5])); // months are 0-based
					}

					var layoverTime = parseDate(this.get('departureFlight.arrival_time'));

					var hour = layoverTime.getHours();
					var period = "am";

					if(hour >= 12)
					{
						period =  "pm";
					}

					if(hour == 0){
						hour = 12;
					}
					else if(hour > 12)
					{
						hour -= 12;
					}

					return hour+" "+period;
				}),

				layoverStyle: function(){
					function parseDate(input) {
						var parts = input.match(/(\d+)/g);
						// new Date(Date.UTC(year, month [, date [, hours[, minutes[, seconds[, ms]]]]]))
						return new Date(Date.UTC(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5])); // months are 0-based
					}

					
					var layoverTimeMins = this.get('layoverDuration');
					var tripTimeMins = this.get('flightLengthMinutes');

					var width = (layoverTimeMins/tripTimeMins)*100; 

					var left = 0;

					var layoverStartDate = parseDate(this.get('arrivalFlight.arrival_time'));
					var tripStartDate = this.get('flightDepartTime');

					var diffMilliseconds = (layoverStartDate - tripStartDate);

					var timeDiffMins = Math.floor(diffMilliseconds / 1000 / 60);

					left = timeDiffMins/(tripTimeMins)*100;


					return "width: "+width+"%; left: "+left+"%; min-width:40px; max-width:100%;";
				}.property('layoverDuration', 'flightLengthMinutes')

			});

			//we start at null, because each layover
			// needs to display data from the previous and 
			// current leg of the flight.
			var prevLeg = null;

			var self = this;

			function parseDate(input) {
				var parts = input.match(/(\d+)/g);
				// new Date(Date.UTC(year, month [, date [, hours[, minutes[, seconds[, ms]]]]]))
				return new Date(Date.UTC(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5])); // months are 0-based
			}

			legs.forEach(function(leg, index){
				
				if(prevLeg)
				{
					var l = layover.create({
						arrivalFlight: prevLeg,
						departureFlight: leg,
						flightLengthMinutes: self.get('flightLengthMinutes'),
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
