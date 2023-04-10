<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

'Dim Conn
'Dim RS
'Dim vQuery
Dim AnnouncementID
'Dim DataSourceName
Dim DeleteAnnouncement
Dim ValidationMessage
Dim DebugMessage
%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
DebugMessage = "<BR>Debug:"

'Validate and update information
DebugMessage = DebugMessage & "<BR>Before Delete"
	
If DeleteAnnouncement Then
	DeleteAnnouncement = True
	
	ValidationMessage = _
	"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
	"Announcement Deleted." & _
	"</FONT>"
Else
	DeleteAnnouncement = False
	ValidationMessage = _
	"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
	"Announcement Deleted." & _
	"</FONT>"
End If

AnnouncementID = Request.QueryString("AnnouncementID")

'Response.Write(DebugMessage)
%>


<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>ProcessDeleteAnnouncement</title>
</head>

<body bgcolor="#F5EBDD" onload="history.back();">

</body>
</html>


<%

DataSourceName = "WebProd"
	
'Establish a database connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD
	
	
vQuery = "Execute spd_Announcement " & AnnouncementID	
'DebugMessage = DebugMessage & "<BR>Query: " & vQuery
	
Call Conn.Execute(vQuery)
	
'There was a db error
If Conn.Errors.Count > 0 Then

	DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
	'Discontinue processing of the function
	DelteAnnouncement = False

	
Else
	
	DeleteAnnouncement = True
			
End If

%>