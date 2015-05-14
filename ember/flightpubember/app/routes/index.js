import Ember from 'ember';

export default Ember.Route.extend({

    controllerName: 'destinations',
    model:  function() {

      //console.log("hello!");
      var desintations = [];
      var self = this;
      Ember.$.get('api/destinations').then(function(response) {

        // Our response is now a JSON hash of the destinations
        //console.log("entered destinations access");
        //console.log("Server response:" + response);
        // 
        response.destinations.forEach( function(destination) {

          var destModel = self.store.createRecord('destination');
         // console.log("Destination Model: " + destModel);
          destModel.setFields(destination);
          //console.log ("Now we have set the fields");
          //console.log("New model" + destModel);
          desintations.addObject(destModel);

        });

        //console.log(desintations);
        return desintations;

      },
      function(error) {
        // Handle error
        console.log("We have an error creating destination list" + error)
        return [];
      });
  },
    
});