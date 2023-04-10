<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim WebConn
Dim WebDataSourceName
DIM PreAnnounceID
Dim AnnouncementID
Dim Temp
Dim vDeleteString

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

'Execute the main page generating routine

	WebDataSourceName = WEBPROD
	

	Set WebConn = server.CreateObject("ADODB.Connection")
	WebConn.Open WebDataSourceName, DBUSER, DBPWD

%>


<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta name="Microsoft Border" content="none">
<meta http-equiv="EXPIRES" content="0">
<title>AllAnnouncementList</title>
</head>

<body bgcolor="#f5ebdd">

<form name="AllAnnouncementListForm"
    action="<%=strHttpHeader & Request.ServerVariables("SERVER_NAME")%>/parameters/Announcement/ProcessDeleteAnnouncement.sls"
    method="POST">

<%

vQuery = "Execute sps_AllAnnouncement"
Set RS = WebConn.Execute(vQuery)

%>

<table align="left" border="1" cellPadding="5" cellSpacing="0" style="WIDTH: 550px"
 width="550">

<%


If RS.EOF Then

	%>

		<tr>
	   <td checked = "false" valign="top" align="left" width="50"><font face="Arial" size="2"><strong>
			<%=FormatDateTime(now(),vbShortDate)%></strong></font>
		</td>

		<td width="452"><font face="Times New Roman" size="2"><B>There are no current announcements.</B></font>
		</td>
	<%

Else

PreAnnounceID = RS("AnnouncementID")

Do While Not RS.EOF

%>

<%
Temp = RS("AnnouncementMessage")
Temp = Replace(Temp, Chr(10), "<BR>", 1)

%>

	<tr>
	   <td checked = "false" valign="top" align="left" width="50"><font face="Arial" size="2"><strong>
				<%=RS("AnnouncementStartDate")%></strong></font><P>

			<A HREF="/loginstatline/parameters/Announcements/FrameAnnouncementEditor.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&AnnouncementID=<%=RS("AnnouncementID")%>" TARGET="main">Update
			</A><BR>

			<A HREF="javascript:confirmDelete(<%=UserID%>,<%=UserOrgID%>,<%=RS("AnnouncementID")%>);">Delete
			</A>


		</td>
	   <td width="452"><font face="Times New Roman" size="2"><B><%=RS("AnnouncementTitle")%></B><BR>
			<%=Temp%><P>
			<%If left(RS("LinksURL"),7)="mailto:" Then %>
				<a href="<%=RS("LinksURL")%>" >
			<%Else
				'Use the ? Symbol at end of URL to indicate a Statline link
				If right(RS("LinksURL"),1)="?" then%>
					<a href="<%=strHttpHeader & RS("LinksURL")%>UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" target="main">
			<%	Else%>
					<a href="<%=strHttpHeader & RS("LinksURL")%>" target="_blank">
			<%	End If
			End If%>
			<%=RS("LinksName")%></a>
			<%
			RS.MoveNext

	IF RS.EOF Then
	%>
			</font>
		</td>
	</tr>
	<%

		Exit DO
	End  IF

	Do While NOT RS.EOF
		If PreAnnounceID =  RS("AnnouncementID")Then
	%>

			, &nbsp;
			<%If left(RS("LinksURL"),7)="mailto:" Then %>
				<a href="<%=RS("LinksURL")%>" >
			<%Else'Use the ? Symbol at end of URL to indicate a Statline link
				If right(RS("LinksURL"),1)="?" then%>
					<a href="<%=strHttpHeader & RS("LinksURL")%>UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" target="main">
			<%	Else%>
					<a href="<%=strHttpHeader & RS("LinksURL")%>" target="_blank">
			<%	End If
			End If%>

			<%=RS("LinksName")%></a>



		<%
		PreAnnounceID =  RS("AnnouncementID")
		RS.MoveNext
		Else
			PreAnnounceID =  RS("AnnouncementID")
			Exit Do
		End IF
		Loop

		%>
		</font>
	</td>
 </tr>

<%



Loop

End If

Set RS = Nothing
Set Conn = Nothing
Set WebConn = Nothing



%>

</table>
<DIV></DIV>

</body>
</html>

<%

End If
'/loginstatline/parameters/Announcements/ProcessDeleteAnnouncement.sls?UserID=<%=UserID>&UserOrgID=<%=UserOrgID>&AnnouncementID=<%=RS("AnnouncementID")>" TARGET="main"

%>

<script language="JavaScript">


	function confirmDelete(UserID,UserOrgID,AnnouncementID)
	{
	var pos = ""

		pos = "/loginstatline/parameters/Announcements/ProcessDeleteAnnouncement.sls?"
		pos = pos + "UserID=" + UserID
		pos = pos + "&UserOrgID=" + UserOrgID
		pos = pos + "&AnnouncementID=" + AnnouncementID

			if (confirm("Press OK if you sure you want to delete this announcement."))
			{
			window.open(pos,"main")
			}
	}
</script>