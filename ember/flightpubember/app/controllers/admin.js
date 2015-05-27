import Ember from 'ember';


export default Ember.Controller.extend({
    content: {},
    promoFlightList: null,
    discountAmount: 0,
    actions: {

        loadPromoFlights: function() {

            Ember.$("#promo-search").hide();
            Ember.$("#promo-select").show();

            var searchFields =  this.getProperties('flightNumberPromo', 
                'departDatePromo', 'maxDepartDatePromo');
            searchFields['q_type'] = 'promo';

            this.set('promoFlightList', 
                this.store.findQuery('flight', searchFields));
            console.log(this.get('promoFlightList'));


        },

        cancelPromoSelect: function() {

            // Invalidate the data here
            // 
            // Then display the normal form
            Ember.$("#promo-search").show();
            Ember.$("#promo-select").hide();
        },

        applyPromotion: function(flight) {

            var promo_flight = flight;
            var data = {
                flight_id: promo_flight.id,
                discount: this.get('discountAmount')
            }
            Ember.$.get('api/apply_promotion', data).then(function(response) {

                // Remove the record from the store
                promo_flight.unloadRecord();

            }, function(error) {
                alert('Unable to apply promotion to flight ' + promo_flight.id);
            });

        },

        setupDiscount: function() {

            var amount = parseInt(this.get('discount'));
            console.log(typeof amount);
            if ( typeof amount != 'number' ) {
                alert('Discount is not a valid price');
                this.set('discount', "");
                return;
            }

            this.set('discountAmount', amount);

        }

    }
});