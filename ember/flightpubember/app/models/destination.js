import DS from 'ember-data';

var Destination =  DS.Model.extend({

	// Populate this with the ndeeded model attributes
	// 
	// Try to override set properties, or otherwise create  a custom method to set the,
	// 
	// We will create a custom method that will accept a hash and set all of the relevant properties
	
	destinationCode: 	DS.attr('string'),
	airport: 			DS.attr('string'),
	countryCode2: 		DS.attr('string'),
	countryCode3: 		DS.attr('string'),
	countryName: 		DS.attr('string'),
	alternateName1: 	DS.attr('string'),

	setFields: function(fields) {
		this.destinationCode = fields['destination_code'];
		this.airport = fields['airport'];
		this.country_code_2 = fields['country']['country_code_2'];
		this.country_code_3 = fields['country']['country_code_3'];
		this.country_name = fields['country']['country_name'];
		this.alternate_name_1 = fields['country']['alternate_name_1'];
	}
  
});

export default Destination;