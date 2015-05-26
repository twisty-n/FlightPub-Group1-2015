import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {

  //Will need to convert some of these to their own resources

  this.route('user');
  this.route('admin');
  
  this.route('review'); // additional setup probably
  this.route('complete'); // additional setup probs too

  this.route('results');

  this.resource('sessions', function() {
    this.route('logout');
    this.route('login');
  });

  this.resource('users', function() {
    this.route('signup');
    //Do a profile route in here or something. It wil lbe protected by our api
  });

  this.route('profile');

  // When we implement the admin side, we'll create a route that has a server check to see
  // if the user accessing the route is an admin

});

export default Router;
