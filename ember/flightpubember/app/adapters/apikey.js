import DS from 'ember-data';

//Override the default adapter because we dont need it communicating to the API constantly
export default DS.ActiveModelAdapter.extend({
    namespace: 'emberauth-keys'
});
