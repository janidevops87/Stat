<%
Option Explicit

Dim Conn
Dim DataSourceName
Dim RS
Dim vQuery

Dim CallID
Dim	UserName
Dim UserOrgName
Dim	UserOrgID
Dim	UserID
Dim Comments
Dim ChangeNote
Dim OldApproachPersonID
Dim NewApproachPersonID

Dim OldApproachPersonName
Dim NewApproachPersonName

Dim UpdateSuccess
Dim ValidationMessage

Dim DebugMessage
DebugMessage = "<BR>Debug:"

'Validate and update information
DebugMessage = DebugMessage & "<BR>Before Update"

'drh 11/20/02 - Check if User has the Call open
If CheckIfOpen Then
	If UpdateReferral Then
		UpdateSuccess = True
	
		ValidationMessage = _
		"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
		"Update Successful." & _
		"</FONT>"
	Else
		UpdateSuccess = False
		ValidationMessage = _
		"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
		"Update Failed." & _
		"</FONT>"
	End If
Else
	UpdateSuccess = False
	ValidationMessage = _
	"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
	"This referral is currently open and cannot be modified at this time." & _
	"<br>Please try again later." & _
	"</FONT>"
End If

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

%>


<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Process Update</title>
</head>

<%'drh 11/20/02 - Removed onload="self.close();"; added onUnload event handler%>
<body bgcolor="#F5EBDD" onUnload="javascript:window.opener.location.reload();">

<%'drh 11/20/02 - Write the validation message
Response.Write(ValidationMessage)%>

</body>
</html>


<%'drh 11/20/02
Function CheckIfOpen()
	CheckIfOpen = false
	DataSourceName = "ProductionTransaction"
	
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	
	
	vQuery = "sps_IncompleteReferralDetail1 " & "MT" & ", " & Request.Form("CallID")
	'Response.Write(vQuery)
	Set RS = Conn.Execute(vQuery)	
	'Response.write(RS("CallOpenByID") & ": " & Request("UserID"))
	
	If RS("CallOpenByID") = 0 and RS("CallOpenByWebPersonId") = CInt(Request("UserID")) Then
		CheckIfOpen = true
	End If
End Function
%>


<%
Function UpdateReferral()

	DataSourceName = "ProductionTransaction"
	CallID = Request.Form("CallID")
	UserName = Request.Form("UserName")
	UserOrgName = Request.Form("UserOrgName")
	UserOrgID = Request.Form("UserOrgID")
	UserID = Request.Form("UserID") 
	Comments = Request.Form("Comments") 
	OldApproachPersonID = Request.Form("OldApproachPersonID")
	NewApproachPersonID = Request.Form("ApproachPerson")
	
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	
	
	If OldApproachPersonID <> NewApproachPersonID Then
	
		'Build the query
		vQuery = "UPDATE Referral SET "

		'Approach person
		vQuery = vQuery & "ReferralApproachedByPersonID = " & NewApproachPersonID & " "
					
		'Specify the call to update
		vQuery = vQuery & " WHERE CallID = " & CallID
	
		DebugMessage = DebugMessage & "<BR>Query: " & vQuery
	
		Call Conn.Execute(vQuery)
	
		'There was a db error
		If Conn.Errors.Count > 0 Then
	
			DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
			'Discontinue processing of the function
			UpdateReferral = False
			Exit Function
	
		Else
	
			'If the referral was successfully updated, 
			'Update the comments field
			If UpdateComments = False Then
				'Discontinue processing of the function
				UpdateReferral = False
				Exit Function
			End If		
			
		End If
	
	End If
	
	UpdateReferral = True
	
End Function


Function UpdateComments

	'Get the name of the old approach person
	vQuery = "sps_Person null, " & OldApproachPersonID
	Set RS = Conn.Execute(vQuery)	
	'There was a db error
	If Conn.Errors.Count > 0 Then
		'Discontinue processing of the function
		UpdateComments = False
		Exit Function
	End If		
	OldApproachPersonName = RS("PersonFirst") & " " & RS("PersonLast")
	Set RS = Nothing	
	
	'Get the name of the new approach person
	vQuery = "sps_Person null, " & NewApproachPersonID
	Set RS = Conn.Execute(vQuery)	
	'There was a db error
	If Conn.Errors.Count > 0 Then
		'Discontinue processing of the function
		UpdateComments = False
		Exit Function
	End If		
	NewApproachPersonName = RS("PersonFirst") & " " & RS("PersonLast")
	Set RS = Nothing		
		
	'Log the change
	ChangeNote = "Changed approach person from " & OldApproachPersonName & " to " & NewApproachPersonName & "."
	
	'Insert a consent outcome event	
	vQuery = "INSERT INTO LogEvent (CallID, LogEventTypeID, LogEventName, LogEventPhone, LogEventOrg, LogEventDesc, StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID, ScheduleGroupID, PersonID, PhoneID, LogEventContactConfirmed) "	
	vQuery = vQuery & "VALUES (" & CallID & ",1,'" & UserName & "','','" & UserOrgName & "','" & ChangeNote & "',77,'" & Now() & "',0," & UserOrgID & ",0," & UserID & ",0,0)"
			
	Call Conn.Execute(vQuery)
				
	'There was a db error
	If Conn.Errors.Count > 0 Then
		'Discontinue processing of the function
		UpdateComments = False
		Exit Function
	End If		

	'Check if there are any user comments
	If Comments <> "" Then
		Comments = BuildString(Comments)
	
		'Insert a consent outcome event	
		vQuery = "INSERT INTO LogEvent (CallID, LogEventTypeID, LogEventName, LogEventPhone, LogEventOrg, LogEventDesc, StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID, ScheduleGroupID, PersonID, PhoneID, LogEventContactConfirmed) "	
		vQuery = vQuery & "VALUES (" & CallID & ",1,'" & UserName & "','','" & UserOrgName & "','" & Comments & "',77,'" & Now() & "',0," & UserOrgID & ",0," & UserID & ",0,0)"
			
		Call Conn.Execute(vQuery)
				
		'There was a db error
		If Conn.Errors.Count > 0 Then
			'Discontinue processing of the function
			UpdateComments = False
			Exit Function
		End If	
	End If
	
	UpdateComments = True
	
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


