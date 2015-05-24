import Ember from 'ember';
import AuthenticatedRoute from 'flightpubember/routes/authenticated'


export default AuthenticatedRoute.extend({

    beforeModel: function() {

        // Check if the current user is an admin via API
        // if so, continue, else, redirect

    },

    setupController: function(controller, model) {
     controller.set('model', this.store.find('user'));
     //controller.set('airlines', this.store.find('airlines'));
     //controller.set('users', this.store.find('users'));
    }
});