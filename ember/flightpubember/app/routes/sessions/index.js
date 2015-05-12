import Ember from 'ember';

export default Ember.Route.extend({
  
    controllerName: 'sessions',
    setupController: function(controller, context) {
        controller.reset()
    },
    beforeModel:function(transition) {
        //Before we go anyrt further, verify that the token property isn't empty
        if(!Ember.isEmpty(this.controllerFor('sessions').get('token'))) {
            this.transitionTo('secret');
        }
    }

});