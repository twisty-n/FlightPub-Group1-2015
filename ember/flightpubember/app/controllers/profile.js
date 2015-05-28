import Ember from 'ember';


export default Ember.ObjectController.extend({

    needs: ['application'],

    //we can separate these into a single
    // purchased flight array and then return the results from there
    // would reduce code reuse
    upcomingJourneys: function(){
        function parseDate(input) {
            var parts = input.match(/(\d+)/g);
            // new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
            return new Date(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5]); // months are 0-based
        }

        var journeys = this.get('model.journeys');

        var upcoming = Ember.A([]); 

        journeys.forEach(function(journey)
        {
            var j = journey.journey.journey;
            
            if(journey.save_type === 'purchased_flight' 
            && parseDate(j.departure_time) > new Date())
            {

                j.hasMultipleFlights = false;
                
                j.flight_time_hours = Math.floor(j.flight_time/60);
                j.flight_time_minutes = j.flight_time - (j.flight_time_hours*60); 

                if(j.flights.length > 1)
                {
                    j.hasMultipleFlights = true;
                }

                upcoming.pushObject(j);
            }
        });
        console.log('Upcoming: ');
        console.log(upcoming);
        return upcoming;
    }.property('model.journeys'),

    pastJourneys: function(){
        function parseDate(input) {
            var parts = input.match(/(\d+)/g);
            // new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
            return new Date(parts[0], parts[1]-1, parts[2], parts[3], parts[4], parts[5]); // months are 0-based
        }

        var journeys = this.get('model.journeys');

        var past = Ember.A([]); 

        journeys.forEach(function(journey)
        {
            if(journey.save_type === 'purchased_flight' 
            && parseDate(journey.journey.journey.departure_time) <= new Date())
            {
                past.pushObject(journey.journey.journey);
            }
        });
        console.log('Past: ');
        console.log(past);
        return past;
    }.property('model.journeys'),

    savedJourneys: function(){
        var journeys = this.get('model.journeys');

        var saved = Ember.A([]); 

        journeys.forEach(function(journey)
        {
            if(journey.save_type === 'purchased_flight')
            {
                saved.pushObject(journey.journey.journey);
            }
        });

        return saved;
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
            

        },

        showSettings: function(){
            Ember.$("#purchased-flights").hide();
            Ember.$("#saved-flights").hide();
            Ember.$("#settings").show();
            this.send('setActive', '#settings-switch');
        },

        showSaved: function(){

            Ember.$("#purchased-flights").hide();
            Ember.$("#saved-flights").show();
            Ember.$("#settings").hide();
            this.send('setActive', '#saved-trips-switch');
        },

        showPurchased: function(){
            Ember.$("#purchased-flights").show();
            Ember.$("#saved-flights").hide();
            Ember.$("#settings").hide();
            this.send('setActive', '#purchased-trips-switch');
        },

        setActive: function(activeID){
            Ember.$("#purchased-trips-switch").removeClass("user-nav-active");
            Ember.$("#saved-trips-switch").removeClass("user-nav-active");
            Ember.$("#settings-switch").removeClass("user-nav-active");

            Ember.$(activeID).addClass("user-nav-active");
        }


    }
	
});