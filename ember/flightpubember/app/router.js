import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('user');
  this.route('admin');
  this.route('flights'); // needs aditional setup probably ??
  this.route('review'); // additional setup probably
  this.route('complete'); // additional setup probs too



});

export default Router;
