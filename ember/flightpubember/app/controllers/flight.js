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

	arrivalTimeHourDay: Ember.computed('arrivalTime', function(){
		var flightTime = this.get('arrivalTime');

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

	timeBarStyle: function(){
		var avgLength = this.get('controllers.flights.averageFlightTime');

		var flightTime = this.get('flightTime');

		var lengthRatio = flightTime/avgLength;

		var widthPercent = 100;
		var widthChange = 0;



		if(lengthRatio < 0.1)
		{
			widthChange = (lengthRatio);
		}
		else if(lengthRatio < 1)
		{
			widthChange = (lengthRatio);
		}
		else
		{
			widthChange = (lengthRatio);
		}

		if(widthChange > 1)
		{
			widthChange = Math.log10(lengthRatio);
		}
		else
		{
			widthChange += 0.2; 
		}


		widthPercent *= widthChange;


		var leftPercent = 8; // we have a base of 10 for style


		//var departureTime = this.get('departureTime');
		//var departurePercentage = departureTime/2400; //this is just using the current data, not correct at all

		// console.log(departurePercentage);

		//leftPercent += 0;//10*departurePercentage;

		return "width:"+widthPercent+"%; left: "+leftPercent+"%;";

	}.property('controllers.flights.averageFlightTime'),

	selected: false,

	actions: {
		
	}
});
