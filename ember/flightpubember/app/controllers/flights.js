import Ember from 'ember';

export default Ember.ArrayController.extend({
  needs: ['application'],

  DepartureFlight: null,          // The journey that represents origin to dest
  ReturnFlight: null,             // Journey that represents dest to org(y)
  oneWay: false,
  currentSelection: 'departure',  
  numberOfTickets: 1,             // The number of tickets that the want to purchase

  pageTitlte: 'SYD to MLB',       // Change this to get the to and from data from the form

  itemController: 'flight',
  sortProperties: Ember.A([]),
  filterProperties: Ember.A(['departure']),
  sortedFlights: Ember.computed.sort('filteredFlights', 'sortProperties'),

  noStops: false,
  maxStops: -1,
  mustStopAt: '',

  averageFlightTime: Ember.computed('sortedFlights', function(){

    var flights = this.get('sortedFlights');
    var timeCount = 0;

    flights.forEach(function(flight){
      timeCount += flight.get('flightTime');
    });

    return timeCount/flights.length;
  }),

  filteredFlights: function(){

    var flights = this.get('model');

    if(!flights)
    {
      return flights;
    }

    if(this.get('currentSelection') === 'departure')
    {
      flights = flights.filter(function(flight){
        return (flight.get('isReturnFlight') === false);        
      });
    }
    else
    {
      flights = flights.filter(function(flight){
        return (flight.get('isReturnFlight') === true);        
      });
    }

    return flights;

    //TODO: make sure this is working, I don't think we
    //      currently have stops data
    // if(this.get('noStops')){
    //   flights = flights.filter(function(flight){
    //     return (flight.get('stops') === 0);
    //   });
    // }

    // //TODO: make sure this also works
    // if(this.get('maxStops') > 0)
    // {
    //   flights = flights.filter(function(flight){
    //     return (flight.get('stops') > this.get('maxStops'));
    //   });
    // }

    // if(this.get('mustStopAt') !== ''){
    //   //not certain how to implement this. Have to look in the
    //   // stops array of the flight to find whether it contains
    //   // a stop at the place
    // }
    // return flights;




  }.property('model.isLoaded', 'model', 'sortProperties', 'currentSelection'),



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
        case 'flightTime:asc': id = "#shortest-first-filter"; break;
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
        $(flightIDResultItem).css({'background-color':'#43e517'})

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

    purchase: function(){

      //we need user id, so we need to have the user sign up if they're not logged in
      console.log(this.get('controllers.application.isAuthenticated'));
      console.log(this.get('controllers.application.currentUser'));

      if (! this.get('controllers.application.isAuthenticated')) {

        // Currently the user needs to be signed in in order to purchase a flight
        // we will allow this inline, but for now, alert and about
        
        alert('You must be signed in in order to purchase a flight!');
        this.transitionToRoute('results');
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
        'user_id': this.get('controllers.application.currentUser'),
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

  },

});