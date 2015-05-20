import DS from 'ember-data';

//Allows access to an external API running on a rails backend that is
//scoped to an /api/----resource---- call
//to ensure this works, requests need to be proxied to localhost:3000
//Which is serviced by Rails
export default DS.ActiveModelAdapter.extend({
    namespace: 'api',

    findQuery: function(store, type, query) {

        console.log("We have called the flight search method");
        return this.ajax(this.buildURL(type.typeKey), 'GET', { data: query });

    }
});