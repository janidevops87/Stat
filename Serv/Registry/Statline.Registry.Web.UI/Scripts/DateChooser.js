
//*********************************************************************************//
//
//  Author: Richard diZerega
//			Senior Consultant, Hitachi Consulting
//
//	Description: Javascript for DateChooser Calendar Control
//
//	Copywrite 2004 - Hitachi Consulting
//
//*********************************************************************************//

//Toggles the Calendar when the calendar icon of the datechooser is clicked
function ToggleCalendar(dateChooserID, textboxID)
{
	//get the datechooser textbox and calendar div using their ids
	var txtDateChooser = document.getElementById(textboxID);
	var divDateChooser = document.getElementById(dateChooserID);
	var iFrameDateChooser = document.getElementById('iFrame_' + dateChooserID);
	
	//determine if we need to hide or show the calendar
	if (divDateChooser.style.display == 'none')
	{
		//set the calendar position
		var pagePos = GetPageCoordinates(txtDateChooser);
		var relPos = GetRelativeCoordinates(txtDateChooser, pagePos.x, pagePos.y);
				
		divDateChooser.style.top = relPos.y + txtDateChooser.offsetHeight;
		iFrameDateChooser.style.top = relPos.y + txtDateChooser.offsetHeight;

		var left = relPos.x;
		if ((pagePos.x + 230) > document.body.clientWidth)
			left -= 150;
		divDateChooser.style.left = left;
		iFrameDateChooser.style.left = left;	
		
		
		//get the date to work with
		var dateIn;
		if (isDate(txtDateChooser.value))
			dateIn = new Date(txtDateChooser.value);
		else
			dateIn = new Date();
		
		//get the start date for the calendar
		var startDate = GetStartDate(dateIn);
	
		//build the calendar
		BuildCalendar(dateChooserID, textboxID, startDate);
		
		//set month and year dropdowns
		document.getElementById('cboMonth_' + dateChooserID).value = dateIn.getMonth();
		document.getElementById('cboYear_' + dateChooserID).value = dateIn.getFullYear();
	}
	else
	{
		//hide and clear the calendar div
		divDateChooser.style.display = 'none';
		iFrameDateChooser.style.display = 'none';
		divDateChooser.innerHTML = '';
		txtDateChooser.focus();
	}
}

//recursively gets the relative location for the element
function GetRelativeCoordinates(element, x, y)
{
	var flag = false;
	do
	{
		if (element.tagName == 'DIV' || flag)
		{
			flag = true;
			x -= element.offsetLeft;
			y -= element.offsetTop;
		}
	}
	while ((element = element.offsetParent));
	
	return {x: x, y: y};
}

//recursively gets the page position for the control
function GetPageCoordinates(element)
{
	var x = y = 0;
	do
	{
		x += element.offsetLeft;
		y += element.offsetTop;
	}
	while ((element = element.offsetParent));
	
	return {x: x, y: y};
}


//dynamically builds the calendar html
function BuildCalendar(dateChooserID, textboxID, startDate)
{
	//get the datechooser textbox and calendar div using their ids
	var txtDateChooser = document.getElementById(textboxID);
	var divDateChooser = document.getElementById(dateChooserID);
	var iFrameDateChooser = document.getElementById('iFrame_' + dateChooserID);
	var today = new Date();
	
	//clear clear the calendar div
	divDateChooser.innerHTML = '';
	
	//start building the innerHTML of the calendar div
	divDateChooser.style.display = 'block';
	iFrameDateChooser.style.display = 'block';
	var html = '<table id=\'myCale\' style=\'BORDER-RIGHT:black 1px solid; BORDER-TOP:black 1px solid; FONT-SIZE:9pt; BORDER-LEFT:black 1px solid; WIDTH:230px; COLOR:black; BORDER-BOTTOM:black 1px solid; FONT-FAMILY:Verdana; POSITION:relative; HEIGHT:150px; BACKGROUND-COLOR:white\' ms_positioning=\'GridLayout\' cellSpacing=\'1\' cellPadding=\'2\' bordercolor=\'black\' border=\'0\'>';
	html += '<colgroup><col align=\'center\' style=\'WIDTH:14.3%;\'><col align=\'center\' style=\'WIDTH:14.3%;\'><col align=\'center\' style=\'WIDTH:14.3%;\'><col align=\'center\' style=\'WIDTH:14.3%;\'><col align=\'center\' style=\'WIDTH:14.3%;\'><col align=\'center\' style=\'WIDTH:14.3%;\'><col align=\'center\' style=\'WIDTH:14.3%;\'></colgroup>';
	html += '<tr><td class=\'StatlineCalendarHeader\' colSpan=\'7\'><table style=\'FONT-WEIGHT:bold;FONT-SIZE:12pt;WIDTH:100%;COLOR:white;FONT-FAMILY:Verdana;BORDER-COLLAPSE:collapse\' cellSpacing=\'0\' border=\'0\'>';
	html += '<tr><td style=\'FONT-WEIGHT: bold; FONT-SIZE: 6pt; WIDTH: 15%; CURSOR: hand; COLOR: white\' onclick=\'javascript:BackMonth("' + dateChooserID + '", "' + textboxID + '");\'>&lt;</td>';
	html += '<td style=\'WIDTH: 70%; COLOR: white\' align=\'center\'>';
	html += '<select id=\'cboMonth_' + dateChooserID + '\' style=\'font-size:8pt;font-family:Sans-Serif\' onchange=\'javascript:cboDateChange("' + dateChooserID + '", "' + textboxID + '");\'><option value="0">January</option><option value="1">February</option><option value="2">March</option><option value="3">April</option><option value="4">May</option><option value="5">June</option><option value="6">July</option><option value="7">August</option><option value="8">September</option><option value="9">October</option><option value="10">November</option><option value="11">December</option></select>';
	html += '<select id=\'cboYear_' + dateChooserID + '\' style=\'font-size:8pt;font-family:Sans-Serif\' onchange=\'javascript:cboDateChange("' + dateChooserID + '", "' + textboxID + '");\'>';
	for (i = 1900; i < 2050; i++)
	{
		html += '<option value="' + i + '">' + i + '</option>';
	}
	html += '</select></td>';
	html += '<td style=\'FONT-WEIGHT: bold; FONT-SIZE: 6pt; WIDTH: 15%; CURSOR: hand; COLOR: white\' align=\'right\' onclick=\'javascript:ForwardMonth("' + dateChooserID + '", "' + textboxID + '");\'>&gt;</td>';
	html += '</tr></table></td></tr>';
	html += '<tr><td style=\'FONT-WEIGHT:bold;FONT-SIZE:8pt;COLOR:#333333;HEIGHT:6pt\'>Sun</td><td style=\'FONT-WEIGHT:bold;FONT-SIZE:8pt;COLOR:#333333;HEIGHT:6pt\'>Mon</td><td style=\'FONT-WEIGHT:bold;FONT-SIZE:8pt;COLOR:#333333;HEIGHT:6pt\'>Tue</td><td style=\'FONT-WEIGHT:bold;FONT-SIZE:8pt;COLOR:#333333;HEIGHT:6pt\'>Wed</td><td style=\'FONT-WEIGHT:bold;FONT-SIZE:8pt;COLOR:#333333;HEIGHT:6pt\'>Thu</td><td style=\'FONT-WEIGHT:bold;FONT-SIZE:8pt;COLOR:#333333;HEIGHT:6pt\'>Fri</td><td style=\'FONT-WEIGHT:bold;FONT-SIZE:8pt;COLOR:#333333;HEIGHT:6pt\'>Sat</td></tr>';
	
	//add the 6 rows and 7 columns or the month
	for (y = 0; y < 6; y++)
	{
		html += '<tr>';
		for (x = 0; x < 7; x++)
		{
			if(today.getDate() == startDate.getDate())
			{
				if(today.getMonth() == startDate.getMonth())
				{
					if(today.getFullYear() == startDate.getFullYear())
					{
						html += '<td id=\'cell_' + x + '_' + y + '\' onclick=\'javascript:DateSelect("' + dateChooserID + '", "' + textboxID + '", "' + FormatDateString(startDate) + '");\' class=\'StatlineCalendarCurrentDate\'>' + startDate.getDate() + '</td>';
					}
					else
					{
						html += '<td id=\'cell_' + x + '_' + y + '\' onclick=\'javascript:DateSelect("' + dateChooserID + '", "' + textboxID + '", "' + FormatDateString(startDate) + '");\' style=\'CURSOR: hand\' bgcolor=\'#EEEEEE\'>' + startDate.getDate() + '</td>';
					}
				}
				else
				{
					html += '<td id=\'cell_' + x + '_' + y + '\' onclick=\'javascript:DateSelect("' + dateChooserID + '", "' + textboxID + '", "' + FormatDateString(startDate) + '");\' style=\'CURSOR: hand\' bgcolor=\'#EEEEEE\'>' + startDate.getDate() + '</td>';
				}	
			}
			else
			{
				html += '<td id=\'cell_' + x + '_' + y + '\' onclick=\'javascript:DateSelect("' + dateChooserID + '", "' + textboxID + '", "' + FormatDateString(startDate) + '");\' style=\'CURSOR: hand\' bgcolor=\'#EEEEEE\'>' + startDate.getDate() + '</td>';
			}
			startDate = IncrementDate(startDate);
		}
		html += '</tr>';
	}
	
	html += '<tr><td class=\'StatlineCalendarHeader\' colspan=\'7\' align=\'center\' onclick=\'javascript:ToggleCalendar("' + dateChooserID + '", "' + textboxID + '")\' style=\'FONT-WEIGHT: bold; FONT-SIZE: 8pt; WIDTH: 15%; CURSOR: hand; COLOR: white\'>Cancel</td></tr></table>';
	divDateChooser.innerHTML = html;
}

//function called when a date is selected from the calendar
function DateSelect(dateChooserID, textboxID, dateIn)
{
	//get the datechooser textbox and calendar div using their ids
	var txtDateChooser = document.getElementById(textboxID);
	var divDateChooser = document.getElementById(dateChooserID);
	var iFrameDateChooser = document.getElementById('iFrame_' + dateChooserID);
	
	//set the value of the datechooser textbox
	txtDateChooser.value = dateIn;
	
	//hide and clear the calendar div
	divDateChooser.style.display = 'none';
	iFrameDateChooser.style.display = 'none';
	divDateChooser.innerHTML = '';
	txtDateChooser.focus();
}

//formats the date that will go in the datachooser textbox
function FormatDateString(DateIn)
{
	var day = '' + DateIn.getDate();
	var month = '' + (DateIn.getMonth()+1);
	var year = '' + DateIn.getFullYear();
	
	if (day.length == 1)
		day = '0' + day;
	if (month.length == 1)
		month = '0' + month;
		
	return month + '/' + day + '/' + year;
}

//gets the date of the first cell in the 42-cell calendar based on the date parameter
function GetStartDate(dateIn)
{
	//find first day of month (returns 0...6)
	var intFirstDay = getFirstDay(dateIn);
	
	var startDate;
	if (dateIn.getMonth() == 0)
		startDate = new Date(dateIn.getYear()-1, 11, 1);
	else
		startDate = new Date(dateIn.getYear(), dateIn.getMonth()-1, 1);
	var intPervDaysInMonth = getMonthLen(startDate);

	//get start day
	if (intFirstDay == 0)
		startDate.setDate(intPervDaysInMonth-6);
	else	
		startDate.setDate(intPervDaysInMonth-(intFirstDay-1));
		
	return startDate;
}

//increments the date by one
function IncrementDate(DateIn)
{
	if (DateIn.getDate() == getMonthLen(DateIn))
	{
		DateIn.setDate(1);
		if (DateIn.getMonth() == 11)
		{
			DateIn.setYear(DateIn.getYear()+1);
			DateIn.setMonth(0);
		}
		else
		{
			DateIn.setMonth(DateIn.getMonth()+1);
		}
	}
	else
	{
		DateIn.setDate(DateIn.getDate()+1);
	}
	
	return DateIn;
}

//determines number of days in the month of the date parameter
function getMonthLen(dateIn)
{
	var oneHour = 1000 * 60 * 60;
	var oneDay = oneHour * 24;
	var thisMonth = new Date(dateIn.getYear(), dateIn.getMonth(), 1);
	var nextMonth = new Date(dateIn.getYear(), dateIn.getMonth() + 1, 1);
	var len = Math.ceil((nextMonth.getTime() - thisMonth.getTime() - oneHour)/oneDay);
	return len;
}

//gets the date of the first day
function getFirstDay(dateIn)
{
	var firstDay = new Date(dateIn.getYear(), dateIn.getMonth(), 1);
	return firstDay.getDay();
}

//determines if a string is a valid date
function isDate(dateStr)
{
	var datePat = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
	var matchArray = dateStr.match(datePat);

	if (matchArray == null)
		return false;

	// parse date into variables
	month = matchArray[1];
	day = matchArray[3];
	year = matchArray[5];

	if (month < 1 || month > 12) //check month range
		return false;

	if (day < 1 || day > 31) //check day range
		return false;

	if ((month==4 || month==6 || month==9 || month==11) && day==31) //check day range aginst month
		return false;

	if (month == 2) // check for february 29th
	{ 
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day > 29 || (day==29 && !isleap)) 
			return false;
	}
	return true; // date is valid
}

//fired when the month or year dropdown on the calendar is changes
function cboDateChange(dateChooserID, textboxID)
{
	//get the new date
	newDate = new Date(document.getElementById('cboYear_' + dateChooserID).value, document.getElementById('cboMonth_' + dateChooserID).value, 1);
	
	//get the start date for the calendar
	var startDate = GetStartDate(newDate);

	//build the calendar
	BuildCalendar(dateChooserID, textboxID, startDate);
	
	//set month and year dropdowns
	document.getElementById('cboMonth_' + dateChooserID).value = newDate.getMonth();
	document.getElementById('cboYear_' + dateChooserID).value = newDate.getFullYear();
}

//moves the active date in the calendar back one month
function BackMonth(dateChooserID, textboxID)
{
	var year = document.getElementById('cboYear_' + dateChooserID).value;
	var month = document.getElementById('cboMonth_' + dateChooserID).value;
	
	var newDate;
	if (month == 0)
	{
		year--;
		newDate = new Date(year, 11, 1);
	}
	else
	{
		month--;
		newDate = new Date(year, month, 1);
	}
	
	//get the start date for the calendar
	var startDate = GetStartDate(newDate);

	//build the calendar
	BuildCalendar(dateChooserID, textboxID, startDate);
	
	//set month and year dropdowns
	document.getElementById('cboMonth_' + dateChooserID).value = newDate.getMonth();
	document.getElementById('cboYear_' + dateChooserID).value = newDate.getFullYear();
}

//moves the active date in the calendar forward one month
function ForwardMonth(dateChooserID, textboxID)
{
	var year = document.getElementById('cboYear_' + dateChooserID).value;
	var month = document.getElementById('cboMonth_' + dateChooserID).value;
	
	var newDate;
	if (month == 11)
	{
		year++;
		newDate = new Date(year, 0, 1);
	}
	else
	{
		month++;
		newDate = new Date(year, month, 1);
	}
	
	//get the start date for the calendar
	var startDate = GetStartDate(newDate);

	//build the calendar
	BuildCalendar(dateChooserID, textboxID, startDate);
	
	//set month and year dropdowns
	document.getElementById('cboMonth_' + dateChooserID).value = newDate.getMonth();
	document.getElementById('cboYear_' + dateChooserID).value = newDate.getFullYear();
}
