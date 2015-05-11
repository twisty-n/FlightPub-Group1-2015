import Ember from 'ember';

export default Ember.Route.extend({
    controllerName: 'flights',
    model: function() {
        return this.store.find('flight');
    },
   //  setupController: function(controller, model) {
   //  	controller.set('model', model);
  	// }
});

