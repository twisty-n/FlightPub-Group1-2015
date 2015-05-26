import Ember from 'ember';
import AuthenticatedRoute from 'flightpubember/routes/authenticated'


export default AuthenticatedRoute.extend({

    controllerName: 'admin',
    beforeModel: function() {

        // Check if the current user is an admin via API
        // if so, continue, else, redirect
        
        this._super();
        var self = this;


            var user_id = self.controllerFor('application').get('currentUser');
             if (user_id == null || user_id == undefined) {
                console.log('We returned here');
                return false;
            }
            user_id = {
                'user_id': user_id
            }
            Ember.$.post('api/auth', user_id).then(function(response) {
            }, function(error) {
                console.log('not authenticated');
                self.transitionTo('profile');
            });
   
       
    },

    setupController: function(controller, model) {
        controller.set('users', this.store.find('user'));
    }
});