import Ember from 'ember';

export default Ember.ObjectController.extend({
    
    // Require our sessions controller
    needs: ['sessions'],
    currentUserId: Ember.computed.alias('sessions.currentUser'),

    // Define a computer property that binds to the currentUser of the session controller and returns its value
    //We will define the current user by their ID alone
    currentUser: Ember.computed('controllers.sessions.currentUser', function() {
        return this.get('controllers.sessions.currentUser');
    }),

    isAuthenticated: (function() {
        return !Ember.isEmpty(this.get('controllers.sessions.currentUser'));
    }).property('controllers.sessions.currentUser'),

    isAdmin:(function() {
        var user_id = this.get('currentUser');
        console.log(user_id);
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
    }).property('currentUser')

});
