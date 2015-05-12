import Ember from 'ember';

/**
    This will act as a base object which we will use to protect
    all routes that we want to be protected
*/
var AuthenticatedRoute =  Ember.Route.extend({
  
    //Verify that the token property of the sessions controller is set before continuing with the request
    beforeModel: function(transition) {
        if(Ember.isEmpty(this.controllerFor('sessions').get('token'))) {
            return this.redirectToLogin(transition);
        }
    },

    //Redirect to the login page and store the current transition so we can run it again after login
    redirectToLogin: function(transition) {
        this.controllerFor('sessions').set('attemptedTransition', transition);
        return this.transitionTo('sessions');
    },

    actions: {

        error: function(reason, transition) {
            //If we get a 401 error, it is unauthorised so redirect to the login page
            if(reason.status === 401) {
                this.redirectToLogin(transition);
            } else {
                console.log("Unknown error");
            }
        }
    }
});

export default AuthenticatedRoute;