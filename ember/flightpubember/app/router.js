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

/*
  Hax because reasons. The commented out route for some reason
  this.route('flights'); // needs aditional setup probably ??
  did not work
  This is because flights defines a resource, and is not just a plain route I think
  We define flights as a resource. Perhaps it would be a good idea to rename the page,
  and then manually pass the things in as we need them

  resource - a thing
  route - something to do with the thing

  Ok. Here comes the sermon. Due to the way we are declaring 'flights' to be
  its own resource, Ember does a greast deal of magic. The first thing to note is 
  now 'flights' essentially defines its own set of routes, and a flights namespace. 
  If we examine all of the generated routes, we can see things like flights.index, and
  a couple of others.

  Initially, when it wasn't working. We have out top level hbs template being mapped correctly
  to the first route created by Ember by the declaration below. That is, the localhost/flights
  template, which Alistair designed and provided. 

  However, this is not the template that receives our model definitions. The template which
  gets autogenreated Object and ArrayControllers, and which actually receives a 'model' property
  that the template will have access to is the flights.index template. 
  Physically, this means that we need a flights folder, inside which is an index.hbs
  This index.hbs recieves the array of flights, which we can then use to generate our list
  or whatever.
  This is then piped through to the toplevel locahost/flights template using an {outlet}

  Essentially, we were falling pray to the fact that we didn't fully understand what
  Ember was doing under the hood. 
  Following is the relevant bit of documentation that states all of the needed information, 
  albietly in a roundabout and flippant manner

  !!!! Start official ember documentation

  NOTE: If you define a resource using this.resource and do not supply a function, 
  then the implicit resource.index route is not created. In that case, /resource will only 
  use the ResourceRoute, ResourceController, and resource template.

Routes nested under a resource take the name of the resource plus their name as their route name. 
If you want to transition to a route (either via transitionTo or {{#link-to}}), make sure to use 
the full route name (posts.new, not new).

Visiting / renders the index template, as you would expect.

Visiting /posts is slightly different. It will first render the posts template. 
Then, it will render the posts/index template into the posts template's outlet.

Finally, visiting /posts/new will first render the posts template, then render 
the posts/new template into its outlet.

NOTE: You should use this.resource for URLs that represent a noun, and this.route
 for URLs that represent adjectives or verbs modifying those nouns. For example, 
 in the code sample above, when specifying URLs for posts (a noun), the route was 
 defined with this.resource('posts'). However, when defining the new action (a verb), 
 the route was defined with this.route('new').

 !!! End official ember documentation
  */
 /* this.resource('flights', function() {
    //When we define additional routes, these will correspond to their own template folders in the flights template folder
      //this.route('show', {path: ':flightNumber'});
  });*/




});

export default Router;
