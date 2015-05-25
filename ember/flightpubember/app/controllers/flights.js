import Ember from 'ember';

export default Ember.ArrayController.extend({
  needs: ['application'],

  DepartureFlight: null,
  ReturnFlight: null,
  oneWay: true,
  currentSelection: 'departure',

  pageTitlte: 'SYD to MLB', //change this to get the to and from data from the form

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
        var id = '#'+currentSelectedFlight.get('id');

        $(id).animate({height: 1}, 93, function(){
          $(id).css({'display':'none'});
        });
      }

      if(flight === currentSelectedFlight)
      {
        this.set('selectedFlight', null);
      }
      else
      {
        this.set('selectedFlight', flight);

        //display the newly selected flight
        var flightID = '#' + flight.get('id');
        $(flightID).css({'display':'block'});
        $(flightID).animate({height: 93}, 93);

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
        var data = {flightID: flight.id, userID: this.get('controllers.application.currentUser.id')};

        Ember.$.get('apli/save', data).then(function(response){
            alert("Flight Saved!"); 
            //TODO: change this response to a cute little thing in the corner
            //      and update the save button to say saved
        }, function(error){
            if(error.status === 404)
            {
              alert('Unable to save, there was an issue connecting with the server');
            }
        });
      }
    },

    purchase: function(){
      //we need user id, so we need to have the user sign up if they're not logged in
      console.log(this.get('controllers.application.isAuthenticated'));
      console.log(this.get('controllers.application.currentUser'));

      var data =  this.getProperties('ReturnFlight.id', 'DepartureFlight.id', 'controllers.application.currentUser.id');

      console.log(data);

      var _this = this;

      Ember.$.get('api/purchse', data).then(function(response) {
        _this.transitionToRoute('complete'); 

        _this.setProperties({
          ReturnFlight: null,
          DepartureFlight: null
        });

      }, function(error) {
        if (error.status === 404) {
          alert("Something went wrong! The server may be down.");
        }
        alert("we will continue to the completed page because I want to show user flow");
        _this.transitionToRoute('complete');
      });

    },

  },

});