import Ember from 'ember';

export default Ember.ObjectController.extend({
	needs: ['destinations'],

	detail: Ember.computed('destinationCode','airport','countryName',function(){
		return this.get('destinationCode')+' - '+this.get('airport')+', '+this.get('countryName');
	}),

	actions: {
		fromSelected: function(){
			this.send('destinationSelected', 'from');
		},

		toSelected: function() {
			this.send('destinationSelected', 'to');
		},

		destinationSelected: function(suggestionBox){
			this.send('suggestionSelected', this.get('destinationCode'), suggestionBox);
		}
	}
});
