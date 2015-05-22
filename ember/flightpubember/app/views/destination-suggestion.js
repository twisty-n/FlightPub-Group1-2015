import Ember from 'ember';


export default Ember.View.extend({
	afterRenderEvent : function(){

	    $("#departure-suggestions").niceScroll({
	        mousescrollstep: 10,
	        cursorcolor: "#fff",
	        cursorborder: "0px solid #fff",
	        railpadding: { top: 2, right: 2, left: 2, bottom: 2 },
	     });

	},

	mouseEnter: function(){
		this.get('controller').send('hoveringSuggestions');
	},

	mouseLeave: function(){
		this.get('controller').send('stoppedHoveringSuggestions');
	},

	
});