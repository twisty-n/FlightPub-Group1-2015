import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('about');
  //this.resource('flights');

  this.resource('flights', function() {
      this.route('show', {path: ':flightNumber'});
  });

  this.resource('users', function() {
    this.route('show', {path: ':id'});
  });
});

export default Router;
