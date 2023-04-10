<script language="JavaScript">

// ****************************************************
// This section begins the date/time validation section
// ****************************************************

var defaultEmptyOK = false

var daysInMonth = makeArray(12);
daysInMonth[1] = 31;
daysInMonth[2] = 29;   // must programmatically check this
daysInMonth[3] = 31;
daysInMonth[4] = 30;
daysInMonth[5] = 31;
daysInMonth[6] = 30;
daysInMonth[7] = 31;
daysInMonth[8] = 31;
daysInMonth[9] = 30;
daysInMonth[10] = 31;
daysInMonth[11] = 30;
daysInMonth[12] = 31;

//
// isDate (STRING date)
//
// isDate returns true if string argument date 
// is a valid date. The date argument must be passed
// in the format of mm/dd/yy
// 

function isDate(date)
{

	var firstIndex;
	var secondIndex;
	var month
	var day
	var year

	//Verify formatting and get parse points
	firstIndex = date.indexOf("/", 0)
	if (firstIndex == -1)
		return false
	else
		secondIndex = date.indexOf("/", firstIndex+1)
		if (secondIndex == -1)
			return false
	
	
	//Parse the values
	month = date.substring(0, firstIndex)
	day = date.substring(firstIndex+1, secondIndex)
	year = date.substring(secondIndex+1, date.length)


	//Validate the date elements
	if (isParsedDate(year, month, day))
		return true
	else
		return false

}



//
// isTime (STRING time)
//
// isTime returns true if string argument date 
// is a valid time. The date argument must be passed
// in the format of hh:mm
// 

function isTime(time)
{

	var firstIndex;
	var hour
	var minute

	//Verify formatting and get parse points
	firstIndex = time.indexOf(":", 0)
	if (firstIndex == -1)
		return false

	//Parse the values
	hour = time.substring(0, firstIndex)
	minute = time.substring(firstIndex+1, time.length)

	//Validate the date elements
	if (isParsedTime(hour, minute))
		return true
	else
		return false

}


//
// isParsedDate (STRING year, STRING month, STRING day)
//
// isParsedDate returns true if string arguments year, month, and day 
// form a valid date.
// 

function isParsedDate (year, month, day)
{   
	// catch invalid years (not 2- or 4-digit) and invalid months and days.
    if (! (isYear(year, false) && isMonth(month, false) && isDay(day, false))) return false;

    // Explicitly change type to integer to make code work in both
    // JavaScript 1.1 and JavaScript 1.2.
    var intYear = parseInt(year,10);
    var intMonth = parseInt(month,10);
    var intDay = parseInt(day,10);

    // catch invalid days, except for February
    if (intDay > daysInMonth[intMonth]) return false; 

    if ((intMonth == 2) && (intDay > daysInFebruary(intYear))) return false;

    return true;
}



//
// isParsedTime (STRING hour, STRING minute)
//
// isParsedTime returns true if string arguments hour and minute
// form a valid 24hr time value.
// 

function isParsedTime (hour, minute)
{   

	// catch invalid hour and minutes.
    if (! (isHour(hour, false) && isMinuteOrSecond(minute, false))) return false;

    return true;
}


// isHour (STRING s [, BOOLEAN emptyOK])
// 
// isHour returns true if string s is a valid 
// hour number between 0 and 23.
// 
// For explanation of optional argument emptyOK,
// see comments of function isInteger.

function isHour (s)
{   if (isEmpty(s)) 
       if (isDay.arguments.length == 1) return defaultEmptyOK;
       else return (isDay.arguments[1] == true);   
    return isIntegerInRange (s, 0, 23);
}


// isMinuteOrSecond (STRING s [, BOOLEAN emptyOK])
// 
// isMinuteOrSecond returns true if string s is a valid 
// minute or second number between 0 and 59.
// 
// For explanation of optional argument emptyOK,
// see comments of function isInteger.

function isMinuteOrSecond (s)
{   if (isEmpty(s)) 
       if (isDay.arguments.length == 1) return defaultEmptyOK;
       else return (isDay.arguments[1] == true);   
    return isIntegerInRange (s, 0, 59);
}


// isYear (STRING s [, BOOLEAN emptyOK])
// 
// isYear returns true if string s is a valid 
// Year number.  Must be 2 or 4 digits only.
// 
// For Year 2000 compliance, you are advised
// to use 4-digit year numbers everywhere.
//

function isYear (s)
{   if (isEmpty(s)) 
       if (isYear.arguments.length == 1) return defaultEmptyOK;
       else return (isYear.arguments[1] == true);
    if (!isNonnegativeInteger(s)) return false;
    return ((s.length == 2) || (s.length == 4));
}



// isMonth (STRING s [, BOOLEAN emptyOK])
// 
// isMonth returns true if string s is a valid 
// month number between 1 and 12.
//
// For explanation of optional argument emptyOK,
// see comments of function isInteger.

function isMonth (s)
{   if (isEmpty(s)) 
       if (isMonth.arguments.length == 1) return defaultEmptyOK;
       else return (isMonth.arguments[1] == true);
    return isIntegerInRange (s, 1, 12);
}



// isDay (STRING s [, BOOLEAN emptyOK])
// 
// isDay returns true if string s is a valid 
// day number between 1 and 31.
// 
// For explanation of optional argument emptyOK,
// see comments of function isInteger.

function isDay (s)
{   if (isEmpty(s)) 
       if (isDay.arguments.length == 1) return defaultEmptyOK;
       else return (isDay.arguments[1] == true);   
    return isIntegerInRange (s, 1, 31);
}



// daysInFebruary (INTEGER year)
// 
// Given integer argument year,
// returns number of days in February of that year.

function daysInFebruary (year)
{   // February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (  ((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0) ) ) ? 29 : 28 );
}





function isInteger (s)

{   var i;

    if (isEmpty(s)) 
       if (isInteger.arguments.length == 1) return defaultEmptyOK;
       else return (isInteger.arguments[1] == true);

    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);

        if (!isDigit(c)) return false;
    }

    // All characters are numbers.
    return true;
}



// isIntegerInRange (STRING s, INTEGER a, INTEGER b [, BOOLEAN emptyOK])
// 
// isIntegerInRange returns true if string s is an integer 
// within the range of integer arguments a and b, inclusive.
// 
// For explanation of optional argument emptyOK,
// see comments of function isInteger.


function isIntegerInRange (s, a, b)
{   if (isEmpty(s)) 
       if (isIntegerInRange.arguments.length == 1) return defaultEmptyOK;
       else return (isIntegerInRange.arguments[1] == true);

    // Catch non-integer strings to avoid creating a NaN below,
    // which isn't available on JavaScript 1.0 for Windows.
    if (!isInteger(s, false)) return false;

    // Now, explicitly change the type to integer via parseInt
    // so that the comparison code below will work both on 
    // JavaScript 1.2 (which typechecks in equality comparisons)
    // and JavaScript 1.1 and before (which doesn't).
    var num = parseInt (s,10);
    return ((num >= a) && (num <= b));
}



// isNonnegativeInteger (STRING s [, BOOLEAN emptyOK])
// 
// Returns true if string s is an integer >= 0.
//
// For explanation of optional argument emptyOK,
// see comments of function isInteger.

function isNonnegativeInteger (s)
{   var secondArg = defaultEmptyOK;

    if (isNonnegativeInteger.arguments.length > 1)
        secondArg = isNonnegativeInteger.arguments[1];

    // The next line is a bit byzantine.  What it means is:
    // a) s must be a signed integer, AND
    // b) one of the following must be true:
    //    i)  s is empty and we are supposed to return true for
    //        empty strings
    //    ii) this is a number >= 0

    return (isSignedInteger(s, secondArg)
         && ( (isEmpty(s) && secondArg)  || (parseInt (s,10) >= 0) ) );
}


// isSignedInteger (STRING s [, BOOLEAN emptyOK])
// 
// Returns true if all characters are numbers; 
// first character is allowed to be + or - as well.
//
// Does not accept floating point, exponential notation, etc.
//
// We don't use parseInt because that would accept a string
// with trailing non-numeric characters.
//
// For explanation of optional argument emptyOK,
// see comments of function isInteger.
//
// EXAMPLE FUNCTION CALL:          RESULT:
// isSignedInteger ("5")           true 
// isSignedInteger ("")            defaultEmptyOK
// isSignedInteger ("-5")          true
// isSignedInteger ("+5")          true
// isSignedInteger ("", false)     false
// isSignedInteger ("", true)      true

function isSignedInteger (s)

{   if (isEmpty(s)) 
       if (isSignedInteger.arguments.length == 1) return defaultEmptyOK;
       else return (isSignedInteger.arguments[1] == true);

    else {
        var startPos = 0;
        var secondArg = defaultEmptyOK;

        if (isSignedInteger.arguments.length > 1)
            secondArg = isSignedInteger.arguments[1];

        // skip leading + or -
        if ( (s.charAt(0) == "-") || (s.charAt(0) == "+") )
           startPos = 1;    
        return (isInteger(s.substring(startPos, s.length), secondArg))
    }
}



// Returns true if character c is a digit 
// (0 .. 9).

function isDigit (c)
{   return ((c >= "0") && (c <= "9"))
}



function makeArray(n) 
{
   for (var i = 1; i <= n; i++) {
      this[i] = 0
   } 
   return this
}



// Check whether string s is empty.

function isEmpty(s)
{   return ((s == null) || (s.length == 0))
}

</script>