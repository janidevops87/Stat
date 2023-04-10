
<%Option Explicit%>

<%
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim pvReferralTypeID
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
Dim RS1
Dim RS2
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
<title>Referral Statistics - Facility Summary</title>
</head>
<body bgcolor="#F5EBDD">



<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 

<%'Execute the main page generating routine
If AuthorizeMain Then


	'Set Title Values	
	vMainTitle = "Call Count Summary"
	vTitlePeriod = FormatDateTime(pvStartDate, vbShortDate) & " " & FormatDateTime(pvStartDate, vbShortTime)
	vTitleTo = FormatDateTime(pvEndDate, vbShortDate) & " " & FormatDateTime(pvEndDate, vbShortTime)
	vTitleTimes = "All Times Mountain Time"

%>
	<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->


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
	pvReferralTypeID = FormatNumber(Request.QueryString("ReferralType"),0,,0,0)	

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
			Response.Write(vErrorMsg)
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
	<!-- Display Table Header -->
	<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->



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
	
	
	If pvOrgID <> 0 Then
	
		'If  only one organization is selected, then only process one row
		pvRowOrg = pvOrgID
		Call ProcessRow()
		
	Else
		'A report group has been selected so get the list of organizations
		'to be processed
		vQuery = "sps_ReportGroupOrgs " & pvReportGroupID & " "
		Set RS0 = Conn.Execute(vQuery)

		If RS0.EOF <> True Then
			Do Until RS0.EOF = True
				pvRowOrg = RS0("OrganizationID")
				Call ProcessRow()
				RS0.MoveNext
			Loop
		End If
		
		Set RS0 = Nothing
		
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
</TABLE>


<%
End If

Set Conn = Nothing
%>


<!--#include virtual="/loginstatline/includes/copyright.shm"-->
</body>
</html>



<%
Sub ProcessRow()

		vQuery1 = "sps_OrganizationName " & pvRowOrg & " "
		Set RS1 = Conn.Execute(vQuery1)
			
		'An individual organization has been selected
		vQuery2 = "sps_OrgReferralTotal " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
		Set RS2 = Conn.Execute(vQuery2)
		
		
		'If there are no referrals for the organization do not
		'display the row
		If RS2("ReferralCount") = 0 Then
			Exit Sub
		End If
		
		vAnd = "_AND_ReferralCallerOrganizationID_=_" & pvRowOrg & "_" 
		
%>
		<TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS1("OrganizationName")%></TD>
			<TD ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>
			<A target="ReferralSummary" HREF="../summary_A.sls?<%=Request.QueryString%>&NoLog=1&AND=<%=vAnd%>">
			<%=RS2("ReferralCount")%></A></I>
			</TD>
			<TD>&nbsp</TD>
			<TD>&nbsp</TD>

<%
			vTotals(0) = vTotals(0) + RS2("ReferralCount")
			Set RS1 = Nothing
			Set RS2 = Nothing
%>


			<!-- Appropriate Totals -->
			<%
			vQuery1 = "sps_AppropTotalOrgan " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery1)
			vTotals(1) = vTotals(1) + RS("ReferralCount")
			%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>

			<%			
			Set RS = Nothing
			vQuery2 = "sps_AppropTotalBone " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery2)
			vTotals(2) = vTotals(2) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>

			<%
			Set RS = Nothing
			vQuery3 = "sps_AppropTotalTissue " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery3)
			vTotals(3) = vTotals(3) + RS("ReferralCount")			
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery4 = "sps_AppropTotalSkin " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery4)
			vTotals(4) = vTotals(4) + RS("ReferralCount")			
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
						
			<%
			Set RS = Nothing
			vQuery5 = "sps_AppropTotalValves " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery5)
			vTotals(5) = vTotals(5) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery6 = "sps_AppropTotalEyes " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery6)
			vTotals(6) = vTotals(6) + RS("ReferralCount")			
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>

			
			
			<!-- Approach Totals -->
			<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>
			<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>	
			
			<%
			Set RS = Nothing
			vQuery1 = "sps_ApprchTotalOrgan " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery1)
			vTotals(7) = vTotals(7) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery2 = "sps_ApprchTotalBone " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery2)
			vTotals(8) = vTotals(8) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery3 = "sps_ApprchTotalTissue " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery3)
			vTotals(9) = vTotals(9) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery4 = "sps_ApprchTotalSkin " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery4)
			vTotals(10) = vTotals(10) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery5 = "sps_ApprchTotalValves " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery5)
			vTotals(11) = vTotals(11) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery6 = "sps_ApprchTotalEyes " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery6)
			vTotals(12) = vTotals(12) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>




			<!-- Consent Totals -->
			<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>
			<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>	

			<%
			Set RS = Nothing
			vQuery1 = "sps_ConsentTotalOrgan " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery1)
			vTotals(13) = vTotals(13) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery2 = "sps_ConsentTotalBone " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery2)
			vTotals(14) = vTotals(14) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery3 = "sps_ConsentTotalTissue " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery3)
			vTotals(15) = vTotals(15) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery4 = "sps_ConsentTotalSkin " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery4)
			vTotals(16) = vTotals(16) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery5 = "sps_ConsentTotalValves " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery5)
			vTotals(17) = vTotals(17) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery6 = "sps_ConsentTotalEyes " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery6)
			vTotals(18) = vTotals(18) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			



			<!-- Recovery Totals -->
			<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>
			<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>	

			<%
			Set RS = Nothing
			vQuery1 = "sps_RecoverTotalOrgan " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery1)
			vTotals(19) = vTotals(19) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery2 = "sps_RecoverTotalBone " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery2)
			vTotals(20) = vTotals(20) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery3 = "sps_RecoverTotalTissue " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery3)
			vTotals(21) = vTotals(21) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery4 = "sps_RecoverTotalSkin " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery4)
			vTotals(22) = vTotals(22) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%		
			Set RS = Nothing	
			vQuery5 = "sps_RecoverTotalValves " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery5)
			vTotals(23) = vTotals(23) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>
			
			<%
			Set RS = Nothing
			vQuery6 = "sps_RecoverTotalEyes " & pvUserOrgID & ", " & pvRowOrg & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvReferralTypeID
			Set RS = Conn.Execute(vQuery6)
			vTotals(24) = vTotals(24) + RS("ReferralCount")
			%>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ReferralCount")%></TD>

		</TR>
<%
End Sub
%>


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