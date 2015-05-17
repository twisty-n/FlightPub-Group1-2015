import Ember from 'ember';
import Resolver from 'ember/resolver';
import loadInitializers from 'ember/load-initializers';
import config from './config/environment';
//import DS from 'ember-data';

Ember.MODEL_FACTORY_INJECTIONS = true;

var App = Ember.Application.extend({
  modulePrefix: config.modulePrefix,
  podModulePrefix: config.podModulePrefix,
  Resolver: Resolver
});

loadInitializers(App, config.modulePrefix);

//not sure this is the best place for this to be being called
Ember.View.reopen({
  didInsertElement : function(){
    this._super();
    Ember.run.scheduleOnce('afterRender', this, this.afterRenderEvent);
  },
  afterRenderEvent : function(){

    $("#departure-suggestions").niceScroll({
        mousescrollstep: 10,
        cursorcolor: "#fff",
        cursorborder: "0px solid #fff",
        railpadding: { top: 2, right: 2, left: 2, bottom: 2 },
     });

  	$("#return-suggestions").niceScroll({
  		mousescrollstep: 10,
  		cursorcolor: "#fff",
  		cursorborder: "0px solid #fff",
  		railpadding: { top: 2, right: 2, left: 2, bottom: 2 },
  	});

  	$("#departure-datepicker").datepicker({dateFormat: 'dd-mm-yy'});
  	$("#return-datepicker").datepicker({dateFormat: 'dd-mm-yy'});
  }
  
});

export default App;
