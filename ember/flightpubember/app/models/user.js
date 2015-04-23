import DS from 'ember-data';

export default DS.Model.extend({
    email:          DS.attr('string'),
    firstName:      DS.attr('string'),
    lastName:       DS.attr('string'),
    infoString:            DS.attr('string'), //The infoString is a user bio
    accountStatus:  DS.attr('string')
});
