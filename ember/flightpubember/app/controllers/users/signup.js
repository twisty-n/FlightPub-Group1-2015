import Ember from 'ember';

export default Ember.ObjectController.extend({

    needs: ['sessions'],
    actions: {


        createUser: function(formData) {

            var data = formData
            var user, _this;
            _this = this;

            //console.log(data);

            user = this.get('model');

            if (user == null) {
                user = this.store.createRecord('user');
            }

            user.setProperties(data);

            user.save().then(function(user) {

                var sessionsController = _this.get('controllers.sessions');
                sessionsController.setProperties({
                    email: data.email,
                    password: data.password
                });

                // Delete from local storage because it will be grabbed from api later
                user.deleteRecord();

                // Shunt the method over to sessions controller to handle the login
                sessionsController.send('loginUser');

            }, function(error) {
                if(error.status === 422) {
                    var errs = JSON.parse(error.responseText);
                    user.set('errors', errs.errors);
                    alert(errs.errors);
                }
            });
        }
    }
});
