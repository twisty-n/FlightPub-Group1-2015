import Ember from 'ember';

export default Ember.ArrayController.extend({
  needs: ['application', 'sessions'],

  DepartureFlight: null,          // The journey that represents origin to dest
  ReturnFlight: null,             // Journey that represents dest to org(y)
  oneWay: false,
  currentSelection: 'departure',  
  numberOfTickets: 1,             // The number of tickets that the want to purchase

  showReviewRegistration: Ember.computed('controllers.application.isAuthenticated', function(){
    return !this.get('controllers.application.isAuthenticated');
  }),

  wrapperWidth: Ember.computed('showReviewRegistration', function(){
    var largeWidth = this.get('showReviewRegistration');

    if(largeWidth)
    {
      return 'large';
    }

    return 'small';
  }),

  pageTitle: Ember.computed('sortedFlights', function(){
    var flights = this.get('sortedFlights');
    var from = flights.get('firstObject').get('origin');
    var to = flights.get('firstObject').get('destination');
    return from+' to '+to;
  }),

  itemController: 'flight',
  sortProperties: Ember.A([]),
  filterProperties: Ember.A(['departure']),
  sortedFlights: Ember.computed.sort('filteredFlights', 'sortProperties'),

  noStops: false,
  
  maxStops: -1,
  maxStopsOptions: Ember.A([{max: "Max Stops", stops: -1}, {max: "1 Stop", stops: 1},{max: "2 Stops", stops: 2},{max: "3 Stops", stops: 3},{max: "4 Stops", stops: 4},{max: "5+ Stops", stops: 5}]),

  mustStopAt: 'Specify Stop',

  averageFlightTime: Ember.computed('sortedFlights', function(){

    var flights = this.get('sortedFlights');
    var timeCount = 0;

    flights.forEach(function(flight){
      timeCount += flight.get('flightLengthMinutes');
      console.log(flight.get('flightLengthMinutes'));
    });

    return timeCount/flights.length;
  }),

  filteredFlights: function(){

    var flights = this.get('model');


    if(!flights)
    {
      return flights;
    }


    var self = this;
    var filterProperties = this.get('filterProperties');

    flights = flights.filter(function(flight){
      
      var useFlight = false;

      if(self.get('currentSelection') === 'departure')
      {
        useFlight = (flight.get('isReturnFlight') === false);
      }
      else
      {
        useFlight = (flight.get('isReturnFlight') === true); 
      }

      if(useFlight && filterProperties.indexOf('noStops') >= 0)
      {
        useFlight = (flight.get('legs').length <= 1);
      }

      if(useFlight && self.get('maxStops') > 0)
      {
        useFlight = (flight.get('legs').length-1 <= self.get('maxStops'));
      }

      return useFlight;
    });

    return flights;

    // if(this.get('mustStopAt') !== ''){
    //   //not certain how to implement this. Have to look in the
    //   // stops array of the flight to find whether it contains
    //   // a stop at the place
    // }
    // return flights;




  }.property('model.isLoaded', 'currentSelection', 'filterProperties.@each', 'maxStops'),



  selectedFlight: null,
  
  actions: {

    sortBy: function(property) {

      this.send('updatePropertyStyle', property);

      var index = this.get('sortProperties').indexOf(property);
      if(index < 0)
      {
        this.get('sortProperties').pushObject(property);
      }
      else
      {
        this.get('sortProperties').removeObject(property);
      }

    },


    filterBy: function(property){

      this.send('updatePropertyStyle', property);
      console.log(property);

      var filterProperties = this.get('filterProperties');

      var index = filterProperties.indexOf(property);

      if(index < 0)
      {
        filterProperties.pushObject(property);
      }
      else
      {
        filterProperties.removeObject(property);
      }
    },

    updatePropertyStyle: function(property){
      var id = "";
      var on = false;


      if(this.get('sortProperties').indexOf(property) === -1 
        && this.get('filterProperties').indexOf(property) === -1)
      {
        on = true;
      }

      switch(property)
      {
        case 'price:asc': id = "#cheapest-first-filter"; break;
        case 'flightLengthMinutes:asc': id = "#shortest-first-filter"; break;
        case 'noStops': id = "#no-stops-filter"; break; 
      }

      if(id === "")
      {
        return;
      }

      if(on)
      {
        $(id).css({'background-color':'#1479C9', 'color':'#FFF'});
      }
      else
      {
        $(id).css({'background-color':'#FFF', 'color':'#17AEE5'});
      }
    },

    selected: function(flight){
     var currentSelectedFlight = this.get('selectedFlight'); 


     if(currentSelectedFlight)
     {
        //hide the current flight because no matter what click 
        // happens we want it to hide again
        var idResultItem = '#'+currentSelectedFlight.get('id')+' .result-item';
        var idDetails = '#'+currentSelectedFlight.get('id')+' .flight-details .flight-details-inner';

        $(idDetails).animate({height: 1}, 93, function(){
          $(idDetails).css({'display':'none'});
        });
        $(idResultItem).css({'background-color':'#47CEFF'})
      }

      if(flight === currentSelectedFlight)
      {
        this.set('selectedFlight', null);
      }
      else
      {
        this.set('selectedFlight', flight);

        //display the newly selected flight
        var flightID = '#' + flight.get('id')+' .flight-details .flight-details-inner';
        var flightIDResultItem = '#' + flight.get('id')+' .result-item';
        $(flightID).css({'display':'block'});
        $(flightID).animate({height: 93}, 93);
        $(flightIDResultItem).css({'background-color':'#4de723'})

      }
    },

    chooseFlight: function(flight){
      if(this.get('currentSelection') === 'departure')
      {
        this.set('DepartureFlight', flight);
        this.set('currentSelection', 'return')
      }
      else if(!this.get('oneWay'))
      {
        this.set('ReturnFlight', flight);
      }

      if(this.get('oneWay') || (this.get('DepartureFlight') != null && this.get('ReturnFlight') != null))
      {
        this.transitionToRoute('review');
      }
    },

    saveFlight: function(flight){
      if(this.get('controllers.application.isAuthenticated'))
      {

        console.log(this.get('controllers.application.currentUser'));  

        var data = {
          'journey_id': flight.id, 
          'user_id': this.get('controllers.application.currentUser'),
          'save_type': 'saved_flight',
          'account_type': 'regular'  //TODO: Adjust this later to look up the account type       
        };

        Ember.$.get('api/save', data).then(function(response){

          alert("Flight Saved!"); 

            //TODO: change this response to a cute little thing in the corner
            //      and update the save button to say saved

          }, function(error){

            if(error.status === 404) {
              alert('Unable to save, there was an issue connecting with the server');
            } else if (error.status === 422) {
              alert(error.responseJSON.status_message);
            } else if (error.status === 500) {
              alert('Unknown server error. Flight unable to be saved');
            }

          });
      } else {

        //The user isn't signed in. Tell them as such!
        alert('You need to be signed in to save flights!');

      }
    },

    setupUser: function() {
      var data = null;
      if (! this.get('controllers.application.isAuthenticated')) {

        if( this.get('reviewLoginShowing') ) {
          // Quickly grab their details and log the bastards in
          data = this.getProperties('email', 'password');
          this.get('controllers.sessions').send('loginUser', true, data);
        } else {
          // Gather the entered user details to submit to the server for purchasing
          data = this.getProperties('email', 'email_confirmation', 'password', 'password_confirmation');
          this.get('controllers.sessions').send('registerUser', true, data);
        }

      }
    },

    purchase: function(){

      //we need user id, so we need to have the user sign up if they're not logged in
      console.log(this.get('controllers.application.isAuthenticated'));
      console.log(this.get('controllers.application.currentUser'));

      if (this.get('cardNumber') == undefined 
        ||this.get('expiryDate') == undefined 
        ||this.get('securityCode') == undefined 
        ||this.get('nameOnCard') == undefined) {
        alert('Fill out payment details');
        return;
      }

      var user_id = this.get('controllers.application.currentUser');
      if (user_id == null) {
        alert('Please Log In or Register');
        return;
      }

      // Iterate over each flight in the journey to get the list of tickets
      var flights = this.get('DepartureFlight').get('legs');
      var flight;
      var departureTickets = new Array();
      var returnTickets = null;
      for (flight of flights) {
        departureTickets.push( flight['ticket'] );
      }

      // Don't include return tickets if its a one way trip
      if (! this.get('oneWay') ) {
        returnTickets = new Array();
        flights = this.get('ReturnFlight').get('legs');
        for (flight of flights) {
          returnTickets.push( flight['ticket'] );
        }
      }


      // Set up our data to get to the server
      var data =  this.getProperties(
        'ReturnFlight.id', 
        'DepartureFlight.id');

      var serverData = {
        'tickets_to_purchase': this.get('numberOfTickets'),
        'return_journey_id': data['ReturnFlight.id'],
        'departure_journey_id': data['DepartureFlight.id'],
        'user_id': user_id,
        'departure_tickets': departureTickets,
        'return_tickets': returnTickets,
        'save_type': 'purchased_flight',
        'account_type': 'regular'       
        // TODO: Change this ^^  if we implement business accounts
      }

      var _this = this;

      Ember.$.post('api/purchase', serverData).then(function(response) {

        alert('Flight purchased. Details will be emailed');

        _this.transitionToRoute('complete'); 

        _this.setProperties({
          ReturnFlight: null,
          DepartureFlight: null
        });

      }, function(error) {

        if (error.status === 404) {
          alert("Something went wrong! The server may be down.");
        } else if (error.status === 422) {
          console.log(error);
          alert('Unable to purchase flight. '+ error.responseJSON.errorCode)
          //Handle
        } else if (error.status === 500) {
          alert("An internal server error has occured. :(");
        } else {
          //Handle
        }

        alert("we will continue to the completed page because I want to show user flow");
        
        _this.transitionToRoute('complete');

      });

    },

    showLogin: function(){
      Ember.$("#purchase-register").hide();
      Ember.$("#purchase-login").show();
      this.set('reviewLoginShowing', true);
    },

    showRegister: function(){
      Ember.$("#purchase-register").show();
      Ember.$("#purchase-login").hide();
      this.set('reviewLoginShowing', false);
    },

    /**
     * Clear the searched flight data out so that it is not
     * persisted across application context changes
     * @return {[type]} [description]
     */
    clearSearchedFlights: function() {

      this.set('DepartureFlight', null);
      this.set('ReturnFlight', null);
      this.set('oneWay', false);
      this.set('currentSelection', 'departure');
      this.set('numberOfTickets', 1);  

      console.log("Clearing cached data");    
    }

  },

  reviewLoginShowing: false,


});