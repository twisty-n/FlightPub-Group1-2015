import Ember from 'ember';

export default Ember.Route.extend({
  setupController: function(controller, flights) {
  	alert(controller);
    controller.set('model', flights.get('flights'));
  }
});