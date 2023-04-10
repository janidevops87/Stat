<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim AnnouncementID

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%

AnnouncementID = Request.QueryString("AnnouncementID")

'Verify Access
If AuthorizeMain Then

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user name
	vQuery = "sps_WebPerson " & UserID
	Set RS = Conn.Execute(vQuery)
	UserName = RS("PersonFirst") & " " & RS("PersonLast")
	Set RS = Nothing	
	Set Conn = Nothing
	

	
%>

<html>

<head bgcolor="#F5EBDD" >
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta http-equiv="EXPIRES" content="0">
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>FrameAnnouncementEditor</title>
</head>


<frameset border="0" framespacing="0" frameborder="0" rows="124,275,*">
	
	<frame name="EditorHeader" scrolling="no" noresize target="contents" src="/LoginStatline/parameters/Announcements/AnnouncementEditorHeader.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&AnnouncementID=<%=AnnouncementID%>">
	<frame name="EditorDisplay" src="/LoginStatline/forms/AnnouncementEditor.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&AnnouncementID=<%=AnnouncementID%>" scrolling="auto" noresize>
	<frame name="EditorLinks" src="/LoginStatline/forms/AnnouncementLinks.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&AnnouncementID=<%=AnnouncementID%>" scrolling="auto" noresize>
</frameset>
  
  <noframes>
  <body topmargin="5" leftmargin="5" bgcolor="#F5EBDD" >
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes> 

</html>

<%

'/LoginStatline/forms/AnnouncementLinks.sls?UserID=<%=UserID>&UserOrgID=<%=UserOrgID>&AnnouncementID=<%=AnnouncementID>
End If
%>