import Ember from 'ember';
import AuthenticatedRoute from 'flightpubember/routes/authenticated'


export default AuthenticatedRoute.extend({
    controllerName: 'profile',
    model: function() {
        return  this.store.find('user', this.controllerFor('sessions').get('currentUser'));
    }
    /*
    setupController: function(controller, model) {
     controller.set('model', this.store.find('user', this.controllerFor('sessions').get('currentUser')));
    }
    */
});