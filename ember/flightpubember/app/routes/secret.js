import Ember from 'ember';
import AuthenticatedRoute from 'flightpubember/routes/authenticated'

/**
    This will act as a base object which we will use to protect
    all routes that we want to be protected
*/
export default AuthenticatedRoute.extend({
    setupController: function(controller, model) {
     controller.set('words', "My testing words");
    }
});