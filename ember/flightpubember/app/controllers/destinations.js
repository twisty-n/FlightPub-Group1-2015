import Ember from 'ember';

export default Ember.ArrayController.extend({
  itemController: 'destination',
  sortProperties: Ember.A([]),
  departLocations: Ember.computed.sort('model', 'sortProperties'),
  arriveLocations: Ember.computed.sort('model', 'sortProperties')
});