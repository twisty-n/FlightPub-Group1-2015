import Ember from 'ember';

export default Ember.ArrayController.extend({

    fromDestination: '',
    toDestination: '',
    departDate: '',
    returnDate: '',
    selectedClass: '',
    numberOfPeople: '1',



    //these are the same destination search but for different inputs
    // I'm doing it this way to quickly move on to other stuff, and since
    // calling functions within controllers makes it hard to refactor, but
    // it's possible. 

    toDestinationSearch: function(){
        var filter = this.get('toDestination');

        if(filter === undefined)
        {
            filter = '';
        }

        var result = this.get('destinations').filter(function(item, index, enumerable){
            var stringToMatch = '';
            stringToMatch += (item.get('destinationCode') || ''); 
            stringToMatch += (item.get('countryName') || '');
            stringToMatch += (item.get('alternateName1') || '');
            stringToMatch += (item.get('countryCode3') || '');
            stringToMatch += (item.get('countryCode2') || '');
            stringToMatch += (item.get('airport') || '');

            return stringToMatch.toLowerCase().match(filter.toLowerCase());
        });

        if(result.length === 0)
        {
            this.send('hideSuggestions', 'to');
        }
        else
        {
            this.send('showSuggestions', 'to');
        }

        return result;

    }.property('toDestination'),

    fromDestinationSearch: function(){
        var filter = this.get('fromDestination');
        if(filter === undefined)
        {
            filter = '';
        }

        var result = this.get('destinations').filter(function(item, index, enumerable){
            var stringToMatch = '';
            stringToMatch += (item.get('destinationCode') || '');
            stringToMatch += (item.get('countryName') || '');
            stringToMatch += (item.get('alternateName1') || '');
            stringToMatch += (item.get('countryCode3') || '');
            stringToMatch += (item.get('countryCode2') || '');
            stringToMatch += (item.get('airport') || '');

            return stringToMatch.toLowerCase().match(filter.toLowerCase());
        });

        if(result.length === 0)
        {
            this.send('hideSuggestions', 'from');
        }
        else
        {
            this.send('showSuggestions', 'from');
        }

        return result;

    }.property('fromDestination'),


    actions: {
        flightSearch: function(){
            
            console.log(this.get('fromDestination'));
            console.log(this.get('toDestination'));
            console.log(this.get('departDate'));
            console.log(this.get('returnDate'));
            console.log(this.get('selectedClass'));
            console.log(this.get('numberOfPeople'));

            console.log("we will get all the stuff and send it away for processing");

            //getting all the values we want to pass to the server

            var fromDestination = this.get('fromDestination');
            var toDestination = this.get('toDestination');
            var departDate = this.get('departDate');
            var returnDate = this.get('returnDate');
            var selectedClass = this.get('selectedClass');
            var numberOfPeople = this.get('numberOfPeople');


            var incorrectValues = [];
            //gotta check which ones are valid, if they aren't we tell the user

            //fromDestination, we check to see if the thing we've been passed matches any of the 
            // values is 'destinations'

            if(fromDestination)
            {
                
            }
            else
            {
                incorrectValues.push('from');
            }

            if(toDestination)
            {

            }
            else
            {
                incorrectValues.push('to');
            }

            if(departDate)
            {
            }
            else
            {
                incorrectValues.push('departure-datepicker');
            }

            if(returnDate)
            {
            }
            else
            {
                incorrectValues.push('return-datepicker');
            }


            if(incorrectValues.length == 0)
            {
                //success!
                //we pass this valid shit to the server
                // and redirect to the results page
                this.transitionToRoute('results');
            }
            else
            {
                for(var i = 0; i < incorrectValues.length; i++)
                {
                    this.send('incorrectValue', incorrectValues[i]);
                }
            }

        },

        incorrectValue: function(value){
            $("#"+value).css({'border-color':'#FF0000'});
        },

        setFrom: function(value){
            console.log("gotta set from value to "+value);
        },

        hideSuggestions: function(){
            if(this.get('hoveringResults') == true){ 
                //don't wanna hide the suggestions
                // if the user is hovering over them to select one
                return; 
            }

            $("#to-box .drop-down").hide();
            $("#to-box .arrow").hide();
            $("#from-box .drop-down").hide();
            $("#from-box .arrow").hide();
        },

        showSuggestions: function(suggestionBox){
            $("#"+suggestionBox+"-box .drop-down").show();
            $("#"+suggestionBox+"-box .arrow").show();
        },

        hoveringSuggestions: function(){
            this.set('hoveringResults', true);
        },

        stoppedHoveringSuggestions: function(){
            this.set('hoveringResults', false);
        },

        destinationSelected: function(destionationBox){
            // setting to false because otherwise the hide would be blocked
            this.set('hoveringResults', false);
            this.send('hideSuggestions');

            //this works because destinationBox is either 'from' or 'to'
            //which corresponds to the id's on the page and to the variables we store

            var val = $('#'+destionationBox).val();
            var destVariable = destionationBox + 'Destination';

            this.set(destVariable, val);
        },
    }

});

