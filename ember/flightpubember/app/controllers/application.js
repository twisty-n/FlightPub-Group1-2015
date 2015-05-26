import Ember from 'ember';

export default Ember.ObjectController.extend({
    
    // Require our sessions controller
    needs: ['sessions'],

    // Define a computer property that binds to the currentUser of the session controller and returns its value
    //We will define the current user by their ID alone
    currentUser: Ember.computed('controllers.sessions.currentUser', function() {
        return this.get('controllers.sessions.currentUser');
    }),

    isAuthenticated: (function() {
        return !Ember.isEmpty(this.get('controllers.sessions.currentUser'));
    }).property('controllers.sessions.currentUser'),

    checkAdmin: function() {
        console.log(this.get('controllers.sessions.userAuth'));
        return this.get('controllers.sessions.userAuth') === 'admin';
    }.property('controllers.sessions.userAuth')

});
