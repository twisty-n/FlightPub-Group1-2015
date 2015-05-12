import Ember from 'ember';

export default Ember.ObjectController.extend({
    
    // Require our sessions controller
    needs: ['sessions'],

    // Define a computer property that binds to the currentUser of the session controller and returns its value
    currentUser: (function() {
        this.get('controllers.sessions.currentUser')
    }).property('controllers.sessions.currentUser'),

    isAuthenticated: (function() {
        return !Ember.isEmpty(this.get('controllers.sessions.currentUser'));
    }).property('controllers.sessions.currentUser')

});
