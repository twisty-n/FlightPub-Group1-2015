import Ember from 'ember';

export default Ember.Route.extend({
    setupController: function(controller, model) {
    	controller.set('destinations', this.store.find('destination'));
     	controller.set('content', model);
     	controller.set('tickets', this.store.find('ticketClass'));
     	controller.set('people', [{number: "1"},{number: "2"},{number: "3"},{number: "4"},{number: "5"},{number: "6"}]);
    }

});