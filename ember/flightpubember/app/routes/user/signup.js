// signup route

import Ember from 'ember';

export default Ember.Route.extend({
     controllerName: 'users.signup',
    // Define our models controller to a new record
    model: function() {
        return this.store.createRecord('user');
    }
});
