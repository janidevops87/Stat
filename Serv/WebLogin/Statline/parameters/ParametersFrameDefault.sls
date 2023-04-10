<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%

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
<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<title>ParametersFrameDefault</title>
</head>
 
<frameset border="0" framespacing="0" frameborder="0" rows="142,*">
	
	<frame name="MainHeader" scrolling="no" noresize target="contents" src="/loginstatline/parameters/Announcements/AnnouncementHeader.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>">
	<frame name="MainDisplay" src="/loginstatline/parameters/Announcements/AnnouncementList.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" scrolling="auto" noresize>
</frameset>
  
  <noframes>
  <body topmargin="5" leftmargin="5" bgcolor="#F5EBDD" >
  <p>This page uses frames, but your browser doesn't support them.</p>
  </body>
  </noframes>

</html>

<%
End If
%>

