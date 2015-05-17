import Ember from 'ember';

export default Ember.ArrayController.extend({
  
  actions: {
  	flightSearch: function(){
  		console.log("no good, we're controlling it from the wrong controller :/");
  		console.log("but don't worry this means it works");
  	}
  }
  
});

