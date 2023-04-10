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
<head>
	<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
	<meta name="Microsoft Border" content="none">
	<meta http-equiv="EXPIRES" content="0">
	<title>AllAnnouncementHeader</title>
</head>

<body bgcolor="#f5ebdd">

	<table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px" width="550" bgColor="#112084">
		<tr>
			<td width="50%"><font color=#ffffff face="Arial" size="4"><B>&nbsp;Home</B></font></td>
		</tr>
	</table>

	<br><br>

<table align="left" border="0" cellPadding="5" cellSpacing="0" style="WIDTH: 550px"
 width="550" bgColor="linen">
  <tr>
    <td checked = "false" valign="center" align="left" width="15%"><font face="Arial" size="2"><strong>Date</strong></font></td>
    <td width="20%" valign="center"><font face="Arial" size="2">
            <%=FormatDateTime(now(),vbShortDate)%></font></td>
    <td checked = "false" valign="center" align="left" width="15%"><font face="Arial" size="2"><strong>User</strong></font></td>
    <td valign="center"width="35%"><font face="Arial" size="2">
            <%=UserName%></font></td>
    <td checked = "false" valign="center" align="left" width="10%"><font face="Arial" size="2"><strong>Comments&nbsp;&nbsp;</strong></font></td>
    <td valign="center" width="25%"><font face="Arial" size="2">&nbsp;&nbsp;<!--#include virtual="/loginstatline/includes/ClientServicesMailTo.sls"--></font></td>
  </tr>
</table>

	<p>&nbsp;</p>

	<table align="left" border="1" cellPadding="5" cellSpacing="0" style="WIDTH: 550px" width="550">
		<tr>
			<td width="50%"><font face="Arial" size="3"><B>Announcements</B></font>
			</td>
			<td width="50%" align="Right"><font face="Arial" size="3"><B>
				<A HREF="/loginstatline/parameters/Announcements/FrameAnnouncementEditor.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>"
				TARGET="main">Add New Announcement</A></B></font>
			</td>
		</tr>
	</table>

	<br><br>

<table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
	width="550" bgColor="#112084">
	<tr bgColor="#112084">
		<td width="60" bgColor="#112084" align="left"><font color=#FFFFFF face="Arial" size="1"><b>&nbsp;Date</b></font></td>
		<td width="442" bgColor="#112084" align="left"><font color=#FFFFFF face="Arial" size="1"><b>&nbsp;Message</b></font></td>
	</tr>
</table>

	<DIV></DIV>

</body>
</html>

<%
End If
%>