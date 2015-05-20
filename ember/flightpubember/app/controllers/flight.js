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

	timeBarStyle: function(){
		var avgLength = this.get('controllers.flights.averageFlightTime');

		var thisLength = this.get('tripLength');

		var lengthRatio = thisLength/avgLength;

		var widthPercent = 85;

		console.log(avgLength+"/"+thisLength+" = "+lengthRatio);


		if(lengthRatio < 1)
		{
			widthPercent = widthPercent*lengthRatio*10;
		}

		if(widthPercent < 10)
		{
			widthPercent = 20;
		}

		if(widthPercent > 85)
		{
			widthPercent = 85;
		}

		return "width:"+widthPercent+"%; left: 0%;";

	}.property('controllers.flights.averageFlightTime'),

	selected: false,

	actions: {
		
	}
});
