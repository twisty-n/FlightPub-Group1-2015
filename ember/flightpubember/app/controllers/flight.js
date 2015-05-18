import Ember from 'ember';

export default Ember.ObjectController.extend({
	needs: ['flights'],

	timeBarStyle: Ember.computed('timeBarWidth', 'timeBarLeft', function() {
		var width = 'width:20%;';
		var left = 'left:50%;';

		// console.log(this.get('flight_time'));

		// //we can use this to get the longest flight and make everything relative to that
		// console.log("YOOO");
		// console.log(this.get('controllers.flights').get('sortedFlights'));

		// var f = this.get('controllers.flights.model');
		// console.log(f);

		return width + ' ' + left;
	}),

	selected: false,

	actions: {
		
	}
});
