import Ember from 'ember';
import AuthenticatedRoute from 'flightpubember/routes/authenticated'


export default AuthenticatedRoute.extend({
    setupController: function(controller, model) {
     controller.set('model', this.store.find('user'));
    }
});