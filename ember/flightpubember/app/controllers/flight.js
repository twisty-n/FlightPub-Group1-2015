import Ember from 'ember';

export default Ember.ObjectController.extend({
	timeBarStyle: Ember.computed('timeBarWidth', 'timeBarLeft', function() {
		var width = 'width:20%;';
		var left = 'left:50%;';

		return width + ' ' + left;
	}),
});