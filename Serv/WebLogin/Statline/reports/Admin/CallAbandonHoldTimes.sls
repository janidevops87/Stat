<% Option Explicit %>
<HTML>
<HEAD>
<TITLE>Abandoned Calls</TITLE>
</HEAD>
<BODY BGCOLOR="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%

Dim FontNameHead 
Dim FontSizeHead 
Dim FontNameData 
Dim FontSizeData 
Dim FontNameHeadLog 
Dim FontSizeDataLog 
Dim FontNameDataLog 

Dim pvStartDate
Dim pvEndDate
Dim vTotalIncomingCalls
Dim vTotalStartInterval
Dim vTotalEndInterval
Dim pvUserOrgID
Dim vReportGroupID
Dim vReportGroupName

Dim x, ConnDash, vTotalCalls

FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeDataLog = "1.5"
FontNameDataLog = "Times New Roman"

Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
pvUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
%>


<% If AuthorizeMain Then%>

<!-- Begin Header -->
<TABLE Width="100%">
<TD VALIGN=TOP>
	<TABLE WIDTH = "100%">
	<TR>
		<TD WIDTH="10%"><IMG SRC="/loginstatline/images/logo1.gif" WIDTH=60 HEIGHT=60></TD>
		<TD WIDTH="50%" ALIGN=LEFT>
			<TABLE>
				<TR><TD ALIGN=LEFT><FONT SIZE="5" FACE="Arial Black"><B>Abandoned Calls</TD></TR>
			</TABLE>
		</TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>Period:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvStartDate%></TD>
		<TD WIDTH="6%" VALIGN=CENTER><FONT SIZE="4" FACE="<%=FontNameHead%>"><B>To:</TD>
		<TD WIDTH="14%" VALIGN=CENTER><FONT SIZE="3" FACE="<%=FontNameData%>"><%=pvEndDate%></TD>
	</TABLE>
</TD></TABLE>
<BR></BR>
<!-- End Header -->



<!-- Incoming Calls Section -->
<%
'Open production data connection
'Set Conn = server.CreateObject("ADODB.Connection")
'Conn.Open DataSourceName, DBUSER, DBPWD

'Open the dash data connection
Set ConnDash = server.CreateObject("ADODB.Connection")
ConnDash.Open DASHDSN, DBUSER, DBPWD

vQuery = "sps_AbandonedCallSummary '" & pvStartDate & "', '" & pvEndDate & "' "
'Response.Write vQuery
Set RS = ConnDash.Execute(vQuery)

IF RS("ID") = 0 Then
	vTotalIncomingCalls		= RS("CALLS")
	vTotalStartInterval		= RS("Start")
	vTotalEndInterval		= RS("End")
	RS.MoveNext
End IF
%>

<TABLE WIDTH="100%" BORDER=0>
<TR>

	<TD VALIGN=TOP WIDTH="50%" ALIGN=LEFT>

	<!-- Incoming Calls Header -->
	<TABLE WIDTH="100%" BORDER=0>
	<TR><TD ALIGN=LEFT COLSPAN=3> <FONT FACE="Arial"><B> Abandoned Calls </B></FONT> </TD></TR>
	<TR><TD ALIGN=LEFT COLSPAN=3> <FONT FACE="Arial" SIZE="1"> (all regions, including page responses) </FONT> </TD></TR>
	<TR><TD WIDTH="100%">

		<TABLE WIDTH="90%" BORDER=0>
		<TR>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Hold Time (sec)</TD></B>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>% Calls</TD></B>
			<%If pvUserOrgID = 194 Then%>
				<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B># Calls</TD></B>
			<%Else%>
				<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>&nbsp</TD></B>
			<%End If%>
		</TR>

		<%If vTotalIncomingCalls = 0 Then%>

			<TR>
				<TD ALIGN=LEFT WIDTH="90%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </TD>
			</TR>

		<%Else
			Call ExecuteIncoming
		End If
		Set RS = Nothing
		%>

		</TABLE>
	</TD></TR>
	</TABLE>
	</TD>



<%If pvUserOrgID = 194 Then%>
<!-- Total Calls Section -->

	<%vTotalCalls = vTotalIncomingCalls

	If vTotalCalls = 0 Then%>

		<!-- Total Calls Header -->
		<TR><TD>&nbsp</TD></TR>
		<TABLE WIDTH="50%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B></FONT></TD></TR>
		<TR><TD WIDTH="100%">
		<TABLE WIDTH="90%">
		<TR>
			<TD ALIGN=LEFT WIDTH="90%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B># Calls</TD></B>
		</TR>
		<TR><TD></TD></TR>

		<TR>
			<TD ALIGN=LEFT WIDTH="90%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> There is no data available for the chosen date range. </TD>
		</TR>
		</TD></TR></TABLE></TABLE>

	<%Else%>

		<!-- Total Calls Header -->
		<TR><TD>&nbsp</TD></TR>
		<TABLE WIDTH="50%" BORDER=0>
		<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B>Total Calls</FONT></TD></TR>
		<TR><TD WIDTH="100%">
		<TABLE WIDTH="90%">
		<TR>
			<TD ALIGN=LEFT WIDTH="60%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><B>Total Abandoned Calls</TD></B>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
				<a target="CallAbandonedList" href="/loginstatline/reports/admin/callAbandonedList.sls?UserID=<%=Request.QueryString("UserID")%>&amp;ReportGroupID=<%=Request.QueryString("ReportGroupID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=<%=vTotalStartInterval%>&amp;EndInterval=<%=vTotalEndInterval%>&amp;"><%=vTotalCalls%></a>
			</TD>
		</TR>
		<TR><TD></TD></TR>

		</TR></TABLE></TABLE>

	<%End If

End If

Set RS = Nothing
Set ConnDash = Nothing
Set Conn = Nothing

End If
%>

</BODY>
</HTML>

<!--#include virtual="/loginstatline/includes/copyright.shm"-->


<%Sub ExecuteIncoming()

	While NOT RS.EOF

%>

	<TR>
		<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"> <%=RS("start")%> - <%=RS("End")%> </TD>

		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<%=ROUND(RS("CALLS")/vTotalIncomingCalls * 100,1)%>
			</TD>
		<%Else%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ROUND(RS("CALLS")/vTotalIncomingCalls * 100,1)%></TD>
		<%End If%>

		<%If pvUserOrgID = 194 Then%>
			<TD ALIGN=LEFT WIDTH="30%"><FONT NAME = "<%=FontNameHead%>" SIZE="<%=FontSizeHead%>">
			<a target="callholdtable" href="/loginstatline/reports/admin/callAbandonedList.sls?UserID=<%=Request.QueryString("UserID")%>&amp;UserOrgID=<%=Request.QueryString("UserOrgID")%>&amp;DSN=<%=Request.QueryString("DSN")%>&amp;StartDate=<%=Request.QueryString("StartDate")%>&amp;EndDate=<%=Request.QueryString("EndDate")%>&amp;StartInterval=<%=RS("Start")%>&amp;EndInterval=<%=RS("End")%>&amp;"><%=RS("CALLS")%></a>
			</TD>
		<%End If%>

	</TR>

<%
	RS.MoveNext
	WEND
End Sub%>







<%
Sub FixQueryString(pvIn, pvOut)
	pvOut = ""
	For x=1 TO Len(pvIn)
		If Mid(pvIn,x,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,x,1)
		End If
	Next
End Sub
%>