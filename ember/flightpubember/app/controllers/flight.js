import Ember from 'ember';

export default Ember.ObjectController.extend({
	needs: ['flights'],

	// timeBarStyle: Ember.computed('timeBarWidth', 'timeBarLeft', function() {
	// 	var width = 'width:20%;';
	// 	var left = 'left:50%;';

	// 	console.log(this.get('controller.longestFlightTime'));

	// 	// console.log(this.get('flight_time'));

	// 	// //we can use this to get the longest flight and make everything relative to that
	// 	// console.log("YOOO");
	// 	// console.log(this.get('controllers.flights').get('sortedFlights'));

	// 	// var f = this.get('controllers.flights.model');
	// 	// console.log(f);

	// 	return width + ' ' + left;
	// }),

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
