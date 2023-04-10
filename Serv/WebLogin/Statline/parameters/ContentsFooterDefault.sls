<%
Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg

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

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta name="Microsoft Border" content="none">
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<base target="main">
<title>ContentsFrameDefault</title>
</head>

<body bgcolor="#F5EBDD">

<table align="left" border="0" cellPadding="0" cellSpacing="1">
  <tr>
    <td width="100"><small><strong><font face="Arial">Today's Date</font></strong></small></td>
  </tr>
  <tr>
    <td width="100" background bgColor="linen"><small><font face="Times New Roman"><%=FormatDateTime(now(),vbShortDate)%></font></small></td>
  </tr>
  <tr>
    <td width="100"><small><strong><font face="Arial">Logged In</font></strong></small></td>
  </tr>
  <tr>
    <td width="100" background bgColor="linen"><font face="Times New Roman"><small><%=UserName%></small></font></td>
  </tr>
  <tr><td><p>&nbsp;</p></td></tr>
  <tr>
	<td>
		<!-- <a href="/loginstatline/legal.sls" target="_blank"><font size="1" face="Arial">©1996-99 <br> Statline, LLC. <br> All rights reserved. <br></font></a> -->
	</td>
  </tr>
</table>


</body>
</html>

<%
End If
%>

<!--#include virtual="/loginstatline/includes/copyright.shm"-->
