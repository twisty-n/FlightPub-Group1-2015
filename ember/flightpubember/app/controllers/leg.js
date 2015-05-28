import Ember from 'ember';

export default Ember.ObjectController.extend({
	needs: ['flights'],

	isPromotionFlight: function(){
		return false;
	},
});