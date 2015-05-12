import Ember from 'ember';

export default Ember.Route.extend({
  
    actions: {

        logout: function() {
            this.controllerFor('sessions').reset();
            this.transitionTo('sessions');
        }

    }

});