<% Option Explicit %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual InterDev 6.0">
<TITLE>Organization Person List</TITLE>
</HEAD>

<BODY BGCOLOR="#F5EBDD">

<%
	Dim i
	Dim ErrorReturn
	Dim vErrorMsg
	Dim Org
	Dim FontNameHead
	Dim FontSizeHead
	Dim FontNameData
	Dim FontSizeData
	Dim pvReportGroupID
	Dim pvOrgID
	Dim pvStartDate
	Dim pvEndDate
	Dim vReportGroupName
	Dim ReportStartDate
	Dim ReportEndDate
	Dim vReportTitle
	Dim vMainTitle
	Dim vTitlePeriod
	Dim vTitleTo
	Dim vTitleTimes
	Dim pvUserOrgID

	'Dim vQuery
	'Dim Conn
	'Dim RS

	FontNameHead = "Arial"
	FontSizeHead = "2"
	FontNameData = "Times New Roman"
	FontSizeData = "2"
	
	pvUserOrgID = Request.QueryString("UserOrgID")
	pvReportGroupID = Request.QueryString("ReportGroupID")
	pvOrgID = Request.QueryString("OrgID")
	'Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	'Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	ReportStartDate = left(Request.QueryString("StartDate"),len(Request.QueryString("StartDate"))-6)
	ReportEndDate = left(Request.QueryString("EndDate"), len(Request.QueryString("EndDate"))-6)


	''Declare vaiables
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%
	If AuthorizeMain Then
	
	'Set Title Values
	vMainTitle = "Organization Requestor/Callers"
	vTitlePeriod = ""
	vTitleTo = ""
	vTitleTimes = ""
%>
	<!-- Print the header. -->
	<!--#include virtual="/loginstatline/reports/admin/Head.sls"-->	

	
	<TABLE BORDER=0 WIDTH="100%">

	<TR><TD COLSPAN=7><IMG SRC="/loginstatline/images/redline.gif" HEIGHT=2 WIDTH="100%"></TD></TR>

	<%

	'Get the Person List
	pvStartDate = "'" & pvStartDate & "'"
	pvEndDate = "'" & pvEndDate & "'"
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	vQuery = "sps_GetPersonList " & "2, '" & pvReportGroupID & "', " & pvStartDate & ", " & pvEndDate & ", " & pvOrgID
	'Print Organization Adress
	'Response.Write "2: " & vQuery
	Set RS = Conn.Execute(vQuery)
	IF NOT RS.EOF Then
		Call PrintHeader
	End IF
	SET RS = Nothing

	'Print Organization Personnel Designated as Requestors
	vQuery = "sps_GetPersonList " & "1, " & pvReportGroupID & ", " & pvStartDate & ", " & pvEndDate & ", " & pvOrgID
	'Response.Write "1: " & vQuery
	Set RS = Conn.Execute(vQuery)
	IF NOT RS.EOF Then
		Call DesignatedRequestor()
	End IF
	Set RS = Nothing

	'Print Organization Personnel Designated as Requestors by Date
	vQuery = "sps_GetPersonList " & "4, " & pvReportGroupID & ", " & pvStartDate & ", " & pvEndDate & ", " & pvOrgID
	'Response.Write "4: " & vQuery
	Set RS = Conn.Execute(vQuery)
	IF NOT RS.EOF Then
		Call DesignatedRequestorByDate()
	End IF
	Set RS = Nothing


	'Print Organization Personnel Who request but are not Designated

	vQuery = "sps_GetPersonList " & "3, " & pvReportGroupID & ", " & pvStartDate & ", " & pvEndDate & ", " & pvOrgID
	'Response.Write "3: " & vQuery
	Set RS = Conn.Execute(vQuery)
	IF NOT RS.EOF Then
		Call NonDesignatedRequestor()
	End IF

	Set RS = Nothing


	'Print Organization Personnel Who Call in Referrals
	vQuery = "sps_GetPersonList " & "0, " & pvReportGroupID & ", " & pvStartDate & ", " & pvEndDate & ", " & pvOrgID
	'Response.Write "0: " & vQuery
	Set RS = Conn.Execute(vQuery)
	IF NOT RS.EOF Then
		Call Callers()
	End IF
	Set RS = Nothing
	Set Conn = Nothing
Else

	Response.Write "Access Denied"

End If
	Function PrintHeader()
		%>
		<TR>
			<TD COLSPAN=7><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=RS("Hospital")%></FONT></B></TD>
		</TR>
		<TR>
			<TD COLSPAN=7><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=RS("Address")%></FONT></B></TD>
		</TR>
		<TR>
			<TD COLSPAN=7><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=RS("City")%>, <%=RS("State")%>&nbsp <%=RS("Zip")%></FONT></B></TD>
		</TR>
		<TR>
			<TD COLSPAN=7><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=RS("Phone")%></FONT></B></TD>
		</TR>


<%	End Function
	Function DesignatedRequestor()
		i = 1
%>
		<TR><TD COLSPAN=7><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
		<TR><TD COLSPAN=7><P STYLE="line-height: 2pt">&nbsp</P></TD></TR>
		<TR>
			<BR>
			<TD COLSPAN=4 VALIGN=TOP><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Designated Requestors</FONT></B></TD>
		</TR>
		<TR>
			<TD COLSPAN=4 VALIGN=TOP ><FONT SIZE=1 FACE="<%=FontNameHead%>">All Employees trained to request consent.</FONT></TD>
			<BR>
		</TR>
		<TR><TD COLSPAN=5><P STYLE="line-height: 4pt">&nbsp</P></TD></TR>

		<TR>
			<TD WIDTH="5%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">#</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Name</FONT></U></B></TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Title</FONT></U></B></TD>
			<TD WIDTH="25%" ALIGN=center ><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Number of Approaches</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">First Approached</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Last Approached</FONT></U></B></TD>

		<%
		i=1
		DO While NOT RS.EOF

		%>

			<TR>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=i%></FONT></TD>
				
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("PersonName")%></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("Title")%></FONT></TD>
				<%if RS("NumberOfCalls")>0 then%>
					<TD VALIGN=TOP ALIGN=center><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><A target="ReferralSummary" HREF="../referral/summary_A.sls?<%=("Type=2&StartDate=" & RS("FirstCalled") & "&EndDate=" & RS("LastCalled") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & pvOrgID & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralCallerOrganizationID_=_"& pvOrgID &"_AND_ReferralApproachedByPersonID_=_" & RS("PersonID") & "_")%>">
										<%=RS("NumberOfCalls")%>
					</A></FONT></TD>
				<%else%>
					<TD VALIGN=TOP ALIGN=center><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("NumberOfCalls")%></FONT></TD>
				<%end if%>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FirstCalled")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("LastCalled")%></FONT></TD>
			</TR>
<%
		i=i+1
		RS.MoveNext
		Loop
	End Function

	Function NonDesignatedRequestor()
		i = 1
 %>
		<TR><TD COLSPAN=7><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
		<TR><TD COLSPAN=7><P STYLE="line-height: 2pt">&nbsp</P></TD></TR>
		<TR>
			<BR>
			<TD COLSPAN=4 VALIGN=TOP><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Non-Designated Requestors <BR> From <%= ReportSTartDate%> To <%= ReportEndDate %></FONT></B></TD>
		</TR>
		<TR ><TD COLSPAN=4><FONT SIZE=1 FACE="<%=FontNameHead%>">All Employees who have requested consent, but are not Designated Requestors.</FONT></TD>
			<BR>
		</TR>
		<TR><TD COLSPAN=5><P STYLE="line-height: 4pt">&nbsp</P></TD></TR>

		<TR>
			<TD WIDTH="5%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">#</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Name</FONT></U></B></TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Title</FONT></U></B></TD>
			<TD WIDTH="25%" ALIGN=center ><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Number of Approaches</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">First Approached</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Last Approached</FONT></U></B></TD>
		</TR>
		<%

		DO While NOT RS.EOF

		%>
			<TR>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=i%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("PersonName")%></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("Title")%></FONT></TD>
				<%if RS("NumberOfCalls")>0 then%>
									<TD VALIGN=TOP ALIGN=center><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><A target="ReferralSummary" HREF="../referral/summary_A.sls?<%=("Type=2&StartDate=" & RS("FirstCalled") & "&EndDate=" & RS("LastCalled") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & pvOrgID & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralCallerOrganizationID_=_"& pvOrgID &"_AND_ReferralApproachedByPersonID_=_" & RS("PersonID") & "_")%>">
														<%=RS("NumberOfCalls")%>
									</A></FONT></TD>
								<%else%>
									<TD VALIGN=TOP ALIGN=center><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("NumberOfCalls")%></FONT></TD>
				<%end if%>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FirstCalled")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("LastCalled")%></FONT></TD>
			</TR>
		<%
		i=i+1
		RS.MoveNext
		Loop
	End Function

	Function Callers()
		i = 1
		%>
			<TR><TD COLSPAN=7><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
			<TR><TD COLSPAN=7><P STYLE="line-height: 2pt">&nbsp</P></TD></TR>
			<TR>
				<TD COLSPAN=4 VALIGN=TOP><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Callers <BR> From <%= ReportSTartDate%> To <%= ReportEndDate %></FONT></B></TD>
			</TR>
			<TR>
				<TD COLSPAN=4><FONT SIZE=1 FACE="<%=FontNameHead%>">All Employees who have reported a death.</FONT></TD>
			</TR>
			<TR><TD COLSPAN=7><P STYLE="line-height: 2pt">&nbsp</P></TD></TR>
		<TR>
			<TD WIDTH="5%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">#</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Name</FONT></U></B></TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Title</FONT></U></B></TD>
			<TD WIDTH="25%"ALIGN=center ><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Number of Calls</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">First Called</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Last Called</FONT></U></B></TD>

		</TR>

		<%

		DO While NOT RS.EOF

		%>
			<TR>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=i%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("PersonName")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("Title")%></FONT></TD>
				<TD VALIGN=TOP ALIGN=center ><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("NumberOfCalls")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FirstCalled")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("LastCalled")%></FONT></TD>
			</TR>
		<%
		i = i + 1
		RS.MoveNext
		Loop
	End Function

		%>


	</TABLE>

</BODY>
</HTML>

<%
Function FixQueryString(pvIn, pvOut)

	Dim j

	pvOut = ""

	For j=1 TO Len(pvIn)

		If Mid(pvIn,j,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,j,1)
		End If

	Next
	 pvOut = pvOut & ""
End Function

Function DesignatedRequestorByDate()
		i = 1
%>
		<TR><TD COLSPAN=7><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
		<TR><TD COLSPAN=7><P STYLE="line-height: 2pt">&nbsp</P></TD></TR>
		<TR>
			<BR>
			<TD COLSPAN=4 VALIGN=TOP><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Designated Requestors <BR> From <%= ReportSTartDate%> To <%= ReportEndDate %></FONT></B></TD>
		</TR>
		<TR>
			<TD COLSPAN=4 VALIGN=TOP ><FONT SIZE=1 FACE="<%=FontNameHead%>">Employees trained to request consent.</FONT></TD>
			<BR>
		</TR>
		<TR><TD COLSPAN=5><P STYLE="line-height: 4pt">&nbsp</P></TD></TR>

		<TR>
			<TD WIDTH="5%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">#</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Name</FONT></U></B></TD>
			<TD WIDTH="10%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Title</FONT></U></B></TD>
			<TD WIDTH="25%" ALIGN=center ><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Number of Approaches</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">First Approached</FONT></U></B></TD>
			<TD WIDTH="20%"><B><U><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>">Last Approached</FONT></U></B></TD>

		<%
		i=1
		DO While NOT RS.EOF

		%>

			<TR>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=i%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("PersonName")%></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("Title")%></FONT></TD>
				<%if RS("NumberOfCalls")>0 then%>
													<TD VALIGN=TOP ALIGN=center><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><A target="ReferralSummary" HREF="../referral/summary_A.sls?<%=("Type=2&StartDate=" & RS("FirstCalled") & "&EndDate=" & RS("LastCalled") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & pvOrgID & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralCallerOrganizationID_=_"& pvOrgID &"_AND_ReferralApproachedByPersonID_=_" & RS("PersonID") & "_")%>">
																		<%=RS("NumberOfCalls")%>
													</A></FONT></TD>
												<%else%>
													<TD VALIGN=TOP ALIGN=center><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("NumberOfCalls")%></FONT></TD>
				<%end if%>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("FirstCalled")%></FONT></TD>
				<TD VALIGN=TOP><FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=RS("LastCalled")%></FONT></TD>
			</TR>
<%
		i=i+1
		RS.MoveNext
		Loop
	End Function
%>

<script language="JavaScript">

	function doNothing()
	{
	}
</script>