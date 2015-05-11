import Ember from 'ember';

export default Ember.ArrayController.extend({
  itemController: 'flight',
  sortProperties: [],
  sortedFlights: Ember.computed.sort('model', 'sortProperties'),
  
  actions: {
    sortBy: function(sortProperties) {
      this.set('sortProperties', [sortProperties]);
    },
  }
});