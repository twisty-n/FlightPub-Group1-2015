import Ember from 'ember';

export default Ember.Route.extend({ 
    controllerName: 'flights',
    setupController: function(controller, model) {
        controller.set('currentUserModel', this.controllerFor('profile').get('model'));
    }
    
});
