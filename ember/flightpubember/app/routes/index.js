import Ember from 'ember';

export default Ember.Route.extend({

    controllerName: 'destinations',
    model:  function() {
    	return this.store.find('destination');
     },
     setupController: function(controller, model) {
     	controller.set('content', model);
     	controller.set('tickets', this.store.find('ticketClass'));
     }

});