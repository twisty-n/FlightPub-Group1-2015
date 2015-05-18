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

            console.log(this.get('fromDestination'));
            console.log(this.get('toDestination'));
            console.log(this.get('departDate'));
            console.log(this.get('returnDate'));
            console.log(this.get('selectedClass'));
            console.log(this.get('numberOfPeople'));

            console.log("we will get all the stuff and send it away for processing");

            //getting all the values we want to pass to the server

            var fromCode = this.get('fromCode');
            var toCode = this.get('toCode');
            
            var departDate = this.get('departDate');
            var returnDate = this.get('returnDate');
            var selectedClass = this.get('selectedClass');
            var numberOfPeople = this.get('numberOfPeople');


            var incorrectValues = [];
            //gotta check which ones are valid, if they aren't we tell the user

            //TODO: clean up this repeated code
            if(fromCode)
            {
                //check if fromCode matches any of the destination codes in 
                // our list of destination codes
                // if it has a single match it's valid
                var result = this.get('destinations').filter(function(item, index, enumerable){
                    var stringToMatch = (item.get('destinationCode') || '');

                    return stringToMatch.toLowerCase().match(fromCode.toLowerCase());
                });

                if(result.length != 1)
                {
                    incorrectValues.push('from');
                }
                else
                {
                    this.send('correctValue', 'from');
                }
            }
            else
            {
                incorrectValues.push('from');
            }

            if(toCode)
            {
                 //check if toCode matches any of the destination codes in 
                // our list of destination codes
                // if it has a single match it's valid
                var result = this.get('destinations').filter(function(item, index, enumerable){
                    var stringToMatch = (item.get('destinationCode') || '');
                    
                    return stringToMatch.toLowerCase().match(toCode.toLowerCase());
                });

                if(result.length != 1)
                {
                    incorrectValues.push('to');
                }
                else
                {
                    this.send('correctValue', 'to');
                }
            }
            else
            {
                incorrectValues.push('to');
            }


            function parseDate(date){
                var from = date.split("-");
                return new Date(from[2], from[1] - 1, from[0]);
            }

            function validDate(date){
                return date && date.length == 10 && parseDate(date);
            }

            //departDate isn't before returnDate 
            if(parseDate(departDate) >= parseDate(returnDate))
            {
                incorrectValues.push('departure-datepicker');
                incorrectValues.push('return-datepicker');
            }

            if(validDate(departDate))
            {
                this.send('correctValue', 'departure-datepicker');
            }
            else
            {
                incorrectValues.push('departure-datepicker');
            }

            if(validDate(returnDate))
            {
                this.send('correctValue', 'return-datepicker');
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

        correctValue: function(value){
            //use this to reset fields which were once deemed invalid
            $("#"+value).css({'border-color':'#FFFFFF'});
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

        suggestionSelected: function(destinationCode, suggestionBox){
            //suggestionBox is either 'to' or 'from' 

            this.set('hoveringResults', false);
            this.send('hideSuggestions');

            this.set(suggestionBox+"Code", destinationCode);
            this.set(suggestionBox+"Destination", $("#"+suggestionBox).val());

            $('#'+suggestionBox).val($('#'+destinationCode).text());
        },
    }

});

