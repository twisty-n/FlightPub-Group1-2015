import Ember from 'ember';

export default Ember.ArrayController.extend({


//these are the same destination search but for different inputs
// I'm doing it this way to quickly move on to other stuff, and since
// calling functions within controllers makes it hard to refactor, but
// it's possible. 
  toDestinationSearch: function(){
  		var filter = this.get('to');
  		if(filter == undefined || (/\S/.test(filter)) )
  		{
  			filter = '';
  		}

  		var result = this.get('destinations').filter(function(item, index, enumerable){
  			var stringToMatch = '';
  				stringToMatch += item.get('destinationCode') || ''; 
	  			stringToMatch += item.get('countryName') || '';
	  			stringToMatch += item.get('alternateName1') || '';
	  			stringToMatch += item.get('countryCode3') || '';
	  			stringToMatch += item.get('countryCode2') || '';
	  			stringToMatch += item.get('airport') || '';

  			return stringToMatch.toLowerCase().match(filter.toLowerCase());
		});

		console.log(result);
		return result;

  }.property('to'),

  fromDestinationSearch: function(){
  		var filter = this.get('from');
  		if(filter == undefined || (/\S/.test(filter)) )
  		{
  			filter = '';
  		}
		
		var result = this.get('destinations').filter(function(item, index, enumerable){
  			var stringToMatch = '';
  				stringToMatch += item.get('destinationCode') || '';
	  			stringToMatch += item.get('countryName') || '';
	  			stringToMatch += item.get('alternateName1') || '';
	  			stringToMatch += item.get('countryCode3') || '';
	  			stringToMatch += item.get('countryCode2') || '';
	  			stringToMatch += item.get('airport') || '';

	  			return stringToMatch.toLowerCase().match(filter.toLowerCase());
		});

		if(result.length == 0)
		{
			$("#left-box .drop-down").hide();
			$("#left-box .arrow").hide();
		}
		else
		{
			$("#left-box .drop-down").show();
			$("#left-box .arrow").show();
		}
		console.log(result);
		return result;

  }.property('from'),

  actions: {
  	flightSearch: function(){
  		console.log("no good, we're controlling it from the wrong controller :/");
  		console.log("but don't worry this means it works");
  	},

  	setFrom: function(value){
  		console.log("gotta set from value to "+value);
  	},
  }
  
});

