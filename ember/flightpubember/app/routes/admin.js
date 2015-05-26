import Ember from 'ember';
import AuthenticatedRoute from 'flightpubember/routes/authenticated'


export default AuthenticatedRoute.extend({

    controllerName: 'admin',
    beforeModel: function() {

        // Check if the current user is an admin via API
        // if so, continue, else, redirect
        
        this._super();
        var user_id = this.get('currentUser');

        // Duplicated because I couldn't call it properly from 
        // the application controller
        function isAdmin() {
             if (user_id == null || user_id == undefined) {
                return false;
            }
            user_id = {
                'user_id': user_id
            }
            Ember.$.post('api/auth', user_id).then(function(response) {
                return true;
            }, function(error) {
                console.log(error);
                return false;
            });
        }
        if ( ! isAdmin ) {
            this.transitionTo('profile');
        }
       
    },

    setupController: function(controller, model) {
        controller.set('users', this.store.find('user'));
    }
});