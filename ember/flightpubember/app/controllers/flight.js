import Ember from 'ember';

export default Ember.ObjectController.extend({
	timeBarWidth: 'width:50%;',
	timeBarLeft: 'left:10%;',
	timeBarStyle: function(){
		return this.get('timeBarWidth')+' '+this.get('timeBarLeft');
	}.property('timeBarLeft', 'timeBarWidth'),
	num: 10
});
