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


		widthPercent *= Math.log10(lengthRatio+1);
		widthPercent += Math.pow(10, Math.log10(lengthRatio)); 
		//widthPercent += 10; 
		


		//widthPercent *= widthChange;


		var leftPercent = 8; // we have a base of 8 for style


		return "width:"+widthPercent+"%; left: "+leftPercent+"%;";

	}.property('controllers.flights.averageFlightTime'),

	selected: false,

	actions: {
		
	}
});
