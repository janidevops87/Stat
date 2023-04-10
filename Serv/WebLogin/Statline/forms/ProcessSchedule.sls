<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim Conn
Dim DataSourceName
Dim RS
Dim vQuery

Dim CallID
Dim	UserName
Dim UserOrgName
Dim	UserOrgID
Dim	UserID
Dim CallerOrgID
Dim ConsentComments
Dim RecoveryComments

Dim TZ
Dim UpdateSuccess
Dim GeneralConsent
Dim ValidationMessage

Dim ForLoopCounter
Dim ScheduleLogType
Dim ScheduleLogChange
Dim PersonNameCurrent
Dim PersonNameNew
Dim ChangeDescription
ReDim UpdateArray(7,0)

Dim DebugMessage
ChangeDescription = ""
DebugMessage = "<BR>Debug:"

UserOrgID = Request.QueryString("UserOrgID")
UserID = Request.QueryString("UserID")
'Validate and update information
If ValidateScheduleItem Then

	
	DebugMessage = DebugMessage & "<BR>Before Update"
	
	If UpdateSchedule Then
		UpdateSuccess = True
		ValidationMessage = _
		"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
		"Update Successful." & "<BR><BR>" & ChangeDescription & "<BR><BR>After clicking close, please refresh the schedule window to confirm your changes are correct.<br><br>Note: Changes may take up to a minute to be reflected.  If your change does not show up upon refreshing, wait a few seconds and try refreshing again." &_
		"</FONT>"
	Else
		UpdateSuccess = False
		ValidationMessage = _
		"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
		"No updates were recorded." & _
		"</FONT>"
	End If
	
ELSE
	
End If
%>


<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Process Update</title>
</head>

<body bgcolor="#F5EBDD">

	<%'Response.Write(ValidationMessage & "<BR>" & DebugMessage)%>
	<%Response.Write(ValidationMessage)%>

	<br></br>
	<%'Show a Back button if the update failed.
	If UpdateSuccess = False Then%>
		<A	HREF="javascript:window.history.back();" NAME="Back">
			<IMG src="/loginstatline/images/back.gif"
			NAME="Back"
			BORDER="0">
		</A>	
	<%End If%>
	
	<A	HREF="javascript:self.close();" NAME="Close">
		<IMG src="/loginstatline/images/close2.gif"
		NAME="Close"
		BORDER="0">
	</A>		

</body>
</html>



<%
Function UpdateSchedule()
	ReDim UpdateArray(7, Request.Form("MaxPriority"))
	DataSourceName = "ProductionTransaction"
	'Response.Write (Ubound(UpdateArray,2) & "<BR>")
	'Response.Write ("test" & Request.Form("ScheduleItemID") & "<BR>")
	
	For ForLoopCounter = 0 to UBound(UpdateArray,2)
	
		UpdateArray(0, ForLoopCounter) = Request.Form("ScheduleItemID")
		UpdateArray(1, ForLoopCounter) = Request.Form("UserOrgID")
		UpdateArray(2, ForLoopCounter) = ForLoopCounter + 1
		UpdateArray(3, ForLoopCounter) = Request.Form("CurrentOnCall"& ForLoopCounter + 1)
		UpdateArray(4, ForLoopCounter) = Request.Form("NewOnCall" & ForLoopCounter + 1)
		UpdateArray(5, ForLoopCounter) = Request.Form("ScheduleGroupID")
		UpdateArray(6, ForLoopCounter) = Request.Form("StartShift")
		UpdateArray(7, ForLoopCounter) = Request.Form("EndShift")
			
	Next
	UserName = Request.Form("UserName")
	UserOrgName = Request.Form("UserOrgName")
	UserOrgID = Request.Form("UserOrgID")
	UserID = Request.Form("UserID") 
	TZ = Request.Form("TZ")
	
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	
	
	
	'UpdateArray(8,0)
	'0. @vScheduleItemID, 
	'1. @vUserOrgID, 
	'2. @vPriority, 
	'3. vCurrentPersonID, 
	'4. vNewPersonID, 
	'5. @vScheduleGroupID, 
	'6. vStartShift,
	'7. vEndShift
	
	'Test array UpdateArray
		'Dim element0,element1
		'For element1 = 0 to Ubound(UpdateArray,2)
			'For element0 = 0 to Ubound(UpdateArray,1)
				'Response.Write (element1 & " " & element0 & " " & UpdateArray(Element0, Element1) & "<BR>")
			'Next
		'Next

	'Loop through the UpdateArray.
	FOR ForLoopCounter = 0 to Ubound(UpdateArray, 2) 
		'compare the new and current person id, if the ids are 	different	
		If UpdateArray(3, ForLoopCounter) <> UpdateArray(4, ForLoopCounter) Then
			' delete the current person if the it is greater than 0
			If UpdateArray(3, ForLoopCounter) > 0 Then
				vQuery = "spd_ScheduleItemPerson " & UpdateArray(0, ForLoopCounter) & ", " &  UpdateArray(1, ForLoopCounter) &", " & UpdateArray(2, ForLoopCounter)
				'Response.Write vQuery
				
				
				Set RS = Conn.Execute(vQuery)
				
				If Conn.Errors.Count > 0 Then
				
					UpdateSchedule = False
					Exit Function
					
				ELSE
					UpdateSchedule = True
					Set RS = Nothing	
				End If	
				
			End If
			
			
			'insert the new person if the new person id > 0 and delete was succesful @vScheduleItemID, @vPersonID, @vPriority                      
			If UpdateArray(4, ForLoopCounter) > 0 Then
										
				vQuery = "spi_ScheduleItemPerson " & UpdateArray(0, ForLoopCounter) & ", " &  UpdateArray(4, ForLoopCounter) &", " & UpdateArray(2, ForLoopCounter)
				'Response.Write vQuery

				Set RS = Conn.Execute(vQuery)
				
				If Conn.Errors.Count > 0 Then
				
					UpdateSchedule = False
					Exit Function
					
				ELSE
					UpdateSchedule = True
					Set RS = Nothing	
				End	If	

			End IF		
			' log any all changes made If insert was successful.
			' if new person id = 0 and current person id > 0 log delete person
			If UpdateArray(4, ForLoopCounter) = 0 and UpdateArray(3, ForLoopCounter) > 0 Then
				ScheduleLogType = "Delete Person"
				ScheduleLogChange = "Delete Person " & "#" & UpdateArray(2, ForLoopCounter) & " " & GetPersonName(UpdateArray(3, ForLoopCounter))
				
			End If
			' if new person id > 0 and current person id = 0 log add person
			If UpdateArray(4, ForLoopCounter) > 0 and UpdateArray(3, ForLoopCounter) = 0 Then
				ScheduleLogType = "Insert Person"
				ScheduleLogChange = "Insert Person " & "#" & UpdateArray(2, ForLoopCounter) & " " &  GetPersonName(UpdateArray(4, ForLoopCounter))
			End If
	
			' if new person > 0 and current person > 0 log Edit Person 
			If UpdateArray(4, ForLoopCounter) > 0 and UpdateArray(3, ForLoopCounter) > 0 _
			and UpdateArray(4, ForLoopCounter) <> UpdateArray(3, ForLoopCounter)  Then
				ScheduleLogType = "Edit Person"
				ScheduleLogChange = "Change Person " & "#" & UpdateArray(2, ForLoopCounter) & " from " & GetPersonName(UpdateArray(3, ForLoopCounter)) & " to " & GetPersonName(UpdateArray(4, ForLoopCounter))
			End If

			'spi_ScheduleLog @vScheduleGroupID, @vScheduleLogDateTime, @vPersonID, @vScheduleLogType, @vScheduleLogShift, @vScheduleLogChange
			vQuery = "spi_ScheduleLog " &  UpdateArray(5, ForLoopCounter) & ", '" & Now() & "', " & GetPersonID(UserID) & ", '" & ScheduleLogType & "', '" & FormatDateTime(UpdateArray(6, ForLoopCounter), 2) & " " & FormatDateTime(UpdateArray(6, ForLoopCounter), 4 ) & " " & WeekDayName(DatePart("w",UpdateArray(6, ForLoopCounter)), True)  & ", " & FormatDateTime(UpdateArray(7, ForLoopCounter), 2) & " " & FormatDateTime(UpdateArray(7, ForLoopCounter), 4) & " " & WeekDayName(DatePart("w", UpdateArray(7, ForLoopCounter)), True) & "', '" & ScheduleLogChange & "'"					
			'Response.Write vQuery
			Set RS = Conn.Execute(vQuery)
			ChangeDescription = ChangeDescription & ScheduleLogChange & "<br>"
			If Conn.Errors.Count > 0 Then
				UpdateSchedule = False
				Exit Function
			ELSE
				UpdateSchedule = True
				Set RS = Nothing	
			End	If	

		Else
			If UpdateSchedule <> True Then 
				UpdateSchedule = False
			End IF	
		End If
	Next
			
	Set RS = Nothing

	
End Function




Function ValidateScheduleItem
	

	ValidateScheduleItem = True
			
End Function

Function GetPersonName(PersonID)
	
	vQuery = "sps_person 0, " & PersonID
	'Response.Write vQuery
	Set RS = Conn.Execute(vQuery)
	GetPersonName = RS("PersonFirst") & " " & RS("PersonLast")
	Set RS = Nothing
End Function


Function GetPersonID(PersonID)

	vQuery = "sps_WebPerson " & PersonID
	
	Set RS = Conn.Execute(vQuery)
	GetPersonID = RS("PersonID")
	Set RS = Nothing

End Function
Function BuildString(pString)

    Dim i
    
    i = InStr(1, pString, "'", 0)
    
    While i > 0
        pString = Left(pString, i - 1) & "''" & Right(pString, Len(pString) - (i - 1 + Len("'")))
        
        i = InStr(i + Len("''"), pString, "'", 0)
    Wend

    BuildString = pString

End Function

%>

