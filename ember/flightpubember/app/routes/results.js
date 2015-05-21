import Ember from 'ember';

export default Ember.Route.extend({ 
    controllerName: 'flights',
    model: function() {

    	var searchFields = this.controllerFor('index').get('searchFields');

    	console.log(searchFields);

    	this.controllerFor('index').send('reset');
        return this.store.findQuery('flight', searchFields);
    },
   //  setupController: function(controller, model) {
   //  	controller.set('model', model);
  	// }
});

