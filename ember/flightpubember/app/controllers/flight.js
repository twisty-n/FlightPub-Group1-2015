import Ember from 'ember';

export default Ember.ObjectController.extend({
	needs: ['flights'],

	timeBarStyle: Ember.computed('timeBarWidth', 'timeBarLeft', function() {
		var width = 'width:20%;';
		var left = 'left:50%;';

		return width + ' ' + left;
	}),

	selected: false,

	actions: {
		selected: function(){
			var flightsController = this.get('controllers.flights');

			var selectedFlight = flightsController.get('selected');


			var flightID = '#' + this.get('flightNumber');
			
			if(this.get('selected'))
			{
				this.set('selected', false);

				flightsController.set('selected', null);
				
				$(flightID).animate({height: 1}, 93, function(){
					$(flightID).css({'display':'none'});
				});

			}
			else
			{
				this.set('selected', true);
				
				if(selectedFlight != null)
				{
					selectedFlight.send('selected'); //toggles to deselected
				}

				flightsController.set('selected', this);

				$(flightID).css({'display':'block'});
				$(flightID).animate({height: 93}, 93);
			}
		},
	}
});
