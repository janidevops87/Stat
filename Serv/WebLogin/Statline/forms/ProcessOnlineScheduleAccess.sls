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
	
	If UpdateScheduleAccess Then
		UpdateSuccess = True
		ValidationMessage = _
		"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
		"Update Successful." & "<BR><BR>" & ChangeDescription & "<BR><BR>After clicking close, please refresh the schedule window to confirm your changes are correct." &_
		"</FONT>"
	Else
		UpdateSuccess = False
		ValidationMessage = _
		"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
		"No updates were recorded." & _
		"</FONT>"
	End If

%>

<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Process Update</title>
</head>

<body bgcolor="#F5EBDD" onload="self.close();">

</body>
</html>

<%	
ELSE
%>

<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Process Update</title>
</head>

<body bgcolor="#F5EBDD" >
	<H1> There has been an error </H1>

</body>
</html>

<%
End If
%>

<%
Function UpdateScheduleAccess()
	Dim ScheduleAccess
	Dim PersonID
	Dim DataSourceName
	
	DataSourceName = "ProductionTransaction"
	PersonID = Request.QueryString("PersonID")

	If Request.QueryString("ScheduleAccess") = 0 Then
		ScheduleAccess = -1
	ElseIF	CInt(Request.QueryString("ScheduleAccess")) = -1 Then
		ScheduleAccess = 0
	End If
		
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	
	
	
	vQuery = "spu_OnlineScheduleAccessList " & ScheduleAccess & ", " & PersonID
    			
	Set RS = Conn.Execute(vQuery)
				
	Set RS = Nothing

	
End Function


Function ValidateScheduleItem

	ValidateScheduleItem = True
			
End Function

Function BuildString(pString)

    Dim i
    
    i = InStr(1, pString, "'", 0)
    
    While i > 0
        pString = Left(pString, i - 1) & "''" & Right(pString, Len(pString) - (i - 1 + Len("'")))
        
        i = InStr(i + Len("''"), pString, "'", 0)
    Wend

    %>
    window
    <%

End Function

%>

