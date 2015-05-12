import Ember from 'ember';

export default Ember.Route.extend({
    controllerName: 'index',
    setupController: function(controller, model) {
        controller.set('test', "My Testing String!");
    }
});