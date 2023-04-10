<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim CurrentDate
Dim AnnouncementID
Dim LinksID
Dim LinksName
Dim LinksURL

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%

CurrentDate = Now
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

    Response.CacheControl = "no-cache" 
    Response.AddHeader "Cache-Control", "private" 
    Response.AddHeader "Pragma", "no-cache" 
    Response.Expires = -1 
%>

<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>AnnouncementLinks</title>
</head>

<body bgcolor="#F5EBDD">

<%

'Check for Update Information
If AnnouncementID = Empty Then

%>

<table border="1" cellpadding="5" cellspacing="0" style="WIDTH: 550px">
	<tr>
		<td ALIGN=LEFT VALIGN=TOP><font face="Arial" size="2">Links can be added after the announcement has been saved.</font></td>
	</tr>
</table>

<%

Else
	
	'Open Connection
	DataSourceName = WEBPROD
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	'Get Announcement Info
	vQuery = "Execute sps_SingleAnnouncement " & AnnouncementID
	Set RS = Conn.Execute(vQuery)
		
%>

<!-- Pending Referrals Table -->
<form name="announcementLinksForm"
	action="/loginstatline/parameters/Announcements/ProcessLinks.sls"
    method="POST">
<!--
<%'List the hidden fields%>   
<input type="hidden" name="UserName" value="<%=UserName%>">
<input type="hidden" name="UserID" value=<%=UserID%>>
<input type="hidden" name="CurrentDate" value=<%=CurrentDate%>>
<input type="hidden" name="AnnouncementID" value=<%=AnnouncementID%>>
-->	
<table border="1" cellpadding="5" cellspacing="0" style="WIDTH: 550px">
	<tr>
		<td ALIGN=LEFT VALIGN=TOP><font face="Arial" size="2"><b>
		<A HREF="/loginstatline/forms/AnnouncementLinksEditor.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&AnnouncementID=<%=AnnouncementID%>"
				TARGET="EditorLinks">Add a New Link</A></B></font></td>
	</tr>
</table>
		
<%
	'Check for Links
	If AnnouncementID <> Empty Then
		If RS("LinksID") <> Empty Then
%>		
	<table border="1" cellpadding="5" cellspacing="0" style="WIDTH: 550px">
		
<%
	Do While NOT RS.EOF 

	%>
		<tr>
			<td ALIGN=LEFT VALIGN=TOP><font face="Arial" size="2">				
				<a href="<%=strHttpHeader & RS("LinksURL")%>" target="_blank">
				<%=RS("LinksName")%></a>
			</td>
			<td ALIGN=LEFT VALIGN=TOP><font face="Arial" size="2">
				<a href="<%=strHttpHeader & RS("LinksURL")%>" target="_blank"><%=RS("LinksURL")%></a>
			</td>
			<td ALIGN=LEFT VALIGN=TOP><font face="Arial" size="2">
				<A HREF="/loginstatline/forms/AnnouncementLinksEditor.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&LinksID=<%=RS("LinksID")%>&AnnouncementID=<%=RS("AnnouncementID")%>" TARGET="EditorLinks">Update</A>
				&nbsp &nbsp &nbsp
				<A HREF="/loginstatline/parameters/Announcements/ProcessDeleteLinks.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&LinksID=<%=RS("LinksID")%>" TARGET="main">Delete</A>			
			</td>
		</tr>
	<%	
		RS.MoveNext	
		
	Loop
	

%>

	</table>

<%	
		End If	
	End If	
End If	
	
%>
	</table>
</form>

</BODY>
</HTML>

<%

	Set RS = Nothing	
	Set Conn = Nothing

End If

%>


