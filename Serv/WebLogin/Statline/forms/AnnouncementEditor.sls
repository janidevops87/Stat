<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim CurrentDate
Dim AnnouncementID
Dim StartDate
Dim EndDate
Dim Title
Dim Message
Dim LinksName
Dim LinksURL

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%

CurrentDate = Now
AnnouncementID = Request.QueryString("AnnouncementID")
StartDate = DateValue(Now)
EndDate = ""
Title = ""
Message = ""

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
If AnnouncementID <> Empty Then
	
	'Open Connection
	DataSourceName = WEBPROD
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	
	'Get Announcement Info
	vQuery = "Execute sps_SingleAnnouncement " & AnnouncementID
	Set RS = Conn.Execute(vQuery)
	
	'Deliver Values
	Title = RS("AnnouncementTitle")
	StartDate = RS("AnnouncementStartDate")
	If RS("AnnouncementEndDate") = "1/1/1900" Then
		EndDate = ""
	Else
		EndDate = RS("AnnouncementEndDate")
	End If
	Message = RS("AnnouncementMessage")
	

End If

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
<form name="announcementEditorForm"
	action="/loginstatline/parameters/Announcements/ProcessAnnouncement.sls"
    method="POST">

<%'List the hidden fields%>   
<input type="hidden" name="UserName" value="<%=UserName%>">
<input type="hidden" name="UserID" value=<%=UserID%>>
<input type="hidden" name="CurrentDate" value=<%=CurrentDate%>>
<input type="hidden" name="AnnouncementID" value=<%=AnnouncementID%>>
	
	<!-- Format Data -->
	<table border="0" cellpadding="0" cellspacing="2">	
		<tr>
			<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Created by:</b></font></td>
			<td ALIGN=LEFT VALIGN=center WIDTH=137><font face="Arial" size="2"><%=UserName%></td>
			<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Date/Time:</b></font></td>
			<td ALIGN=LEFT VALIGN=center WIDTH=137><font face="Arial" size="2"><%=CurrentDate%></td>
		</tr>
		<tr>
			<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Start Date:</b></font></td>
			<td ALIGN=LEFT VALIGN=center WIDTH=137><input onfocus="this.select()" name="announcementStartDate" size="10" value ="<%=StartDate%>"></td>
			<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>End Date (optional):</b></font></td>
			<td ALIGN=LEFT VALIGN=center WIDTH=137><input onfocus="this.select()" name="announcementEndDate" size="10" value ="<%=EndDate%>"></td>
		</tr>
	</table>
		
	<table border="0" cellpadding="0" cellspacing="2">	
		<tr>
			<td ALIGN=LEFT VALIGN=center WIDTH=138><font face="Arial" size="2"><b>Announcement Title:</b></font></td>
			<td ALIGN=LEFT VALIGN=center WIDTH=412><input onfocus="this.select()" name="announcementTitle" size="55" value ="<%=Title%>"></td>
		</tr>
	</table>
		

	<table border="0" cellpadding="0" cellspacing="2">	
		<tr>
			<td ALIGN=LEFT VALIGN=TOP><font face="Arial" size="2"><b>Announcement Message</b></font></td>
		</tr>
		<tr>
			<td ALIGN=LEFT VALIGN=TOP><textarea rows="7" name="announcementMessage" cols="65" wrap="virtual"><%=Message%></textarea></td>
		</tr>
	</table>


	</table>
	
	<table  border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<A	HREF="javascript:validate();" NAME="Save">
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

'javascript:document.UpdateAnnouncement.submit()

%>


<script language="JavaScript">


	function validate()
	{
	
	if (!isDate(document.announcementEditorForm.announcementStartDate.value))
		{
			alert ("Date error. Please enter a date in the format of mm/dd/yy.")
			document.announcementEditorForm.announcementStartDate.focus()
			document.announcementEditorForm.announcementStartDate.select()
			return 
		}
		
	if (document.announcementEditorForm.announcementTitle.value == '')
		{
			alert ("Title Error.  Please enter a title for your announcement.")
			document.announcementEditorForm.announcementTitle.focus()
			document.announcementEditorForm.announcementTitle.select()
			return 
		}
		
	if (document.announcementEditorForm.announcementMessage.value == '')
		{
			alert ("Message Error.  Please enter a message for your announcement.")
			document.announcementEditorForm.announcementMessage.focus()
			document.announcementEditorForm.announcementMessage.select()
			return 
		}
			
	if (document.announcementEditorForm.announcementEndDate.value != '')
		{
			if (!isDate(document.announcementEditorForm.announcementEndDate.value))
				{
					alert ("Date error. Please enter a date in the format of mm/dd/yy.")
					document.announcementEditorForm.announcementEndDate.focus()
					document.announcementEditorForm.announcementEndDate.select()
					return
				} 
			else
			window.document.announcementEditorForm.submit()
		}
	else
	
	window.document.announcementEditorForm.submit()

	}

</script>

<!--#include virtual="/loginstatline/includes/datevalidation.js"-->