import Ember from 'ember';

export default Ember.ObjectController.extend({
	needs: ['destinations'],

	detail: Ember.computed('destinationCode','airport','countryName',function(){
		return this.get('destinationCode')+' - '+this.get('airport')+', '+this.get('countryName');
	}),

	actions: {
		fromSelected: function(){
			var selectedID = '#' + this.get('destinationCode');			
			$('#from').val($(selectedID).text());
			return true;
		},

		toSelected: function() {
			var selectedID = '#' + this.get('destinationCode');
			$('#to').val($(selectedID).text());	
			return true;
		}
	}
});
