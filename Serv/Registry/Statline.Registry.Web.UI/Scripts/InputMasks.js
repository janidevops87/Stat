function DateMask(controlName)
{
	var txtBox = document.getElementById(controlName);
	
	//ignorE tab
	if (event.keyCode == 9)
		return;
		
	//clear any selection
	if (document.selection.type == 'Text')
		document.selection.clear();
		
	var text = txtBox.value;
	var charKeyCode = event.keyCode;
	
	//handle keypad presses
	if (charKeyCode >= 96 && charKeyCode <= 105 || charKeyCode == 111)
	{
		charKeyCode = KeyPadTranslate(charKeyCode);
	}
	
	if (charKeyCode == 8)
	{
		if (text.length > 0)
			txtBox.value = text.substr(0, text.length);
	}
	else if (charKeyCode >= 48 && charKeyCode <= 57 || charKeyCode == 191)
	{
		text += String.fromCharCode(charKeyCode);
		switch (text.length)
		{
			case 1:
				if (charKeyCode == 191)
					txtBox.value = text.substr(0, text.length-1);
				else if (text > 1)
					txtBox.value = '0' + text + '/';
				else
					txtBox.value = text;
				break;			
			case 2:
				if (String.fromCharCode(charKeyCode) == '0')
				{
					if (text.substr(0,1) == '0')
						return false;
				}
				if (charKeyCode == 191)
					txtBox.value = '0' + text.substr(0, text.length-1) + '/';
				else if (text > 12)
				{
					month = text.substr(0, text.length-1);
					if ((month == 2 && String.fromCharCode(charKeyCode) > 2) ||
						(String.fromCharCode(charKeyCode) > 3))
						txtBox.value = '0' + text.substr(0, text.length-1) + '/' + '0' + String.fromCharCode(charKeyCode) + '/';
					else
						txtBox.value = '0' + text.substr(0, text.length-1) + '/' + String.fromCharCode(charKeyCode);
				}
				else
					txtBox.value = text + '/';
				break;
			case 3:
				if (charKeyCode == 191)
					txtBox.value = text.substr(0, text.length-1) + '/';
				else 
					txtBox.value = text.substr(0, text.length-1) + '/' + String.fromCharCode(charKeyCode);
				break;
			case 4:
				if (charKeyCode == 191)
					txtBox.value = text.substr(0, text.length-1);
				else 
				{
					var splitDate = new Array();
					splitDate = text.split('/');
					month = splitDate[0];
					if ((month == 02 && String.fromCharCode(charKeyCode) > 2) ||
						(String.fromCharCode(charKeyCode) > 3))
						txtBox.value = text.substr(0, text.length-1) + '0' + String.fromCharCode(charKeyCode) + '/';
					else
						txtBox.value = text;
				}
				break;
			case 5:
				if (String.fromCharCode(charKeyCode) == '0')
				{
					if (text.substr(3,1) == '0')
						return false;
				}
				if (charKeyCode == 191)
					txtBox.value = text.substr(0, text.length-2) + '0' + text.substr(3, 1) + '/';
				else
				{
					var splitDate = new Array();
					splitDate = text.split('/');
					month = splitDate[0];
					if ((month == 01 && splitDate[1] > 31) ||
						(month == 02 && splitDate[1] > 29) ||
						(month == 03 && splitDate[1] > 31) ||
						(month == 04 && splitDate[1] > 30) ||
						(month == 05 && splitDate[1] > 31) ||
						(month == 06 && splitDate[1] > 30) ||
						(month == 07 && splitDate[1] > 31) ||
						(month == 08 && splitDate[1] > 31) ||
						(month == 09 && splitDate[1] > 30) ||
						(month == 10 && splitDate[1] > 31) ||
						(month == 11 && splitDate[1] > 30) ||
						(month == 12 && splitDate[1] > 31))
						txtBox.value = text.substr(0, text.length-2) + '0' + text.substr(3, 1) + '/';// - MR 4.22.05
					else
					{
						txtBox.value = text + '/';
					}
				}
				break;
			case 6:
				if (charKeyCode == 191)
					txtBox.value = text.substr(0, text.length-1) + '/';
				else 
					txtBox.value = text.substr(0, text.length-1) + '/' + String.fromCharCode(charKeyCode);
				break;
			case 7:
				if (charKeyCode == 191)
					return false;
				else if (String.fromCharCode(charKeyCode) == '0')
					return false;
				else if (String.fromCharCode(charKeyCode) == '2')
				{
					var splitDate = new Array();
					splitDate = text.split('/');
					month = splitDate[0];
					day = splitDate[1];
					year = new Date().getYear();
					if (month == 02 && day == 29)
					{
						if (IsLeapYear(year))
							txtBox.value = text.substr(0, text.length-1) + new Date().getYear();
						else
							txtBox.value = text;
					}
					else
						txtBox.value = text.substr(0, text.length-1) + new Date().getYear();
				}
				//prevent users from entering anything more than 2XXX for the first position of the year - MR 4.22.05
				else if (parseInt(String.fromCharCode(charKeyCode)) > 2)
					return false;
				else
					txtBox.value = text;
				break;
			case 8:
				if (charKeyCode == 191)
					return false;
				else if (text.substr(6,1) == '1')
				{
					//check for 7 in the second year position to prevent 
					//users from entering years < 1753
					if (parseInt(String.fromCharCode(charKeyCode)) < 7)
					{
						if (text.substr(6,1) == '1')
							return false;
					}
				}
				//check for 0 in the second year position to prevent 
				//users from entering years > 2078 (limit for small dates in sql server 2k) - MR 4.22.05
				else if (parseInt(String.fromCharCode(charKeyCode)) > 0)
				{
					if (text.substr(6,1) == '2')
						return false;
				}
				txtBox.value = text;
				break;
			case 9:
				//check for 5 in the third year position to prevent 
				//users from entering years < 1753
				if (charKeyCode == 191)
					return false;
				else if (parseInt(String.fromCharCode(charKeyCode)) < 5)
				{
					if (text.substr(6,2) == '17')
						return false;
				}
				//check for 7 in the third year position to prevent 
				//users from entering years > 2078 (limit for small dates in sql server 2k) - MR 4.22.05
				else if (parseInt(String.fromCharCode(charKeyCode)) > 7)
				{
					if (text.substr(6,2) == '20')
						return false;
				}
				txtBox.value = text;
				break;
			case 10:
				//check for 3 in the fourth year position to prevent 
				//users from entering years < 1753
				if (charKeyCode == 191)
					return false;
				else if (parseInt(String.fromCharCode(charKeyCode)) < 3)
				{
					if (text.substr(6,3) == '175')
						return false;
					txtBox.value = text;
				}
				//check for 8 in the fourth year position to prevent 
				//users from entering years > 2078 (limit for small dates in sql server 2k) - MR 4.22.05
				else if (parseInt(String.fromCharCode(charKeyCode)) > 8)
				{
					if (text.substr(6,3) == '207')
						return false;
					txtBox.value = text;
				}
				else
				{
					var splitDate = new Array();
					splitDate = text.split('/');
					month = splitDate[0];
					day = splitDate[1];
					year = splitDate[2];
					if (month == 02 && day == 29)
					{
						if (IsLeapYear(year))
							txtBox.value = text;
						else
							txtBox.value = text.substr(0, text.length-1);
							
					}
					else
						txtBox.value = text;
				}
				break;
			default:
				if (charKeyCode == 191)
					return false;
				else
					txtBox.value = text.substr(0, text.length-1);
				break;
		}
	}
	else
	{
		txtBox.value = text;
	}
}

function DateCheck(controlName)
{
	var txtBox = document.getElementById(controlName);
	if (txtBox.value.length != 10)
		txtBox.value = '';
	
}

function IsLeapYear(year)
{
	return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
}

function NumericPatternMask(controlName, maskPattern)
{
	if (document.selection.type == 'Text')
		document.selection.clear();
	var txtBox = document.getElementById(controlName);
	txtBox.value += String.fromCharCode(event.keyCode);
}

function SsnMask(controlName)
{
	var txtBox = document.getElementById(controlName);
	
	//ignor tab
	if (event.keyCode == 9)
		return;
		
	//clear any selection
	if (document.selection.type == 'Text')
		document.selection.clear();
		
	var text = txtBox.value;
	var charKeyCode = event.keyCode;
	
	//handle keypad presses
	if (charKeyCode >= 96 && charKeyCode <= 105)
	{
		charKeyCode = KeyPadTranslate(charKeyCode);
	}
	
	if (charKeyCode == 8)
	{
		if (text.length > 0)
			txtBox.value = text.substr(0, text.length);
	}
	else if (charKeyCode >= 48 && charKeyCode <= 57)
	{
		text += String.fromCharCode(charKeyCode);
		switch (text.length)
		{
			case 1:
			case 2:
			case 5:
			case 8:
			case 9:
			case 10:
			case 11:
				txtBox.value = text;
				break;
			case 3:
				txtBox.value = text + '-';
				break;
			case 4:
				txtBox.value = text.substr(0, text.length-1) + '-' + String.fromCharCode(charKeyCode);
				break;
			case 6:
				txtBox.value = text + '-';
				break;
			case 7:
				txtBox.value = text.substr(0, text.length-1) + '-' + String.fromCharCode(charKeyCode);
				break;
			default:
				txtBox.value = text.substr(0, text.length-1);
				break;
		}
	}
	else
	{
		txtBox.value = text;
	}
}
//Military Time Mask script - by Richard diZerega
function MilitaryTimeMask(controlName)
{
	var txtBox = document.getElementById(controlName);

	//ignor tab
	if (event.keyCode == 9)
		return;
		
	//clear any selection
	if (document.selection.type == 'Text')
		document.selection.clear();
		
	var text = txtBox.value;
	var charKeyCode = event.keyCode;
	
	//handle keypad presses
	if (charKeyCode >= 96 && charKeyCode <= 105 || charKeyCode == 111)
	{
		charKeyCode = KeyPadTranslate(charKeyCode);
	}
	
	if (charKeyCode == 8)
	{
		if (text.length > 0)
			txtBox.value = text.substr(0, text.length);
	}
	else if (charKeyCode >= 48 && charKeyCode <= 57 || charKeyCode == 186)
	{
		text += String.fromCharCode(charKeyCode);
		switch (text.length)
		{
			case 1:
				if (charKeyCode == 186)
					txtBox.value = text.substr(0, text.length-1);
				else if (text > 2)
					txtBox.value = '0' + text + ':';
				else
					txtBox.value = text;
				break;
			case 2:
				if (charKeyCode == 186)
				{
					if (event.shiftKey)
						txtBox.value = '0' + text.substr(0, text.length-1) + ':';
				}
				else if (text > 23)
					txtBox.value = text.substr(0, text.length-1);
				else
					txtBox.value = text + ':';
				break;
			case 3:
				if (charKeyCode == 186)
				{
					if (event.shiftKey)
						txtBox.value = text.substr(0, text.length-1) + ':';
				}
				else if (String.fromCharCode(charKeyCode) > 5)
					txtBox.value = text.substr(0, text.length-1) + ':0' + String.fromCharCode(charKeyCode);
				else
					txtBox.value = text.substr(0, text.length-1) + ':' + String.fromCharCode(charKeyCode);
				break;
			case 4:
				if (charKeyCode == 186)
					txtBox.value = text.substr(0, text.length-1);
				else
				{
					var splitTime = new Array();
					splitTime = text.split(':');
					if (splitTime.length == 2)
					{
						var mins = splitTime[1];
						if (mins > 5)
							txtBox.value = text.substr(0, text.length-1) + '0' + String.fromCharCode(charKeyCode);
						else
							txtBox.value = text;
					}
				}
				break;
			case 5:
				if (charKeyCode == 186)
					txtBox.value = text.substr(0, text.length-1);
				else
				{
					var splitTime = new Array();
					splitTime = text.split(':');
					if (splitTime.length == 2)
					{
						var mins = splitTime[1];
						if (mins > 59)
							txtBox.value = text.substr(0, text.length-1);
						else
							txtBox.value = text;
					}
				}
				break;
			default:
				if (charKeyCode == 186)
					txtBox.value = text.substr(0, text.length-1);
				else
					txtBox.value = text.substr(0, text.length-1);
				break;
		}
	}
	else
	{
		txtBox.value = text;
	}
}

function MilitaryTimeCheck(controlName)
{
	var txtBox = document.getElementById(controlName);
	if (txtBox.value.length != 5)
		txtBox.value = '';
	
}
function KeyPadTranslate(charKeyCode)
{
	switch (charKeyCode)
	{
		case 96:
			charKeyCode = 48;
			break;
		case 97:
			charKeyCode = 49;
			break;
		case 98:
			charKeyCode = 50;
			break;
		case 99:
			charKeyCode = 51;
			break;
		case 100:
			charKeyCode = 52;
			break;
		case 101:
			charKeyCode = 53;
			break;
		case 102:
			charKeyCode = 54;
			break;
		case 103:
			charKeyCode = 55;
			break;
		case 104:
			charKeyCode = 56;
			break;
		case 105:
			charKeyCode = 57;
			break;
		case 109:
			charKeyCode = 189;
			break;
		case 110:
			charKeyCode = 190;
			break;
		case 111:
			charKeyCode = 191;
			break;
	}
	
	return charKeyCode;
}

