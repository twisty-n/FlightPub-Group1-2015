import Ember from 'ember';

export default Ember.Route.extend({

    controllerName: 'destinations',
    model:  function() {
    	return this.store.find('destination');
     },
     setupController: function(controller, model) {
     	controller.set('content', model);
     	controller.set('tickets', this.store.find('ticketClass'));
     	
     	controller.set('people', 
     		[   {number: "1"},
     			{number: "2"},
     			{number: "3"},
     			{number: "4"},
     			{number: "5"},
     			{number: "6"}
  			])
     }

});