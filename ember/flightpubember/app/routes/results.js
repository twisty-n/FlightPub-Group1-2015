import Ember from 'ember';

export default Ember.Route.extend({ 
    controllerName: 'flights',
    
    beforeModel: function() {
      console.log('We called before model');
      Ember.$("#loader").css('display','block');
      // Or whatever
    },
    afterModel: function() {

      console.log('We called before model');
      Ember.$("#loader").css('display','block');
      // Again, or whatever

    },
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

