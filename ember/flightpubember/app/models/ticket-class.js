import DS from 'ember-data';

export default DS.Model.extend({

	classCode: DS.attr('string'),
	details: DS.attr('string')
  
});
