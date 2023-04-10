<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

'Dim Conn
'Dim RS
'Dim vQuery
Dim	UserName
'Dim	UserID
Dim Comments
'Dim DataSourceName
Dim CurrentDate
Dim UpdateSuccess
Dim ValidationMessage
Dim AnnouncementID
Dim AnnouncementTitle
Dim AnnouncementMessage
Dim AnnouncementStartDate
Dim AnnouncementEndDate
Dim DebugMessage

DebugMessage = "<BR>Debug:"

'Validate and update information
DebugMessage = DebugMessage & "<BR>Before Update"
%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
	
If UpdateAnnouncement Then
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
<title>Process Announcement</title>
</head>

<body bgcolor="#F5EBDD" onload="history.back();history.back()" >

 
</body>
</html>


<%
Function UpdateAnnouncement()

	DataSourceName = "WebProd"
	UserName = Request.Form("UserName")
	UserID = Request.Form("UserID") 
	AnnouncementTitle = Request.Form("AnnouncementTitle")
	AnnouncementMessage = Request.Form("AnnouncementMessage")
	AnnouncementStartDate = Request.Form("AnnouncementStartDate")
	AnnouncementEndDate = Request.Form("AnnouncementEndDate") 
	CurrentDate = Request.Form("CurrentDate") 
	AnnouncementID = Request.Form("AnnouncementID")
	
	
	'Establish a database connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	'Build the Message string
	AnnouncementMessage = BuildString(AnnouncementMessage)
	
	If AnnouncementID = Empty Then
	
		'Build the query
		vQuery = "Execute spi_Announcement '" & AnnouncementTitle & "','" &	AnnouncementMessage & "','" & AnnouncementStartDate & "','" & AnnouncementEndDate & "','" & UserName & "'"

	Else
		
		'Build the query
		vQuery = "Execute spu_Announcement '" & AnnouncementID & "','" & AnnouncementTitle & "','" &	AnnouncementMessage & "','" & AnnouncementStartDate & "','" & AnnouncementEndDate & "','" & UserName & "'"
	
	End If
		
	DebugMessage = DebugMessage & "<BR>Query: " & vQuery
	
	Call Conn.Execute(vQuery)
	
	'There was a db error
	If Conn.Errors.Count > 0 Then
	
		DebugMessage = DebugMessage & "<BR>" & Conn.Errors.Item(0).Description
		'Discontinue processing of the function
		UpdateAnnouncement = False
		Exit Function
	
	Else
	
		UpdateAnnouncement = True
			
	End If

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

