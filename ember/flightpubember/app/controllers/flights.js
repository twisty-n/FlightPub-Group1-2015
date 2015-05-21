import Ember from 'ember';

export default Ember.ArrayController.extend({

  DepartureFlight: null,
  ReturnFlight: null,
  oneWay: false,
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

    //thinking we might actually want to use the average length
    // and stretch based on the average time.
    // but for now we will get the longest.

    var timeCount = 0;

    flights.forEach(function(flight){
      timeCount += flight.get('flightTime');
    });

    var average = timeCount/flights.length;

    return average;
  }),

  filteredFlights: function(){

    console.log(this.get('sortProperties'));
    
    var flights = this.get('model');

    if(!flights)
    {
      return flights;
    }

    
    return flights.filter(function(flight, index, enumerable){
      return flight.get('price') >= 0;
    });


    //TODO: we also need to filter by the 'departure' or 'return'


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




  }.property('model.isLoaded', 'model', 'sortProperties'),



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
        this.send('toggleDepartureReturnFlights');
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

    toggleDepartureReturnFlights: function(){
        this.set('currentSelection', 'ReturnFlight');
        var filterProperties = this.get('filterProperties');

        if(filterProperties.indexOf('departure') > 0)
        {

          //also need to update the title

          filterProperties.removeObject('departure');
          filterProperties.pushObject('return');
        }
        else if(filterProperties.indexOf('return') > 0)
        {
          filterProperties.removeObject('return');
          filterProperties.pushObject('departure');
        }

    }

  },
});