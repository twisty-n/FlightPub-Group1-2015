import Ember from 'ember';

export default Ember.ArrayController.extend({
  itemController: 'flight',
  sortProperties: Ember.A([]),
  sortedFlights: Ember.computed.sort('model', 'sortProperties'),
  
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
  },

  flightByPrice: false
});