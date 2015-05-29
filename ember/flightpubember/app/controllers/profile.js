import Ember from 'ember';


export default Ember.ObjectController.extend({

    needs: ['application', 'sessions', 'flights'],

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

                j.flight_time_hours = Math.floor(j.flight_time/60);
                j.flight_time_minutes = j.flight_time - (j.flight_time_hours*60); 

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
            var j = journey.journey.journey;
            if(journey.save_type === 'saved_flight')
            {
                Ember.set(j, 'flight_time_hours', Math.floor(j.flight_time/60));
                //j.flight_time_hours = Math.floor(j.flight_time/60);
                Ember.set(j, 'flight_time_minutes', j.flight_time - (j.flight_time_hours*60));
                //j.flight_time_minutes = j.flight_time - (j.flight_time_hours*60); 

                saved.pushObject(j);
            }
        });

        return saved;
    }.property('model.journeys.@each'),


    actions: {

        purchaseSavedJourney: function( journey ) {

            // Set oneWAy to true
            // Set departFlight to the journey
            // Transiition to new route
            // 
            // This wont work, need to hit the API with a special request to load
            // tickets
            var journey_id = journey.id;
            var data = {
                'journey_id':journey_id
            }
            var _this = this;
            Ember.$.get('api/journey_lookup', data).then( function(response) {

                console.log(response);

                journey = _this.store.createRecord('flight', response);

                _this.set('controllers.flights.oneWay', true);
                _this.set('controllers.flights.DepartureFlight', journey);
                _this.set('controllers.flights.currentSelection', 'departure');

                console.log(journey);

                var journeys = _this.get('model.journeys');
                console.log(journeys);

                var toDelete = null;
                journeys.forEach(function(journey) {
                    var j = journey.journey.journey;
                    if ( j.id == journey_id ) {
                        toDelete = journey;
                    }
                })

                console.log( toDelete );
                journeys.removeObject( toDelete );
                _this.get('model.journeys').notifyPropertyChange();

                _this.transitionToRoute('review');
            }, function( error ) {
                console.log(error);
                alert('Unable to purchase the flight at this time!');
            } );

        },

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
        },

        removeSavedJourney: function( journey ) {

            var data = {
                'user_id': this.get('controllers.application.currentUser'),
                'journey_id': journey.id,
                'save_type' : 'saved_flight'
            };

            var _journey = journey;
            var self = this;

            Ember.$.post('api/saved_journey', data).then( function(response) {

                // Remove the record from the store
                var journeys = self.get('model.journeys');
                console.log(journeys);

                var toDelete = null;
                journeys.forEach(function(journey) {
                    var j = journey.journey.journey;
                    if ( j.id == _journey.id ) {
                        toDelete = journey;
                    }
                })

                console.log( toDelete );
                journeys.removeObject( toDelete );
                self.get('model.journeys').notifyPropertyChange();

            }, function(error) {
                alert('Unable to delete ' + journey.id);
            });

        }


    }
	
});