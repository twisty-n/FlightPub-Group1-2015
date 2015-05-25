import Ember from 'ember';
import AuthenticatedRoute from 'flightpubember/routes/authenticated'


export default AuthenticatedRoute.extend({

    controllerName: 'admin',
    beforeModel: function() {

        // Check if the current user is an admin via API
        // if so, continue, else, redirect
        
        this._super();

        console.log(this);
        console.log('ChckingE');
        console.log(this.controllerFor('application').get('isAdmin'));

        var _this = this;
        if (! this.controllerFor('application').get('isAdmin') ) {
            console.log(_this);
            alert('UNAUTHORIZED');
            this.transitionTo('profile');
        }
    },

    setupController: function(controller, model) {
        controller.set('userList', this.store.find('user'));
    }
});