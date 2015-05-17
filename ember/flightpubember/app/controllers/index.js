import Ember from 'ember';

export default Ember.ArrayController.extend({

	fromDestination: '',
	toDestination: '',
	departDate: '',
	returnDate: '',
	selectedClass: '',
	numberOfPeople: 1,



	//these are the same destination search but for different inputs
	// I'm doing it this way to quickly move on to other stuff, and since
	// calling functions within controllers makes it hard to refactor, but
	// it's possible. 

	toDestinationSearch: function(){
		var filter = this.get('toDestination');
		console.log(filter);
		if(filter === undefined)
		{
			filter = '';
		}

		var result = this.get('destinations').filter(function(item, index, enumerable){
			var stringToMatch = '';
			stringToMatch += (item.get('destinationCode') || ''); 
			stringToMatch += (item.get('countryName') || '');
			stringToMatch += (item.get('alternateName1') || '');
			stringToMatch += (item.get('countryCode3') || '');
			stringToMatch += (item.get('countryCode2') || '');
			stringToMatch += (item.get('airport') || '');

			return stringToMatch.toLowerCase().match(filter.toLowerCase());
		});

		if(result.length === 0)
		{
			$("#to-box .drop-down").hide();
			$("#to-box .arrow").hide();
		}
		else
		{
			$("#to-box .drop-down").show();
			$("#to-box .arrow").show();
		}

		return result;

	}.property('toDestination'),

	fromDestinationSearch: function(){
		var filter = this.get('fromDestination');
		if(filter === undefined)
		{
			filter = '';
		}

		var result = this.get('destinations').filter(function(item, index, enumerable){
			var stringToMatch = '';
			stringToMatch += (item.get('destinationCode') || '');
			stringToMatch += (item.get('countryName') || '');
			stringToMatch += (item.get('alternateName1') || '');
			stringToMatch += (item.get('countryCode3') || '');
			stringToMatch += (item.get('countryCode2') || '');
			stringToMatch += (item.get('airport') || '');

			return stringToMatch.toLowerCase().match(filter.toLowerCase());
		});

		if(result.length === 0)
		{
			$("#from-box .drop-down").hide();
			$("#from-box .arrow").hide();
		}
		else
		{
			$("#from-box .drop-down").show();
			$("#from-box .arrow").show();
		}

		return result;

	}.property('fromDestination'),


	selectionMade: function(){
		console.log(this.get('fromDestination'));
	}.property('fromDestination'),


	actions: {
		flightSearch: function(){
			
			console.log(this.get('fromDestination'));
			console.log(this.get('toDestination'));
			console.log(this.get('departDate'));
			console.log(this.get('returnDate'));
			console.log(this.get('selectedClass'));
			console.log(this.get('numberOfPeople'));

			console.log("we will get all the stuff and send it away for processing");
		},

		setFrom: function(value){
			console.log("gotta set from value to "+value);
		},


		/* hovering and selecting from results list */

		hoveringSuggestions: function(){
			console.log("hovering");
			this.set('hoveringResults', true);
		},

		stoppedHoveringSuggestions: function(){
			this.set('hoveringResults', false);		
			console.log("off hover");
		},

		hideSuggestions: function(){
			if(!this.get('hoveringResults'))
			{
				$("#from-box .drop-down").hide();
				$("#from-box .arrow").hide();
				$("#to-box .drop-down").hide();
				$("#to-box .arrow").hide();
			}
		},

		fromSelected: function(){
			this.set('hoveringResults', false);
			this.send('hideSuggestions');
			this.set('fromDestination', $('#from').val());
		},

		toSelected: function(){
			this.set('hoveringResults', false);
			this.send('hideSuggestions');
			this.set('toDestination', $('#to').val());
		},
	}

});

