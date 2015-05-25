import Ember from 'ember';
import AuthenticatedRoute from 'flightpubember/routes/authenticated'


export default AuthenticatedRoute.extend({

    controllerName: 'admin',
    beforeModel: function() {

        // Check if the current user is an admin via API
        // if so, continue, else, redirect
        
        this._super();

        var _this = this;
        var user_id = this.controllerFor('application').get('currentUser');

        console.log(user_id);

        user_id = {
            'user_id': user_id
        }

        Ember.$.post('api/auth', user_id).then(function(response) {
            // Allow entry
        }, function(error) {
            alert('UNAUTHORISED');
            _this.transitionToRoute('profile');
        });
    },

    setupController: function(controller, model) {
        controller.set('userList', this.store.find('user'));
    }
});