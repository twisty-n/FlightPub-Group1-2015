import Ember from 'ember';

export default Ember.ArrayController.extend({
  itemController: 'flight',
  sortProperties: Ember.A([]),
  sortedFlights: Ember.computed.sort('filteredFlights', 'sortProperties'),

  noStops: false,
  maxStops: -1,
  mustStopAt: '',

  filteredFlights: function(){
    var flights = this.get('model');

    if(!flights)
    {
      return flights;
    }

    return flights.filter(function(flight, index, enumerable){
        return flight.get('price') >= 600;
    });


    //TODO: make sure this is working, I don't think we
    //      currently have stops data
    if(this.get('noStops')){
      flights = flights.filter(function(flight){
        return (flight.get('stops') == 0);
      })
    }

    //TODO: make sure this also works
    if(this.get('maxStops') > 0)
    {
      flights = flights.filter(function(flight){
        return (flight.get('stops') > this.get('maxStops'));
      })
    }

    if(this.get('mustStopAt') != ''){
      //not certain how to implement this. Have to look in the
      // stops array of the flight to find whether it contains
      // a stop at the place
    }



    return flights;

  }.property('model.isLoaded', 'model', 'sortProperties'),


  selectedFlight: null,
  
  actions: {
    sortBy: function(property) {
    	var index = this.get('sortProperties').indexOf(property);
    	if(index < 0)
    	{
    		this.get('sortProperties').pushObject(property);
    	}
    	else
    	{
    		this.get('sortProperties').removeObject(property);
    	}
    	console.log(this.get('sortProperties'));
    },

    filterBy: function(property){

    }

  },

  flightByPrice: false
});