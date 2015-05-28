import Ember from 'ember';


export default Ember.ObjectController.extend({

    needs: ['application'],

    upcomingJourneys: function(){
        var journeys = this.get('model.journeys');

        var upcoming = Ember.A([]); 

        journeys.forEach(function(journey)
        {
            upcoming.pushObject(journey);
        });

        return upcoming;
    }.property('model.journeys'),

    pastJourneys: function(){
        
        return 'OY';
    }.property('model.journeys'),

    savedJourneys: function(){
        

        return 'Y O O O';

    }.property('model.journeys'),

    actions: {


        saveDetails: function() {

            var data = this.getProperties(
                'email', 'email_confirmation',
                'firstName', 'lastName', 'address'
            );

            var user = this.get('model');

            console.log(user);

            user.setProperties(data);
            var _this = this;
            user.save().then(function(user){

                // Save was successful, display success
                _this.setProperties({
                    'email_confirmation': "",
                    'password': "",
                    'password_confirmation': ""
                });
                alert('Your details were updated!');

            }, function(error) {

                if(error.status === 422) {
                    var errs = JSON.parse(error.responseText);
                    user.set('errors', errs.errors);
                    alert(errs.errors);
                } else {
                    alert('An unknown error has occured');
                }

            });


        },

        suspendAccount: function() {

            var user = this.get('model');
            var _this = this;
            user.destroyRecord().then(function() {
                _this.get('controllers.application').send('logout');
            }, function(error) {
                alert('Error while deleteing account');
            });
            

        }


    }
	
});