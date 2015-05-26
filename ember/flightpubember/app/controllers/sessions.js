import Ember from 'ember';

/*

Note that I handwrote this file from a tutorial, but then accidentally deleted it,
which is why it is cut and pasted back in

*/

export default Ember.ObjectController.extend({

  needs: ['users/signup'],

// initialization method to verify if there is a access_token cookie set
  // so we can set our ajax header with it to access the protected pages
  content: {},
  init: function() {
    this._super();
    if (Ember.$.cookie('access_token')) {
      Ember.$.ajaxSetup({
        headers: {
          'Authorization': 'Bearer ' + Ember.$.cookie('access_token')
        }
      });
    }
  },

  // overwriting the default attemptedTransition attribute from the Ember.Controller object
  attemptedTransition: null,

  // create and set the token & current user objects based on the respective cookies
  token:               Ember.$.cookie('access_token'),
  currentUser:         Ember.$.cookie('auth_user'),   //We are going to define the current user by their id alone
  userAuth:            null,

  //for switching between displays of login and register
  pageTitle: 'Login',
  

  // create a observer binded to the token property of this controller
  // to set/remove the authentication tokens
  tokenChanged: (function() {
    if (Ember.isEmpty(this.get('token'))) {
      Ember.$.removeCookie('access_token');
      Ember.$.removeCookie('auth_user');
    } else {
      Ember.$.cookie('access_token', this.get('token'));
      Ember.$.cookie('auth_user', this.get('currentUser'));
    }
  }).observes('token'),

  // reset the controller properties and the ajax header
  reset: function() {
    this.setProperties({
      email: null,
      password:          null,
      token:             null,
      currentUser:       null
    });
    Ember.$.ajaxSetup({
      headers: {
        'Authorization': 'Bearer none'
      }
    });
  },
  actions:              {
    // login action
    loginUser: function() {
      var _this = this;

      // get the properties sent from the form and if there is any attemptedTransition set
      var attemptedTrans = this.get('attemptedTransition');
      var data =           this.getProperties('email', 'password');

      // clear the form fields
      this.setProperties({
        email: null,
        password:          null
      });

      console.log('Attempting to login user');
      // send a POST request to the /sessions api with the form data
      Ember.$.get('api/session', data).then(function(response) {
          // set the ajax header with the returned access_token object
          Ember.$.ajaxSetup({
            headers: {
              'Authorization': 'Bearer ' + response.api_key.access_token
            }
          });

          // create a apiKey record on the local storage based on the returned object
          console.log("We got a good response!");
          console.log('The response was' + response)
          var key = _this.get('store').createRecord('apiKey', {
            accessToken: response.api_key.access_token
          });

          // find a user based on the user_id returned from the request to the /sessions api
          _this.store.find('user', response.api_key.user_id).then(function(user) {

            console.log(user);
            console.log(user.get('role'));

            // set this controller token & current user properties
            // based on the data from the user and access_token
            _this.setProperties({
              token:       response.api_key.access_token,
              currentUser: user['id'],//.getProperties('email', 'firstName', 'lastName'),
              userAuth:    user.get('role')
            });

            // set the relationship between the User and the ApiKey models & save the apiKey object
            key.set('user', user);
            key.save();

            user.get('apiKeys').pushObject(key);

            console.log(_this.get('currentUser'));

            // check if there is any attemptedTransition to retry it or go to the secret route
            if (attemptedTrans) {
              attemptedTrans.retry();
              _this.set('attemptedTransition', null);
            } else {
              if(user.get('role') == 'admin')
              {
                _this.transitionToRoute('admin');
              }
              else
              {
                _this.transitionToRoute('profile');
              }
            }

          });
        }, function(error) {
        if (error.status === 401) {
          // if there is a authentication error the user is informed of it to try again
          alert("wrong user or password, please try again");
        }
      });
    }
    ,
    registerUser: function() {
      console.log("register user called!");

      var _this = this;

//http://stackoverflow.com/questions/25632567/javascript-code-with-ember-js-password-confirm-password-matching-fields-with-em
//TODO: password and email confirmation checking

      var data = this.getProperties('email', 'password', 'email_confirmation', 'password_confirmation');
      _this.setProperties({
        email: null,
        email_confirmation: null,
        password: null,
        password_confirmation: null
      })
      this.get('controllers.users/signup').send('createUser', data);
    },

    toggleLoginShowing: function(){
      if(this.get('loginShowing')){
          $("#login-section").hide();
          $("#signup-section").show();
          this.set('loginShowing', false);
          this.set('pageTitle', 'Signup');
      }
      else
      {
          $("#login-section").show();
          $("#signup-section").hide();
          this.set('loginShowing', true);
          this.set('pageTitle', 'Login');

      }
    },


  }
});