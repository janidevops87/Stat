<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 


Dim Conn
Dim RS
Dim vQuery
Dim	UserName
Dim	UserID
Dim Comments
Dim DataSourceName
Dim CurrentDate
Dim UpdateSuccess
Dim ValidationMessage
Dim LinksID
Dim AnnouncementID
Dim LinksName
Dim LinksURL
Dim DebugMessage

DebugMessage = "<BR>Debug:"

'Validate and update information
DebugMessage = DebugMessage & "<BR>Before Update"
	
If UpdateLinks Then
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

'Response.Write(DebugMessage)
%>


<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Process Links</title>
</head>

<body bgcolor="#F5EBDD" onload="history.back();history.back();">
 
</body>
</html>


<%
Function UpdateLinks()

	DataSourceName = "WebProd"
	UserName = Request.Form("UserName")
	UserID = Request.Form("UserID") 
	LinksID = Request.Form("LinksID")
	LinksName = Request.Form("announcementLinksName")
	LinksURL = Request.Form("announcementLinksURL")
	CurrentDate = Request.Form("CurrentDate") 
	AnnouncementID = Request.Form("AnnouncementID")
	
	
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	

	If LinksID = Empty Then
	
		'Build the query
		vQuery = "Execute spi_Links '" & LinksName & "','" & LinksURL & "','" & UserName & "','" & AnnouncementID & "'"

	Else
		
		'Build the query
		vQuery = "Execute spu_Links '" & LinksID & "','" & LinksName & "','" & LinksURL & "','" & UserName & "', " & AnnouncementID
	
	End If
		
	DebugMessage = DebugMessage & "<BR>Query: " & vQuery
	
	Call Conn.Execute(vQuery)
	
	'There was a db error
	If Conn.Errors.Count > 0 Then
	
		DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
		'Discontinue processing of the function
		UpdateLinks = False
		Exit Function
	
	Else
	
		UpdateLinks = True
			
	End If

End Function

%>

