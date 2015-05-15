import DS from 'ember-data';

var Destination =  DS.Model.extend({
	
	destinationCode: 	DS.attr('string'),
	airport: 			DS.attr('string'),
	countryCode2: 		DS.attr('string'),
	countryCode3: 		DS.attr('string'),
	countryName: 		DS.attr('string'),
	alternateName1: 	DS.attr('string'),

	setFields: function(fields) {

		this.setProperties({
			destinationCode: 	fields['destination_code'],
			airport: 			fields['airport'],
			countryCode2: 		fields['country']['country_code_2'],
			countryCode3: 		fields['country']['country_code_3'],
			countryName: 		fields['country']['country_name'],
			alternateName1: 	fields['country']['alternate_name_1']
		});

	}
  
});

export default Destination;