import Ember from 'ember';

export default Ember.Route.extend({

    controllerName: 'index',
    
    setupController: function(controller, locations) {
        controller.set('test', "My Testing String!");
        controller.set('locations',  locations );
    }
});