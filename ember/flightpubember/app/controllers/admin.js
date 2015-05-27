import Ember from 'ember';


export default Ember.Controller.extend({
    content: {},
    promoFlightList: null,
    discountAmount: 0,
    actions: {

        toggleAccountStatus: function(user) {

            alert(user.get('accountStatus'));

            if ( user.get('accountStatus') === 'active' ) {
                user.set('accountStatus', 'inactive');
                user.save();
            } else {
                user.set('accountStatus', 'active');
                user.save();
            }

        },


        toggleAccountRole: function(user) {
            if ( user.get('role') === 'admin' ) {
                user.set('role', 'default');
            } else {
                user.set('role', 'admin');
            }
            user.save();
        },        

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

        },

        showUserAdmin: function() {
            Ember.$("#flight-admin").hide();
            Ember.$("#airline-admin").hide();
            Ember.$("#promotions-admin").hide();
            Ember.$("#users-admin").show();
        },


        showAirlineAdmin: function() {
            Ember.$("#flight-admin").hide();
            Ember.$("#airline-admin").show();
            Ember.$("#promotions-admin").hide();
            Ember.$("#users-admin").hide();
        },


        showFlightAdmin: function() {
            Ember.$("#flight-admin").show();
            Ember.$("#airline-admin").hide();
            Ember.$("#promotions-admin").hide();
            Ember.$("#users-admin").hide();
        },


        showPromotionAdmin: function() {
            Ember.$("#flight-admin").hide();
            Ember.$("#airline-admin").hide();
            Ember.$("#promotions-admin").show();
            Ember.$("#users-admin").hide();
        },
    }
});