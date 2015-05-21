import Ember from 'ember';

export default Ember.ArrayController.extend({

    fromDestination: '',
    fromCode: '', //airport destinationCode
    toDestination: '', 
    toCode: '', //airport destinationCode
    departDate: '',
    returnDate: '',
    selectedClass: '',
    numberOfPeople: '1',

    searchFields: "BUTTS",



    //these are the same destination search but for different inputs
    // I'm doing it this way to quickly move on to other stuff, and since
    // calling functions within controllers makes it hard to refactor, but
    // it's possible. 

    //TODO: cleanup this mess, remove repeated code
    toDestinationSearch: function(test){

        var filter = this.get('toDestination');

        if(filter === null)
        {
            return;
        }
        

        if(filter === undefined)
        {
            filter = '';
        }

        // reset toCode because our to destination is being changed
        this.set('toCode', ''); 

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
        if(filter === null)
        {
            return;
        }

        if(filter === undefined)
        {
            filter = '';
        }

        // reset fromCode because our to destination is being changed
        this.set('fromCode', ''); 

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
            //getting all the values we want to pass to the server
            // checking that they are valid

            var fromCode = this.get('fromCode');
            var toCode = this.get('toCode');
            
            var departDate = this.get('departDate');
            var returnDate = this.get('returnDate');
            var selectedClass = this.get('selectedClass');
            var numberOfPeople = this.get('numberOfPeople');


            var incorrectValues = [];

            var _this = this; //allows us access this from function scope
            function validateCode(code, field)
            {
                if(!code){
                    incorrectValues.push(field);
                    return false;
                }

                //check if code matches any of the destination codes in 
                // our list of destination codes
                // if it has a single match it's valid
                var result = _this.get('destinations').filter(function(item, index, enumerable){
                    return (item.get('destinationCode') || '').toLowerCase().match(code.toLowerCase());
                });

                if (result.length != 1){
                    incorrectValues.push(field);
                }
                else
                {
                    _this.send('correctValue', field);
                }
            }

            validateCode(fromCode, 'from');
            validateCode(toCode, 'to');
            

            function parseDate(date){
                var from = date.split("-");
                return new Date(from[2], from[1] - 1, from[0]);
            }

            function validDate(date, field){
                if(date && date.length == 10 && parseDate(date))
                {
                    _this.send('correctValue', field);
                }
                else
                {
                    incorrectValues.push(field);
                }
            }

            //departDate isn't before returnDate 
            if(parseDate(departDate) >= parseDate(returnDate))
            {
                incorrectValues.push('departure-datepicker');
                incorrectValues.push('return-datepicker');
            }

            validDate(departDate, 'departure-datepicker');
            validDate(returnDate, 'return-datepicker');


            if(incorrectValues.length == 0)
            {

                // First we are going to set a property
                this.setProperties({searchFields: "HERPADERPAHERP"});
                //success!
                //we pass this valid shit to the server
                // and redirect to the results page
                //TODO: figure out how to pass these values to the server
                //      after we switch to the results page
                this.transitionToRoute('results');

                //THIS RESET COULD CAUSE TROUBLES DEPENDING ON HOW WE SEND
                // THE DATA
                // We are going to send the reset after we have obtained the data from the controller in our route
                //this.send('reset');
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

        correctValue: function(value){
            //use this to reset fields which were once deemed invalid
            $("#"+value).css({'border-color':'#FFFFFF'});
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

        suggestionSelected: function(destinationCode, suggestionBox){
            //suggestionBox is either 'to' or 'from' 

            this.set('hoveringResults', false);
            this.send('hideSuggestions');

            this.set(suggestionBox+"Code", destinationCode);
            this.set(suggestionBox+"Destination", $("#"+suggestionBox).val());

            $('#'+suggestionBox).val($('#'+destinationCode).text());
        },

        //TODO: call this when the page has been routed away to search results
        reset: function(){
            this.setProperties({
                fromDestination: null,
                fromCode: '',
                toDestination: null, 
                toCode: '',
                departDate: '',
                returnDate: '',
                selectedClass: '',
                numberOfPeople: '1',
                hoveringResults: false,
            });
        }
    }

});

