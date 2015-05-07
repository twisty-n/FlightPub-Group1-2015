import Ember from 'ember';

export default Ember.Route.extend({
	model: function() {
    return this.store.find('flight');
  },
    setupController: function(controller, Flight) {
	    controller.set('model', Flight);
	 },
});

