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
LinksID = Request.QueryString("LinksID")
LinksName = ""
LinksURL = ""

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

'Check for Update Information
If LinksID <> Empty Then
	
	'Open Connection
	DataSourceName = WEBPROD
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	'Get Links Info
	vQuery = "Execute sps_SingleLinks " & LinksID
	Set RS = Conn.Execute(vQuery)
	
	'Deliver Values
	LinksName = RS("LinksName")
	LinksURL = RS("LinksURL")

	End If
	
'End If
    Response.CacheControl = "no-cache" 
    Response.AddHeader "Cache-Control", "private" 
    Response.AddHeader "Pragma", "no-cache" 
    Response.Expires = -1 
		
%>


<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>AnnouncementEditor</title>
</head>

<body bgcolor="#F5EBDD">

<!-- Pending Referrals Table -->
<form name="announcementLinksEditorForm"
	action="/loginstatline/parameters/Announcements/ProcessLinks.sls"
    method="POST">

<%'List the hidden fields%>   
<input type="hidden" name="UserName" value="<%=UserName%>">
<input type="hidden" name="UserID" value=<%=UserID%>>
<input type="hidden" name="CurrentDate" value=<%=CurrentDate%>>
<input type="hidden" name="AnnouncementID" value=<%=AnnouncementID%>>
<input type="hidden" name="LinksID" value=<%=LinksID%>>

	<!-- Format Data -->
	<table border="0" cellpadding="0" cellspacing="2">	
		<tr>
			<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Link Name:</b></font></td>
			<td ALIGN=LEFT VALIGN=center WIDTH=137><input onfocus="this.select()" name="announcementLinksName" size="40" value ="<%=LinksName%>"></td>
		</tr>
		<tr>
			<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Link Address (URL):</b></font></td>
			<td ALIGN=LEFT VALIGN=center WIDTH=137><input onfocus="this.select()" name="announcementLinksURL" size="40" value ="<%=LinksURL%>"></td>
		</tr>
	</table>
	
	<table  border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<A	HREF="javascript:validatelinks();" NAME="Save">
					<IMG src="/loginstatline/images/submit2.gif"
					NAME="Save"
					BORDER="0">
				</A>			
			</td>
			<td>&nbsp;&nbsp;</td>
			<td>
				<A	HREF="javascript:history.back();">
					<IMG src="/loginstatline/images/cancel2.gif"
					NAME="Cancel"
					BORDER="0">
				</A>	
			</td>
		</tr>
	</table>

</form>

</BODY>
</HTML>

<%

	Set RS = Nothing	
	Set Conn = Nothing

End If


%>


<script language="JavaScript">


	function validatelinks()
	{
	
	if (document.announcementLinksEditorForm.AnnouncementID.value == '')
		{
			alert ("Please save the Announcement before adding Links.")
			document.announcementLinksEditorForm.announcementLinksName.focus()
			document.announcementLinksEditorForm.announcementLinksName.select()
			return 
		}
	
	if (document.announcementLinksEditorForm.announcementLinksName.value == '')
		{
			alert ("Name Error.  Please enter a name for your link (example: 'Statline' for www.statline.com).")
			document.announcementLinksEditorForm.announcementLinksName.focus()
			document.announcementLinksEditorForm.announcementLinksName.select()
			return 
		}
		
	if (document.announcementLinksEditorForm.announcementLinksURL.value == '')
		{
			alert ("Address Error.  Please enter an address for your link (example 'www.statline.com' for Statline.")
			document.announcementLinksEditorForm.announcementLinksURL.focus()
			document.announcementLinksEditorForm.announcementLinksURL.select()
			return 
		}
	
	else
	
	window.document.announcementLinksEditorForm.submit()

	}

</script>
