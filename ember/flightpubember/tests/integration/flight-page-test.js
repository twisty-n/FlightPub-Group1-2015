import Ember from 'ember';
import startApp from '../helpers/start-app';
import { module, test } from 'qunit';
import Pretender from 'pretender';

var App, server;

/**
    flights template:

    {
        flightNumber:       "",
        price:              "",
        seatsAvailable:     "",
        departureTime:      "",
        arrivalTime:        ""   
    }
*/

module('Integration - Flights Page', {
    beforeEach: function() {
        App = startApp();
        var flights = [
            {
                flightNumber:       "AAA111",
                price:              "$1200",
                seatsAvailable:     "60",
                departureTime:      "12.30",
                arrivalTime:        "1.50"   
            },
             {
                flightNumber:       "BBB111",
                price:              "$1200",
                seatsAvailable:     "60",
                departureTime:      "12.30",
                arrivalTime:        "1.50"   
            },
             {
                flightNumber:       "CCC111",
                price:              "$1200",
                seatsAvailable:     "60",
                departureTime:      "12.30",
                arrivalTime:        "1.50"   
            },
             {
                flightNumber:       "DDD111",
                price:              "$1200",
                seatsAvailable:     "60",
                departureTime:      "12.30",
                arrivalTime:        "1.50"   
            },
        ];

        server = new Pretender(function() {
            this.get('/api/flights', function(request) {
                return ['200', {"Content Type": "application/json"}, JSON.stringify({flights: flights})];
            });

            this.get('/api/flights/:flightNumber', function(request) {
                var flight = flights.find(function(flight) {
                    if (flight.flightNumber === parseInt(request.params.flightNumber)) {
                        return flight;
                    }
                });
                return ['200', {"Content Type": "application/json"}, JSON.stringify({flight: flight})];
            });

        });
    },
    afterEach: function() {
        Ember.run(App, 'destroy');
        server.shutdown();
    }
});

test('Should allow navigation from flights to landing', function(assert) {
    visit('/').then(function() {
        click('a:contains("Flights")').then(function() {
            assert.equal(find('h3').text(), 'Flights');
        });
    });
});

test('Should list all flights', function(assert) {
    visit('/flights').then(function() {
        assert.equal(find('a:contains("AAA111")').length, 1);
        assert.equal(find('a:contains("BBB111")').length, 1);
        assert.equal(find('a:contains("CCC111")').length, 1);
        assert.equal(find('a:contains("DDD111")').length, 1);
    });
});

test('Navigate to a flight page', function(assert) {
    visit('/flights').then(function() {
        click('a:contains("AAA111")').then(function() {
            assert.equal(find('h4').text(), 'AAA111');
        });
    });
});

test('Visit Flight page', function(assert){
    visit('flights/AAA111').then(function() {
        assert.equal(find('h4').text(), 'AAA111');
    });
});
