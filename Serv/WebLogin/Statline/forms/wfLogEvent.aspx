<%@ Page Language="vb" AutoEventWireup="false" Codebehind="wfLogEvent.aspx.vb" Inherits="FrmLogEvent.wfLogEvent" debug="False" errorPage="err_default.htm"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Log Event - #<%=session("CallNumber")%></title>
		<meta content="True" name="vs_showGrid">
		<meta content="Microsoft Visual Studio.NET 7.0" name="GENERATOR">
		<meta content="Visual Basic 7.0" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<style>.CSSPop {
	LEFT: 257px; VISIBILITY: visible; BORDER-TOP-STYLE: outset; BORDER-RIGHT-STYLE: outset; BORDER-LEFT-STYLE: outset; POSITION: absolute; TOP: 34px; BACKGROUND-COLOR: activeborder; BORDER-BOTTOM-STYLE: outset
}
.CSSNoPop {
	VISIBILITY: hidden; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; TOP: 34px; BACKGROUND-COLOR: transparent; BORDER-BOTTOM-STYLE: none
}
		</style>
	</HEAD>
	<BODY oncontextmenu="return false" bgColor="buttonface">
		<script lang="javascript">
		
			//********************BEGIN GLOBAL DECLARATIONS************************//
			var vPrevCtl = "";
			
			var KeyCode = new Array();
			var KeyCodeName = new Array();
			var KeyCodeNote = new Array();
			//********************END GLOBAL DECLARATIONS**************************//
			
			
			//********************BEGIN MASK FUNCTIONS****************************//
			function maskEdit(){
				var vCurrCtl;
				vCurrCtl = document.activeElement;
				//alert(window.event.keyCode);
				switch(window.event.keyCode){
					case 8:
						//Backspace
						break;
					case 9:
						//Tab
						break;
					case 37:
						//Forward Arrow
						break;
					case 39:
						//Backward Arrow
						break;
					case 46:
						//Delete
						break;
					default:					
						switch(vCurrCtl.name){
							case "txtCalloutDate":
									if(vCurrCtl.value != ""){
										vCurrCtl.value = maskDateTime(vCurrCtl.value);
									}
									break;
									
							case "txtContactDate":
									if(vCurrCtl.value != ""){
										vCurrCtl.value = maskDateTime(vCurrCtl.value);
									}
									break;
									
							case "txtContactPhone":
									if(vCurrCtl.value != ""){
										vCurrCtl.value = maskPhone(vCurrCtl.value);
									}
									break;
									
							case "txtContactDesc":					
									if(vCurrCtl.value != ""){
										replaceKeyCode(vCurrCtl);
									}
									break;	
						}
						break;
				}
				return;
			}
			
			function maskDateTime(vValue){
				switch(vValue.length){
					case 2:
						return vValue + '/';
						break;
						
					case 5:
						return vValue + '/';
						break;
						
					case 8:
						return vValue + '  ';
						break;
						
					case 12:
						return vValue + ':';
						break;
					
					default:
						return vValue;
						break;
				}
			}
			
			function maskPhone(vValue){
				switch(vValue.length){
					case 1:
						return '(' + vValue;
						break;
						
					case 4:
						return vValue + ') ';
						break;
						
					case 9:
						return vValue + '-';
						break;
					
					default:
						return vValue;
						break;
				}
			}
			//********************END MASK FUNCTIONS******************************//
					
			
			//********************BEGIN VALIDATION FUNCTIONS**********************//
			function valPrev(ctl){
			//Note: validate function validates previously-active control (before focus changed)
			
				var vPrevCtlValid;
				
				//If cancelling out of Log Event, don't validate
				document.Form1.cancelForm.value = 'false';
				if(ctl.name == 'cmdCancel'){
					document.Form1.cancelForm.value = 'true';
					return true;
				}
			
				//Do LostFocus/Validate event-handling for the previous control
				if(vPrevCtl.name != ctl.name){
					//alert('Curr: ' + ctl.name);
					//alert('Prev: ' + vPrevCtl.name);
				
					switch(vPrevCtl.name){
						case "txtContactDate":
							if(!valDate(vPrevCtl.value) || vPrevCtl.value == ''){
								alert('Invalid Contact Date.');
								
								vPrevCtlValid = false;
								vPrevCtl.focus();
								selectCtl(vPrevCtl);
							}else{
								vPrevCtlValid = true;
								vPrevCtl = ctl;
								selectCtl(ctl);
							}
							break;
							
						case "txtContactPhone":
							if(!valPhone(vPrevCtl.value)){
								alert('Invalid Contact Phone.');
								
								vPrevCtlValid = false;
								vPrevCtl.focus();
								selectCtl(vPrevCtl);
							}else{
								vPrevCtlValid = true;
								vPrevCtl = ctl;
								selectCtl(ctl);
							}
							break;
							
						case "txtCalloutDate":
							if(!valCtlCalloutDate(vPrevCtl)){
								vPrevCtlValid = false;
								vPrevCtl.focus();
								selectCtl(vPrevCtl);
							}else{
								vPrevCtlValid = true;
								vPrevCtl = ctl;
								selectCtl(ctl);
							}
							break;
							
						case "txtCalloutMins":
							if(!valNum(vPrevCtl.value)){
								alert('Invalid Callout Mins.');
								
								vPrevCtlValid = false;
								vPrevCtl.focus();
								selectCtl(vPrevCtl);
							}else{
								
								if(vPrevCtl.value != ""){
									//Do some extra work for this control
									if(vPrevCtl.value != document.Form1.OldCalloutMins.value){
										document.Form1.txtCalloutDate.value = dateAddMinutes(vPrevCtl.value, new Date());
										valCtlCalloutDate(document.Form1.txtCalloutDate);
									}
								}
								
								vPrevCtlValid = true;
								vPrevCtl = ctl;
								selectCtl(ctl);
							}
							break;
							
						default:
							vPrevCtlValid = true;
							vPrevCtl = ctl;
							selectCtl(ctl);
							break;						
					}
					
					//Check for any form validation messages from the server
					if(ctl.name != 'cboContactEventType' && !dispFormValMsg(ctl)){
						return false;
					}
					
					//Do GotFocus event-handling for this control
					if(vPrevCtlValid){					
						switch(ctl.name){
							case "txtCalloutMins":
								document.Form1.OldCalloutMins.value = ctl.value;
								break;
								
							case "txtCalloutDate":
								document.Form1.OldCalloutDate.value = ctl.value;
								break;
								
							case "cmdCancel":
								document.Form1.cancelForm.value = 'true';
								break;
						}
					}
					
					return vPrevCtlValid;
				}
				
				return true;
			}
			
			function dispFormValMsg(ctl){
				//Check if there's a validation message for a control other than this one
				if(document.Form1.ValCtl.value != "" && ctl.name != document.Form1.ValCtl.value){
					//Display the message
					alert(document.Form1.ValMsg.value);
					
					//Set focus to the invalid control
					for(var i=0; i < Form1.length; i++){
						if(Form1.elements[i].name == document.Form1.ValCtl.value){
							document.Form1.elements[i].focus();
							document.Form1.elements[i].select();
						}
					}
					
					return false;
				}
				
				//If DisplayOnce is set, delete the validation message (Note: any round-trips back to the server will also reset the validation message)
				//Currently, only true is allows for ValDisplayOnce; Task: add functionality to allow false values
				if(document.Form1.ValDisplayOnce.value == 'True'){
					document.Form1.ValCtl.value = ''
					document.Form1.ValMsg.value = ''
					document.Form1.ValDisplayOnce.value = ''
				}
				
				return true;
			}
			
			function valPrevCSS(ctl){
				//Checkboxes within a <SPAN> element don't automatically revert to previous state;
				//This function was created to handle chkConfirmed onfocus/onclick events
				if(!valPrev(ctl)){
					if(ctl.name == 'chkConfirmedSpan'){
						ctl.childNodes(0).checked = !ctl.childNodes(0).checked;
					}
					return false;
				}
				
				if(ctl.childNodes(0).checked && (document.Form1.cboContactEventType.value == 3 || document.Form1.cboContactEventType.value == 14)){
					
					//Hide CallMins/CalloutDate and labels
					document.Form1.txtCalloutDate.style.visibility = 'Hidden';
					document.Form1.txtCalloutMins.style.visibility = 'Hidden';
					document.all.lblCallout.style.visibility = 'Hidden';
					document.all.lblCalloutUnits.style.visibility = 'Hidden';
					
					var re = new RegExp('Callout after ' + document.Form1.OldCalloutDate.value + '.',"ig");
					document.Form1.txtContactDesc.value = (document.Form1.txtContactDesc.value).replace(re, '');
					return true;
				}
				
				if(!ctl.childNodes(0).checked && (document.Form1.cboContactEventType.value == 3 || document.Form1.cboContactEventType.value == 14)){
					
					//Unhide CallMins/CalloutDate and labels
					document.Form1.txtCalloutDate.style.visibility = 'Visible';
					document.Form1.txtCalloutMins.style.visibility = 'Visible';
					document.all.lblCallout.style.visibility = 'Visible';
					document.all.lblCalloutUnits.style.visibility = 'Visible';
					
					var re = new RegExp(document.Form1.txtContactDesc.value,"ig");
					document.Form1.txtContactDesc.value = (document.Form1.txtContactDesc.value).replace(re, 'Callout after ' + document.Form1.txtCalloutDate.value + '. ' + document.Form1.txtContactDesc.value);
					return true;
				}
			}
			
			function valCtlCalloutDate(ctl){
								
				if(ctl.value != document.Form1.OldCalloutDate.value && ctl.value != ''){				
					if(!valDate(ctl.value)){
						alert('Invalid Callout Date.');
						return false;
					}
					
					//Check if the date/time is before now
					if(dateDiffMinutes('n', new Date(), ctl.value) < 0){
						alert('Date/time is before now.');
						return false;
					}
					
					//Warn if date/time is greater than one day
					if(dateDiffMinutes('d', new Date(), ctl.value) > 0){
						alert('You have set a callout greater than a 1 day from now. Please verify.');
					}
					
					document.Form1.txtCalloutMins.value = dateDiffMinutes('n', new Date(), ctl.value);
			        
			        if(document.Form1.txtContactDesc.value == '')
						document.Form1.txtContactDesc.value = 'Callout after ' + ctl.value + '.';
					else
						var re = new RegExp(document.Form1.OldCalloutDate.value,"ig");
						document.Form1.txtContactDesc.value = (document.Form1.txtContactDesc.value).replace(re, ctl.value);
				}
				
				return true;
			}
			
			function valDate(pvValue){
			//Note: This function validates the following date/time format: "00/00/00  00:00"
			//To validate other date/time formats, the date/time must first be converted to this format
			
				if(pvValue == "") return true;
				
				//VALIDATE THE FORMAT (IE. CHARACTER TYPES AND POSITIONS, INCLUDING SPACES AND DATE/TIME DELIMITERS)
				var pattern = /^\d{2}\/\d{2}\/\d{2}\s{2}\d{2}:\d{2}$/;
				if(!pattern.test(pvValue)){
					return false;
				}
				
				
				//SPLIT THE STRING INTO DATE AND TIME
				var vDateTimeArray = pvValue.split(/\s{2}/);
				var vDatePart = vDateTimeArray[0];
				var vTimePart = vDateTimeArray[1];
				
				
				//VALIDATE THE DATE PART		
				//Extract the date parts
				var vMonth = vDatePart.charAt(0) + vDatePart.charAt(1);
				var vDay = vDatePart.charAt(3) + vDatePart.charAt(4);
				var vYear = vDatePart.charAt(6) + vDatePart.charAt(7);
				
				//Build the month pattern
				var vPatternMonth = (vMonth.charAt(0) == '0') ? '[0][1-9]' : '[1][0-2]';
					
				//Build the day pattern
				//First Day digit - depends on the month:
				var vPatternDay = (vMonth == '02') ? '[0-2]' : '[0-3]';
                			
				//Second Day digit - based on first Day digit:
				switch(vDay.charAt(0)){
					case '0':
						vPatternDay = vPatternDay + '[1-9]';
						break;
						
					case '1':
						vPatternDay = vPatternDay + '[0-9]';
						break;
						
					case '2':						
						if(vMonth == '02'){
							//It's Feb, so check for leap year
							var i = 0;
							var vLeapYear = false;
							
							while(i < (vYear + 1)){
								if(vYear == i){
									//We have a match, so it's a leap year
									vLeapYear = true;
									break;
								}
								
								i = i + 4;
							}
							
							//Apply second day digit based on whether it's a leap year
							vPatternDay = vPatternDay + (vLeapYear ? '[0-9]' : '[0-8]');	
						}else{						
							vPatternDay = vPatternDay + '[0-9]';	
						}						
						break;
						
					case '3':
						//Some months only have 30 days
						switch(vMonth.charAt(0) + vMonth.charAt(1)){
							case "04":
								vPatternDay = vPatternDay + '[0]';
								break;
							case "06":
								vPatternDay = vPatternDay + '[0]';
								break;
							case "09":
								vPatternDay = vPatternDay + '[0]';
								break;
							default:
								vPatternDay = vPatternDay + '[0-1]';
								break;
						}
						break;
				}
				
				//Build the year pattern
				vPatternYear = '[0-9]{2}';
				
				var vPatternDate = "^" + vPatternMonth + "\/" + vPatternDay + "\/" + vPatternYear + "$";
				var vRegExp = new RegExp(vPatternDate);
				//alert('Date Pattern = ' + vPatternDate);
				//alert('Date Valid? ' + vDatePart + ' = ' + vRegExp.test(vDatePart));
				if(!vRegExp.test(vDatePart)){
					return false;
				}
				
				
				//VALIDATE THE TIME PART
				var vHours = vTimePart.charAt(0) + vTimePart.charAt(1);
				var vMinutes = vTimePart.charAt(3) + vTimePart.charAt(4);
				
				var vPatternHours = (vHours.charAt(0) == 2) ? '[0-2][0-3]' : '[0-2][0-9]';
				var vPatternMinutes =  '[0-5][0-9]';
				var vPatternTime = vPatternHours + ':' + vPatternMinutes;
				
				vRegExp.compile(vPatternTime);
				//alert('Time Pattern = ' + vPatternTime);
				//alert('Time Valid? ' + vTimePart + ' = ' + vRegExp.test(vTimePart));
				if(!vRegExp.test(vTimePart)){
					return false;
				}
				
				
				//IF ALL TESTS WERE PASSED, VALIDATION SUCCEEDED
				return true;
			}
			
			function valPhone(pvValue){
				if(pvValue == "") return true;
				
				//Verify the exact characters for phone
				var pattern = /^\([0-9]{3}\)\s{1}[0-9]{3}-[0-9]{4}$/;	
				return pattern.test(pvValue);
			}
			
			function valNum(pvValue){
				if(pvValue == "") return true;
				
				//Verify the exact characters for number
				var pattern = /^[0-9]{0,5}$/;	
				return pattern.test(pvValue);
			}
			//********************END VALIDATION FUNCTIONS************************//
			
			
			//********************BEGIN UTILITY FUNCTIONS*************************//
			function dateAddMinutes(pvMin, pvDateTime){
			//Note: First parameter is a string or number; Second parameter is the current date/time - "new Date()"
			
				//This adds the specified minutes to the client's system date (accounts for timezone and daylight savings)
				var vDate = new Date();
				vDate.setMinutes(vDate.getMinutes() + parseInt(pvMin));
				return datetimeFormat(vDate);
			}
			
			function dateDiffMinutes(pvType, pvDateTime1, pvDateTime2){		
			//Note: First and third parameters are strings; Second parameter is the current date/time - "new Date()"
			//Task: Add Timezone differences
			
				//Extract date/time parts from the string
				var vDateTimeArray = pvDateTime2.split(/\s{2}/);
				var vDatePart = vDateTimeArray[0];
				var vTimePart = vDateTimeArray[1];								
				var vMonth = vDatePart.charAt(0) + vDatePart.charAt(1);
				var vDay = vDatePart.charAt(3) + vDatePart.charAt(4);
				var vYear = '20' + vDatePart.charAt(6) + vDatePart.charAt(7);
				var vHours = vTimePart.charAt(0) + vTimePart.charAt(1);
				var vMinutes = vTimePart.charAt(3) + vTimePart.charAt(4);
				
				//Create a new Date object
				var vDateTime2 = new Date(vYear, vMonth-1, vDay, vHours, vMinutes);
			
				//Get the number of milliseconds for UTC datetime
				var vUTCMS1 = (pvDateTime1.valueOf());
				var	vUTCMS2 = (vDateTime2.valueOf());
				
				var vDiff;
				switch(pvType){
					case 'n':
						vDiff = Math.ceil((vUTCMS2 - vUTCMS1) / 60059);
						break;
					case 'd':
						vDiff = Math.floor((vUTCMS2 - vUTCMS1) / (60000 * 1439));
						break;
				}
			
				return vDiff;
			}
			
			function datetimeFormat(pvDateTime){
			//Note: pvDateTime is a Date object
				
				//Extract the date parts
				var vMonth = pvDateTime.getMonth() + 1;
				var vDay = pvDateTime.getDate();
				var vYear = pvDateTime.getFullYear();
				var vHours = pvDateTime.getHours();
				var vMinutes = pvDateTime.getMinutes();
				
				//Format the date parts
				if(vMonth < 10) vMonth = '0' + vMonth;
				if(vDay < 10) vDay = '0' + vDay;
				vYear = vYear.toString().substr(2,2);
				if(vHours < 10) vHours = '0' + vHours;
				if(vMinutes < 10) vMinutes = '0' + vMinutes;
								
				//Return the combined, formatted datetime
				return (vMonth + '/' + vDay + '/' + vYear + '  ' + vHours + ':' + vMinutes);
			}
			
			/*
			Function DaylightSavings(ByVal LocalDate)
				If CDate(LocalDate) >= GetSunday(4, DatePart("yyyy", LocalDate), "First") _
				And CDate(LocalDate) <= GetSunday(10, DatePart("yyyy", LocalDate), "Last") Then
					DayLightSavings = True

				Else
					DayLightSavings = False
				End If

			End Function
			*/
			function getSunday(pvMonth, pvYear, pvFirstLast){
			//GetSunday returns the Date of the day requested
				
				//Test stuff:
				var DateTest1 = new Date();
				DateTest1.setFullYear(pvYear, pvMonth, 1);
				alert(DateTest1);
				alert(DateTest1.getTimezoneOffset());
				var DateTest2 = new Date();
				alert(DateTest2);
				alert(DateTest2.getTimezoneOffset());
				
				var dCurrentDate = new Date(pvYear, pvMonth, 1, 2, 0, 0);
								
				//if FirstLast = First loop through given month and year until reaching first sunday
				if(pvFirstLast == 'First'){
					for(var i = 1; i < 32; i++){
					
						dCurrentDate.setDate(i)
						alert(dCurrentDate);
						
						//if CurrentDate is date check if it is Sunday.
						if(dCurrentDate.getDay() == 0){
							return dCurrentDate;
						}
					}
					
				//if FirstLast = Last loop through given month and year starting with the last day of the month	
				}else if(pvFirstLast == 'Last'){
					for(var i = 31; i > 0; i--){
							
						dCurrentDate.setDate(i)
						alert(dCurrentDate);

						//if CurrentDate is date check if it is Sunday.
						if(dCurrentDate.getDay() == 0){
							return dCurrentDate;
						}
					}
				}
				
			}
    
			
			function selectCtl(ctl){
				if(ctl.type == 'text') ctl.select();
			}
			
			function popOtherNameForm(){
				document.all.pnlOtherName.className = 'CSSPop';
				document.all.pnlOtherName.style.top = '34px';
			}
			
			function replaceKeyCode(ctl){
				var vDescString = ctl.value;
								
				//Check if the last char is a space
				if(vDescString.lastIndexOf(' ') == vDescString.length-1){
					//Loop through KeyCodes
					for(var i = 0; i < KeyCode[0].length; i++){
						//Create RegExp and get array of matches
						var re = new RegExp(KeyCode[0][i] + ' ',"ig");
						var arMatches = vDescString.match(re);
						
						//Check if there's a match
						if(arMatches != null){
							//Check if the last match is at the end of the string
							if(arMatches.lastIndex == vDescString.length){
																				
								//Remove the KeyCode and make a new string
								var vNoCodeString = vDescString.substr(0, vDescString.length - (KeyCode[0][i] + ' ').length);
								
								//Replace the textbox value with the new string if there's a leading space (ie. word boundary)
								if(vNoCodeString.lastIndexOf(' ') == vNoCodeString.length-1){
									ctl.value = vDescString.substr(0, vDescString.length - (KeyCode[0][i] + ' ').length) + KeyCode[1][i];
									break;
								}
							}
						}
					}
				}
				
				return;
			}
			//********************END UTILITY FUNCTIONS**************************//
			
			
			//********************BEGIN MISCELLANEOUS FUNCTIONS******************//
			
			//********************END MISCELLANEOUS FUNCTIONS********************//
		</script>
		<form id="Form1" onkeyup="maskEdit();" method="post" runat="server">
			<asp:button id="cmdCancel" style="Z-INDEX: 103; LEFT: 546px; POSITION: absolute; TOP: 107px" tabIndex="11" runat="server" Text="Cancel" Width="88px" Height="23px"></asp:button><asp:textbox id="txtContactDate" style="Z-INDEX: 106; LEFT: 57px; POSITION: absolute; TOP: 10px" runat="server" Width="98px" Height="20px" MaxLength="15">00/00/00 00:00</asp:textbox><asp:textbox id="txtContactDesc" style="Z-INDEX: 105; LEFT: 258px; POSITION: absolute; TOP: 34px" tabIndex="8" runat="server" Width="272px" Height="94px" MaxLength="999" TextMode="MultiLine"></asp:textbox><asp:button id="cmdOK" style="Z-INDEX: 102; LEFT: 545px; POSITION: absolute; TOP: 10px" tabIndex="9" runat="server" Text="Save" Width="88px" Height="24px"></asp:button><asp:checkbox id="chkConfirmed" style="Z-INDEX: 104; LEFT: 546px; POSITION: absolute; TOP: 55px" tabIndex="10" runat="server" Text="Contact Confirmed" Width="81px" Height="27px" Font-Size="12pt"></asp:checkbox><asp:dropdownlist id="cboContactEventType" style="Z-INDEX: 107; LEFT: 333px; POSITION: absolute; TOP: 10px" tabIndex="7" runat="server" Width="196px" Height="17px" AutoPostBack="True"></asp:dropdownlist><asp:label id="lblEventType" style="Z-INDEX: 108; LEFT: 257px; POSITION: absolute; TOP: 12px" tabIndex="50" runat="server" Width="78px" Height="22px" Font-Size="12pt">Event Type</asp:label><asp:label id="Label2" style="Z-INDEX: 109; LEFT: 14px; POSITION: absolute; TOP: 11px" tabIndex="50" runat="server" Font-Size="12pt">Date</asp:label><asp:label id="lblContactName" style="Z-INDEX: 110; LEFT: 13px; POSITION: absolute; TOP: 35px" tabIndex="50" runat="server" Width="44px" Height="21px" Font-Size="12pt">Name</asp:label><asp:dropdownlist id="cboName" style="Z-INDEX: 111; LEFT: 56px; POSITION: absolute; TOP: 34px" tabIndex="1" runat="server" Width="167px" Height="17px" AutoPostBack="True"></asp:dropdownlist><asp:label id="lblContactOrg" style="Z-INDEX: 112; LEFT: 13px; POSITION: absolute; TOP: 55px" tabIndex="50" runat="server" Width="44px" Height="16px" Font-Size="12pt">Org</asp:label><asp:textbox id="txtContactOrg" style="Z-INDEX: 113; LEFT: 55px; POSITION: absolute; TOP: 57px" tabIndex="3" runat="server" Width="198px" Height="21px"></asp:textbox><asp:label id="lblContactPhone" style="Z-INDEX: 114; LEFT: 12px; POSITION: absolute; TOP: 80px" tabIndex="50" runat="server" Width="44px" Font-Size="12pt">Phone</asp:label><asp:textbox id="txtContactPhone" style="Z-INDEX: 115; LEFT: 56px; POSITION: absolute; TOP: 80px" tabIndex="4" runat="server" Width="198px" Height="23px" MaxLength="14"></asp:textbox><asp:textbox id="txtCalloutMins" style="Z-INDEX: 116; LEFT: 55px; POSITION: absolute; TOP: 105px" tabIndex="5" runat="server" Width="35px" Height="22px"></asp:textbox><asp:label id="lblCalloutUnits" style="Z-INDEX: 117; LEFT: 92px; POSITION: absolute; TOP: 110px" tabIndex="50" runat="server" Width="64px" Height="20px" Font-Size="9pt">min. or after</asp:label><asp:textbox id="txtCalloutDate" style="Z-INDEX: 118; LEFT: 156px; POSITION: absolute; TOP: 105px" tabIndex="6" runat="server" Width="98px" Height="22px" MaxLength="15"></asp:textbox><asp:label id="lblCallout" style="Z-INDEX: 119; LEFT: 2px; POSITION: absolute; TOP: 106px" tabIndex="50" runat="server" Font-Size="12pt">Callback</asp:label><asp:button id="cmdValidationMsg" style="Z-INDEX: 120; LEFT: 644px; POSITION: absolute; TOP: 25px" runat="server" Text="Invalid Callout Date!" Width="190px" Height="107px" Font-Bold="True" BackColor="#C0C0FF" ForeColor="Red" BorderColor="RosyBrown" CausesValidation="False" Visible="False" BorderStyle="Dashed"></asp:button><INPUT 
id=ValMsg 
style="Z-INDEX: 121; LEFT: 12px; WIDTH: 212px; POSITION: absolute; TOP: 233px; HEIGHT: 22px" 
type=hidden size=30 value='<%=Session("ValMsg")%>'> <INPUT 
id=ValCtl 
style="Z-INDEX: 122; LEFT: 12px; WIDTH: 211px; POSITION: absolute; TOP: 258px; HEIGHT: 23px" 
type=hidden size=29 value='<%=Session("ValCtl")%>'> <INPUT 
id=ValDisplayOnce 
style="Z-INDEX: 123; LEFT: 13px; WIDTH: 211px; POSITION: absolute; TOP: 284px; HEIGHT: 23px" 
type=hidden size=29 value='<%=Session("ValDisplayOnce")%>'> <INPUT id=OldCalloutMins 
style="Z-INDEX: 124; LEFT: 12px; WIDTH: 211px; POSITION: absolute; TOP: 207px; HEIGHT: 22px" 
type=hidden size=29 value='<%=Session("OldCalloutMins")%>' name=OldCalloutMins> <INPUT id=OldCalloutDate 
style="Z-INDEX: 125; LEFT: 12px; WIDTH: 212px; POSITION: absolute; TOP: 181px; HEIGHT: 23px" 
type=hidden size=30 value='<%=Session("OldCalloutDate")%>' name=OldCalloutDate>
			<asp:label id="Label3" style="Z-INDEX: 126; LEFT: 18px; POSITION: absolute; TOP: 158px" runat="server" Width="203px" Height="12px" Visible="False" Font-Underline="True">Hidden Fields:</asp:label><asp:panel id="pnlOtherName" style="Z-INDEX: 127; LEFT: 257px; POSITION: absolute; TOP: 133px" runat="server" Width="288px" Height="75px" BorderStyle="Outset" CssClass="CSSNoPop">
				<asp:Label id="Label4" runat="server" Width="280px" Font-Size="10pt" Font-Bold="True" BackColor="Desktop" ForeColor="White" Font-Names="Arial">Person Name</asp:Label>
				<asp:Label id="spacer3" runat="server" Width="4px" Height="1pt"></asp:Label>
				<asp:Label id="Label6" runat="server" Width="95px" Font-Size="10pt" Font-Names="Arial">Person Name:</asp:Label>
				<asp:TextBox id="txtOtherName" runat="server" Width="172px" Height="24px" BorderStyle="Inset"></asp:TextBox>
				<asp:Label id="spacer4" runat="server" Width="60px" Font-Size="10pt"></asp:Label>
				<asp:Button id="cmdOtherName" runat="server" Text="OK" Width="67px"></asp:Button>
				<asp:Label id="spacer9" runat="server" Width="28px" Height="10px" Font-Size="10pt"></asp:Label>
				<asp:Button id="cmdOtherNameCancel" runat="server" Text="Cancel" Width="67px" Height="25px"></asp:Button>
			</asp:panel><INPUT id="btnNameDetail" style="Z-INDEX: 101; LEFT: 225px; WIDTH: 29px; POSITION: absolute; TOP: 34px; HEIGHT: 20px" onclick="popOtherNameForm();" type="button" value="...">
			<asp:dropdownlist id="cboKeyCode" style="Z-INDEX: 128; LEFT: 261px; POSITION: absolute; TOP: 279px" runat="server" Width="212px"></asp:dropdownlist><asp:label id="Label1" style="Z-INDEX: 129; LEFT: 261px; POSITION: absolute; TOP: 236px" runat="server" Width="195px" Visible="False" Font-Underline="True">Key Code List (Do NOT delete or set Visible to False!):</asp:label><INPUT id="cancelForm" style="Z-INDEX: 130; LEFT: 14px; WIDTH: 209px; POSITION: absolute; TOP: 311px; HEIGHT: 22px" type="hidden" size="29" value="false" name="cancelForm"></form>
		<script lang="javascript">
			window.resizeTo(655, 165)
					
			KeyCode[0] = KeyCodeName;
			KeyCode[1] = KeyCodeNote;
			
			for(var i=0; i < document.Form1.cboKeyCode.length; i++){
				KeyCodeName[i] = document.Form1.cboKeyCode.options[i].value;
				KeyCodeNote[i] = document.Form1.cboKeyCode.options[i].text;
			}
		</script>
	</BODY>
</HTML>
