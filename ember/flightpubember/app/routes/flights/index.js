import Ember from 'ember';

export default Ember.Route.extend({
	model: function() {
    return this.store.find('flight');
  },
    setupController: function(controller, flight) {
	    controller.set('model', flight);
	 },
});

