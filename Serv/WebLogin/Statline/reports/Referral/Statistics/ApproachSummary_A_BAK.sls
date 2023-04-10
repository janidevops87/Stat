
<%
Option Explicit

Dim DataWarehouseConn
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim vTZ
Dim vErrorMsg
Dim vAnd
Dim ErrorReturn
Dim vCurrentColor

Dim vTotals(5)
Dim x

Dim pvNewQueryString
Dim pvTempQueryString
Dim pvTempStartDate
Dim pvTempEndDate

Dim FontNameHead
Dim FontNameData
Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

FontNameHead = "Arial"
FontNameData = "Times New Roman"

%>

<html>
<head>
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Approach Summary A</title>
</head>
<body bgcolor="#F5EBDD">

<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 

<%
Call Process

Function Process

'Execute the main page generating routine
If AuthorizeMain Then

	Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD	'drh 1/6/04 - Un-hardcoded DSN
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)

	'Verify the requesting organization if it not Statline
	If pvUserOrgID <> 194 then
		
		vQuery = "sps_OrganizationName " & pvUserOrgID
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)		
		End If
		
		Set RS = Nothing
	
	Else
	
		'If the user org = 194 and a report group has been selected,
		'the replace the user org id with the org owner of the 
		'selected report group.
		If pvReportGroupID <> 0 Then
			vQuery = "sps_ReportGroupOrgParentID " & pvReportGroupID & " "
			Set RS = Conn.Execute(vQuery)
			If RS.EOF <> True Then
				pvUserOrgID = RS("OrgHierarchyParentID")
				vReportTitle = RS("OrganizationName") & " - "
			End If
			Set RS = Nothing
		End If		

	End If

	If pvReportGroupID <> 0 AND pvOrgID = 0 Then
		
		'If a report group has been selected, get the report group name
		'and set the report title to the name of the report group
		vQuery = "sps_ReportGroupName " & pvReportGroupID & " "
		Set RS = Conn.Execute(vQuery)

		If Conn.Errors.Count > 0 Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
			vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
		End If
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The selected report group is no longer valid. Please select another group.<BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			
		Else
			vReportTitle = vReportTitle & RS("WebReportGroupName")		
		End If
		
		Set RS = Nothing
		
	ElseIf pvOrgID <> 0  Then

		'Else if a single organization has been selected, get the organization data 
		'and set the report title to the name of the selected organization

		'Get the organization information
		vQuery = "sps_OrganizationName " & pvOrgID
		
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization selected for this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Else
			vReportTitle = RS("OrganizationName")			
		End If
		
		Set RS = Nothing
		
	ElseIf pvOrgID = 0 AND pvReportGroupID = 0 Then

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
		vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, UnitSummary.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)

	Else

		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "Unexpected Error. <BR> "
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, UnitSummary.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)

	End if

	vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing
	
	'Set Title Values	
	vMainTitle = "Approach Summary (All Types)"
	vTitlePeriod = DateLiteral(pvStartDate)
	vTitleTo = DateLiteral(pvEndDate)
	vTitleTimes = "All Times " & ZoneName(vTZ)
	
	'Rebuild querystring
	pvTempQueryString = "ReportGroupID=" & Request.Querystring("ReportGroupID") & "&"
	pvTempQueryString = pvTempQueryString & "OrgID=" & Request.Querystring("OrgID") & "&"
	pvTempQueryString = pvTempQueryString & "UserID=" & Request.Querystring("UserID") & "&"
	pvTempQueryString = pvTempQueryString & "UserOrgID=" & Request.Querystring("UserOrgID") & "&"
	pvTempQueryString = pvTempQueryString & "DSN=" & Request.Querystring("DSN") & "&"
	pvTempQueryString = pvTempQueryString & "Options=" & Request.Querystring("Options") & "&"
	pvTempQueryString = pvTempQueryString & "BreakOnOrgID=" & Request.Querystring("BreakOnOrgID") & "&"
	pvTempQueryString = pvTempQueryString & "ReportID=" & Request.Querystring("ReportID") & "&"	
	
	pvTempStartDate = Request.Querystring("StartDate")
	
	'Trim off the time
	pvTempStartDate = mid(pvTempStartDate,1, len(pvTempStartDate)-6)

%>
	<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->

	<!-- Display Table Header -->

	<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

	<TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">

	<TR>
		<%If pvOrgID <> 0 Then%>
			<TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Year / Month</B></TD>
		<%Else%>
			<TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referral Facility</B></TD>
		<%End If%>
		
		<TD ALIGN=Left width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		<TD ALIGN=Left width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		
		<TD ALIGN=Left width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
		<TD ALIGN=Left width="8%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
		<TD ALIGN=Left width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
		<TD ALIGN=Left width="8%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
		<TD ALIGN=Left width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
		<TD ALIGN=Left width="12%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
		
		<TD ALIGN=Left width="8%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Unknown</B></TD>
		
	<TR><TD ALIGN=Left width="30%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
		<TD ALIGN=Left width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Approached</B></TD>

		<TD ALIGN=Left COLSPAN=2 width="13%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Pre-Referral</TD>
		<TD ALIGN=Left COLSPAN=2 width="13%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Post Referral</TD>
		<TD ALIGN=Left COLSPAN=2 width="17%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Family Initiated</TD>
		
		<TD ALIGN=Left width="8%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Approach</B></TD>
		
	<TR><TD COLSPAN=10><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

<%
	vCurrentColor = "bgcolor=#FFFFFF"
	
	'A report group has been selected so get the list of organizations
	'to be processed
	vQuery = "sps_ApproachSummary_A " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
	'Print vQuery	
	Set RS = DataWarehouseConn.Execute(vQuery)
	
	Do While Not RS.EOF
		
		pvNewQueryString = pvTempQueryString
		
		if pvTempStartDate < pvEndDate Then
			
			pvTempEndDate = Month(pvTempStartDate) & "/" & CalculateDaysInMonth(pvTempStartDate) & "/" & Year(pvTempStartDate) & "_23:59"
		
			pvNewQueryString = pvNewQueryString & "StartDate=" & pvTempStartDate & "_00:00" & "&"
			pvNewQueryString = pvNewQueryString & "EndDate=" & pvTempEndDate & "&"
			
			pvTempStartDate = DateAdd("m", 1, pvTempStartDate)
		End If		
		
		vAnd = "_AND_ReferralCallerOrganizationID_=_" & RS("OrganizationID") & "_" 
			
%>
		<TR>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">
				<%
				If pvOrgID <> 0 Then
					Response.Write(RS("MonthYear"))
				Else
					Response.Write(RS("OrganizationName"))
				End If	
				%>	
			</TD>
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=RS("AllTypes")%></I></FONT></TD>
<%
			vTotals(0) = vTotals(0) + RS("AllTypes")
%>
	<!-- Approach Types -->
			<%
			vTotals(1) = vTotals(1) + RS("TotalApproached")
			%>			
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("TotalApproached")%></FONT></TD>
	
			<%
			' Pre Facility
			vTotals(2) = vTotals(2) + RS("PreRefFacilityApproach")
			vAnd = "_AND_ReferralCallerOrganizationID_=_" & RS("OrganizationID") & "_" & "AND_ReferralApproachTypeID_IN_(2,3)_" 
			%>			
			<TD <%=vCurrentColor%>>
				<FONT SIZE="1" FACE="<%=FontNameHead%>">
						
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=pvNewQueryString%>&NoLog=1&AND=<%=vAnd%>">			
							<%=RS("PreRefFacilityApproach")%>
						</A>							
				
				</FONT>
			</TD>
			<TD <%=vCurrentColor%>>
				<I>
					<FONT SIZE="1" FACE="<%=FontNameHead%>">
						<%If RS("TotalApproached") = 0 Then%>
							0%			
						<%Else%>
							<%=FormatNumber((RS("PreRefFacilityApproach")/RS("TotalApproached"))*100,0)%>%
						<%End If%>
					</FONT>
				</I>
			</TD>
			<%	
			'Post Facility
			vTotals(3) = vTotals(3) + RS("PostRefApproach")
			vAnd = "_AND_ReferralCallerOrganizationID_=_" & RS("OrganizationID") & "_" & "AND_ReferralApproachTypeID_IN_(4,5)_" 
			%>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">

						<A target="ReferralSummary" HREF="../summary_A.sls?<%=pvNewQueryString%>&NoLog=1&AND=<%=vAnd%>">			
							<%=RS("PostRefApproach")%>
						</A>							

				</A></FONT>
			</TD>
			<TD <%=vCurrentColor%>>
				<I>
					<FONT SIZE="1" FACE="<%=FontNameHead%>">
						<%If RS("TotalApproached") = 0 Then%>
							0%
						<%Else%>			
							<%=FormatNumber((RS("PostRefApproach")/RS("TotalApproached"))*100,0)%>%
						<%End If%>
					</FONT>
				</I>
			</TD>			
			
			<%
			'Family Approach
			vTotals(4) = vTotals(4) + RS("PreRefFamilyApproach")
			vAnd = "_AND_ReferralCallerOrganizationID_=_" & RS("OrganizationID") & "_" & "AND_ReferralApproachTypeID_IN_(6)_" 
			%>
			<TD <%=vCurrentColor%>>
				<FONT SIZE="1" FACE="<%=FontNameHead%>">

						<A target="ReferralSummary" HREF="../summary_A.sls?<%=pvNewQueryString%>&NoLog=1&AND=<%=vAnd%>">			
							<%=RS("PreRefFamilyApproach")%>
						</A>							

				</FONT>
			</TD>
			<TD <%=vCurrentColor%>>
				<I>
					<FONT SIZE="1" FACE="<%=FontNameHead%>">
						<%If RS("TotalApproached") = 0 Then%>
							0%
						<%Else%>			
							<%=FormatNumber((RS("PreRefFamilyApproach")/RS("TotalApproached"))*100,0)%>%
						<%End If%>
					</FONT>
				</I>
			</TD>			
				
			<%
			'UNKNOWN APPROACH
			
			vTotals(5) = vTotals(5) + RS("UnknownApproach")			
			vAnd = "_AND_ReferralCallerOrganizationID_=_" & RS("OrganizationID") & "_" & "AND_ReferralApproachTypeID_IN_(7,-1)_" 
			%>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">

				<A target="ReferralSummary" HREF="../summary_A.sls?<%=pvNewQueryString%>&NoLog=1&AND=<%=vAnd%>">			
					<%=RS("UnknownApproach")%></A></FONT></TD>
				</A>							
			
		</TR>
			
	<%
		If vCurrentColor = "bgcolor=#FFFFFF" Then
			vCurrentColor = "bgcolor=#F5EBDD"
		Else
			vCurrentColor = "bgcolor=#FFFFFF"
		End If
			
		RS.MoveNext
		
	Loop
	%>

	<!-- Process Totals -->
	<TR><TD COLSPAN=10><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

	<TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
		<!-- Approach Totals -->
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(2)%></B></FONT></TD>
		<%If vTotals(1) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(2)/vTotals(1))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(3)%></B></FONT></TD>
		<%If vTotals(1) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(3)/vTotals(1))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(4)%></B></FONT></TD>
		<%If vTotals(1) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(4)/vTotals(1))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(5)%></B></FONT></TD>
	</TR>

	</TABLE>
<%
End If

Set RS = Nothing
Set Conn = Nothing
Set DataWarehouseConn = Nothing

End Function
%>

<!--#include virtual="/loginstatline/includes/copyright.shm"-->
</body>
</html>


<%
Function DateLiteral(pvDate)

	Select Case Month(pvDate)
	
		Case 1
			DateLiteral = "Jan "
		Case 2
			DateLiteral = "Feb "
		Case 3
			DateLiteral = "March "
		Case 4
			DateLiteral = "April "
		Case 5
			DateLiteral = "May "
		Case 6
			DateLiteral = "June "
		Case 7
			DateLiteral = "July "
		Case 8
			DateLiteral = "Aug "
		Case 9
			DateLiteral = "Sept "
		Case 10
			DateLiteral = "Oct "
		Case 11
			DateLiteral = "Nov "
		Case 12
			DateLiteral = "Dec "
	End Select
	
	DateLiteral = DateLiteral & Year(pvDate)
	
End Function

Function CalculateDaysInMonth(pvDate)
	
	Dim pvIsLeapYear
	Dim vTempYear
	
	vTempYear = year(pvDate)
	
	pvIsLeapYear = ((vTempYear Mod 4 = 0) _
				     		    And (vTempYear Mod 100 <> 0) _
				    			Or (vTempYear Mod 400 = 0))	
	
	Select Case Month(pvDate)
	
		Case 2
			if pvIsLeapYear = True Then
				
				CalculateDaysInMonth = 29
			Else
			
				CalculateDaysInMonth = 28
			end if
		Case 4, 6, 9, 11
			CalculateDaysInMonth = 30
		Case Else
			CalculateDaysInMonth = 31
	End Select	
End Function

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