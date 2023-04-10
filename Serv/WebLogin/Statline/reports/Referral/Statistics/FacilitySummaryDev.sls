
<%Option Explicit%>

<%
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim vTZ
Dim vErrorMsg
Dim vAnd
Dim ErrorReturn

Dim vQuery1
Dim vQuery2
Dim vQuery3
Dim vQuery4
Dim vQuery5
Dim vQuery6

Dim RS0
Dim pvRowOrg

Dim vTotals(24)
Dim x


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
<title>Referral Statistics - Facility Summary</title>
</head>
<body bgcolor="antiquewhite">



<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 

<%'Execute the main page generating routine
If AuthorizeMain Then
%>

	<%
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	%>

<%
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
			
			vReportTitle = RS("WebReportGroupName")
						
		End If
		
		Set RS = Nothing
		
	ElseIf pvOrgID <> 0  Then

		'Else if a single organization has been selected, get the organization data 
		'and set the report title to the name of the selected organization

		'Get the organization information
		vQuery = "sps_OrganizationName " & pvUserOrgID
		
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
	vMainTitle = "Facility Summary"
	vTitlePeriod = pvStartDate
	vTitleTo = pvEndDate
	vTitleTimes = "All Times " & ZoneName(vTZ)
	
	
%>

	<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->

	<!-- Display Table Header -->

	<TABLE BORDER=0 WIDTH="100%">
	<TR><TD COLSPAN=40><IMG SRC="/loginstatline/images/redline.jpg" HEIGHT=2 WIDTH="100%"></TD></TR>


	<TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referral Facility</B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B># of Total</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD COLSPAN=6 ALIGN=LEFT><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Appropriate</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD COLSPAN=6 ALIGN=LEFT><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Approach</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD COLSPAN=6 ALIGN=LEFT><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Consent</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD COLSPAN=6 ALIGN=LEFT><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Recovery</B></TD></TR>

	<TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp &nbsp &nbsp &nbsp</B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>O</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>B</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>ST</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>SK</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>HV</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>E</B></TD>
		
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>O</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>B</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>ST</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>SK</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>HV</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>E</B></TD>

		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>O</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>B</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>ST</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>SK</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>HV</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>E</B></TD>

		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>O</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>B</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>ST</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>SK</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>HV</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>E</B></TD></TR>

	<TR><TD COLSPAN=40><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

<%
	'Adjust the start and end time for the user's time zone.
	Call AdjustTimeZone(pvStartDate, vTZ)
	Call AdjustTimeZone(pvEndDate, vTZ)
	
	
	'A report group has been selected so get the list of organizations
	'to be processed
	vQuery = "sps_ReferralCountOrganizations " & pvReportGroupID & ", " & pvOrgID & ", '" & pvStartDate & "', '" & pvEndDate & "'"
	Set RS0 = Conn.Execute(vQuery)

	If RS0.EOF <> True Then

		Do Until RS0.EOF = True

			pvRowOrg = RS0("ReferralCallerOrganizationID")
						
			vAnd = "_AND_ReferralCallerOrganizationID_=_" & pvRowOrg & "_" 
			
	%>
			<TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS0("OrganizationName")%></TD>
				<TD ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>
				<A target="ReferralSummary" HREF="../summary.sls?<%=Request.QueryString%>&NoLog=1&AND=<%=vAnd%>">
				<%=RS0("ReferralCount")%></A></I>
				</TD>
				<TD>&nbsp</TD>
				<TD>&nbsp</TD>

	<%
				vTotals(0) = vTotals(0) + RS0("ReferralCount")
	%>

	<!-- Appropriate -->
				<%
				vQuery = "sps_ReferralCountAppropriate " & pvReportGroupID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "'"
				Set RS = Conn.Execute(vQuery)
				vTotals(1) = vTotals(1) + RS("ReferralCount")
				%>			
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>

				<%			
				RS.MoveNext
				vTotals(2) = vTotals(2) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>

				<%
				RS.MoveNext
				vTotals(3) = vTotals(3) + RS("ReferralCount")			
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(4) = vTotals(4) + RS("ReferralCount")			
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
							
				<%
				RS.MoveNext
				vTotals(5) = vTotals(5) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(6) = vTotals(6) + RS("ReferralCount")			
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>

				
				
	<!-- Approach  -->
				<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>
				<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>	
				
				<%
				vQuery = "sps_ReferralCountApproach " & pvReportGroupID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "'"
				Set RS = Conn.Execute(vQuery)
				vTotals(7) = vTotals(7) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(8) = vTotals(8) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(9) = vTotals(9) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(10) = vTotals(10) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(11) = vTotals(11) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(12) = vTotals(12) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>




	<!-- Consent  -->
				<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>
				<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>	

				<%
				vQuery = "sps_ReferralCountConsent " & pvReportGroupID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "'"
				Set RS = Conn.Execute(vQuery)
				vTotals(13) = vTotals(13) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(14) = vTotals(14) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(15) = vTotals(15) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(16) = vTotals(16) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(17) = vTotals(17) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(18) = vTotals(18) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				



	<!-- Recovery  -->
				<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>
				<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>	

				<%
				vQuery = "sps_ReferralCountRecovery " & pvReportGroupID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "'"
				Set RS = Conn.Execute(vQuery)
				vTotals(19) = vTotals(19) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(20) = vTotals(20) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(21) = vTotals(21) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(22) = vTotals(22) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%		
				RS.MoveNext
				vTotals(23) = vTotals(23) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
				
				<%
				RS.MoveNext
				vTotals(24) = vTotals(24) + RS("ReferralCount")
				%>
				<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>

			</TR>
		
		<%
		RS0.MoveNext
		
		Loop
	End If
	%>

	<!-- Process Totals -->
	<TR><TD COLSPAN=40><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

	<TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
		<TD ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></TD>
		<TD>&nbsp</TD>
		<TD>&nbsp</TD>
		<!-- Appropriate Totals -->
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(2)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(3)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(4)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(5)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(6)%></B></TD>
		<!-- Approach Totals -->
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>	
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(7)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(8)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(9)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(10)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(11)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(12)%></B></TD>
		<!-- Consent Totals -->
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>	
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(13)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(14)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(15)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(16)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(17)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(18)%></B></TD>
		<!-- Recovery Totals -->
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>	
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(19)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(20)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(21)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(22)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(23)%></B></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(24)%></B></TD>
	</TR>

<%
End If
Set RS0 = Nothing
Set RS = Nothing
Set Conn = Nothing
%>

<!--#include virtual="/loginstatline/includes/copyright.shm"-->
</body>
</html>


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

Sub AdjustTimeZone(pvDateTime, pvTZ)

    Select Case pvTZ
        Case "PT"
            pvDateTime = DateAdd("h", 1, pvDateTime)
        Case "MT"
            pvDateTime = DateAdd("h", 0, pvDateTime)
        Case "CT"
            pvDateTime = DateAdd("h", -1, pvDateTime)
        Case "ET"
            pvDateTime = DateAdd("h", -2, pvDateTime)
    End Select

End Sub

%>