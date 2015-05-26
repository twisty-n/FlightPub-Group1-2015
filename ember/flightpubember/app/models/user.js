import DS from 'ember-data';

export default DS.Model.extend({
    email:                      DS.attr('string'),
    firstName:                  DS.attr('string'),
    lastName:                   DS.attr('string'),
    address:                 DS.attr('string'), //The infoString is a user bio
    accountStatus:              DS.attr('string'),

    role: 						DS.attr('string'),

    password:                   DS.attr('string'),
    password_confirmation:      DS.attr('string'),
    apiKeys:                    DS.hasMany('apiKey'),
    journeys:                   DS.attr,      
    errors:                     {},

});
