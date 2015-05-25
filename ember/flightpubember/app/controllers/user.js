export default Ember.ObjectController.extend({
    needs: ['admin'],

    fullName: function() {
        return this.get('user.firstName') + " " + this.get('model.lastName');
    }.property('model.firstName', 'model.lastName'),

    accountActive: function() {
        if (this.get('model.accountStatus') == 'active') {
            return true;
        } else {
            return false;
        }
    }.property('model.accountStatus')

});