export default Ember.ObjectController.extend({
    needs: ['admin'],

    fullName: function() {
        return this.get('firstName') + " " + this.get('lastName');
    }.property('firstName', 'lastName'),

    accountActive: function() {
        if (this.get('model.accountStatus') == 'active') {
            return true;
        } else {
            return false;
        }
    }.property('model.accountStatus')

});