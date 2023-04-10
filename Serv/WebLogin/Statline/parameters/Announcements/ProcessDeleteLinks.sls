<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim Conn
Dim RS
Dim vQuery
Dim LinksID
Dim DataSourceName
Dim DeleteLinks
Dim ValidationMessage
Dim DebugMessage

DebugMessage = "<BR>Debug:"

'Validate and update information
DebugMessage = DebugMessage & "<BR>Before Delete"
	
If DeleteLinks Then
	DeleteLinks = True
	
	ValidationMessage = _
	"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
	"Announcement Deleted." & _
	"</FONT>"
Else
	DeleteLinks = False
	ValidationMessage = _
	"<FONT SIZE=4 FACE=Arial COLOR = Red>" & _
	"Announcement Deleted." & _
	"</FONT>"
End If

LinksID = Request.QueryString("LinksID")

'Response.Write(DebugMessage)
%>


<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>ProcessDeleteLinks</title>
</head>

<body bgcolor="#F5EBDD" onload="history.back();">

</body>
</html>


<%

DataSourceName = "WebProd"
	
'Establish a database connection
Set Conn = server.CreateObject("ADODB.Connection")

	
	
vQuery = "Execute spd_Links " & LinksID	
'DebugMessage = DebugMessage & "<BR>Query: " & vQuery
	
Call Conn.Execute(vQuery)
	
'There was a db error
If Conn.Errors.Count > 0 Then

	DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
	'Discontinue processing of the function
	DelteLinks = False

	
Else
	
	DeleteLinks = True
			
End If

%>