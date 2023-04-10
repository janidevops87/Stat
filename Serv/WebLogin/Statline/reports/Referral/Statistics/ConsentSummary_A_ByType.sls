
<%
Option Explicit

Dim DataWarehouseConn
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim pvType
Dim vTZ
Dim vErrorMsg
Dim vAnd
Dim ErrorReturn
Dim vCurrentColor

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
<title>Consent Summary</title>
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
	vMainTitle = "Consent Summary (By Type)"	
	vTitlePeriod = DateLiteral(pvStartDate)
	vTitleTo = DateLiteral(pvEndDate)
	vTitleTimes = "All Times " & ZoneName(vTZ)
	
%>

	<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->

	<!-- Display Table Header -->

	<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

	<TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">

	<TR>
		<%If pvOrgID <> 0 Then%>
			<TD ALIGN=Left width="29%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Year / Month</B></TD>
		<%Else%>
			<TD ALIGN=Left width="29%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referral Facility</B></TD>
		<%End If%>
		
		<TD ALIGN=Left width="8%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		<TD ALIGN=Left width="8%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		<TD ALIGN=Left width="13%" colspan=2 valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		
		<TD ALIGN=Left width="24%" colspan=4 valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Designated Requester</B></TD>
		<TD ALIGN=Left width="18%" colspan=4 valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Other Requester</B></TD>	

	<TR>
		<TD ALIGN=Left width="29%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
		
		<TD ALIGN=Left width="8%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
		<TD ALIGN=Left width="8%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Apprchd</B></TD>
		<TD ALIGN=Left width="13%" colspan=2 valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Consented</B></TD>
		
		<TD ALIGN=Left COLSPAN=2 width="10%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>">Approached</TD>
		<TD ALIGN=Left COLSPAN=2 width="14%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>">Consented</TD>
		
		<TD ALIGN=Left COLSPAN=2 width="10%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>">Approached</TD>
		<TD ALIGN=Left COLSPAN=2 width="8%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>">Consented</TD>
		
	<TR><TD COLSPAN=13><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

<%
	vCurrentColor = "bgcolor=#FFFFFF"
	
	'Get the list of organizations to be processed	
	vQuery = "sps_ConsentSummary_A " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID

	Set RS = DataWarehouseConn.Execute(vQuery)

	Do While Not RS.EOF
%>
<!-- Row #1 - All Types -->
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
			
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><B><%=RS("AllTypes")%></B></I></FONT></TD>
			<%vTotals(0) = vTotals(0) + RS("AllTypes")%>
			
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=RS("A_TotalApproached")%></B></FONT></TD>
			<%vTotals(1) = vTotals(1) + RS("A_TotalApproached")%>
						
			<%
			vTotals(4) = vTotals(4) + RS("A_TotalConsented")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=RS("A_TotalConsented")%></B></FONT></TD>
			<%If RS("A_TotalApproached") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=FormatNumber((RS("A_TotalConsented")/RS("A_TotalApproached"))*100,0)%>%</B></FONT></I></TD>
			<%End If%>
									
	<!-- Detail -->
			<%
			vTotals(2) = vTotals(2) + RS("A_Approach_DR")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=RS("A_Approach_DR")%></B></FONT></TD>
			<%If RS("A_TotalApproached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=FormatNumber((RS("A_Approach_DR")/RS("A_TotalApproached"))*100,0)%>%</B></FONT></I></TD>
			<%End If%>
				
			<%
			vTotals(5) = vTotals(5) + RS("A_Consent_DR")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=RS("A_Consent_DR")%></B></FONT></TD>
			<%If RS("A_Approach_DR") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=FormatNumber((RS("A_Consent_DR")/RS("A_Approach_DR"))*100,0)%>%</B></FONT></I></TD>
			<%End If%>
							
			<%
			vTotals(3) = vTotals(3) + RS("A_Approach_NonDR")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=RS("A_Approach_NonDR")%></B></FONT></TD>
			<%If RS("A_TotalApproached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=FormatNumber((RS("A_Approach_NonDR")/RS("A_TotalApproached"))*100,0)%>%</B></FONT></I></TD>
			<%End If%>
					
			<%
			vTotals(6) = vTotals(6) + RS("A_Consent_NonDR")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=RS("A_Consent_NonDR")%></B></FONT></TD>
			<%If RS("A_Approach_NonDR") = 0 Then%>
				<TD width="5%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></I></FONT></TD>			
			<%Else%>			
				<TD width="5%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=FormatNumber((RS("A_Consent_NonDR")/RS("A_Approach_NonDR"))*100,0)%>%</B></I></FONT></TD>
			<%End If%>
														
		</TR>
			
<!-- Row #2 - Organs -->
		<TR>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Organs</I></FONT></TD>
			
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("O_TotalApproached")%></FONT></TD>
			<%vTotals(7) = vTotals(7) + RS("O_TotalApproached")%>
				
			<%
			vTotals(10) = vTotals(10) + RS("O_TotalConsented")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("O_TotalConsented")%></FONT></TD>
			<%If RS("O_TotalApproached") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("O_TotalConsented")/RS("O_TotalApproached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
							
			<!-- Detail -->
			<%
			vTotals(8) = vTotals(8) + RS("O_Approach_DR")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("O_Approach_DR")%></FONT></TD>
			<%If RS("O_TotalApproached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("O_Approach_DR")/RS("O_TotalApproached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
				
			<%
			vTotals(11) = vTotals(11) + RS("O_Consent_DR")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("O_Consent_DR")%></FONT></TD>
			<%If RS("O_Approach_DR") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("O_Consent_DR")/RS("O_Approach_DR"))*100,0)%>%</FONT></I></TD>
			<%End If%>
							
			<%
			vTotals(9) = vTotals(9) + RS("O_Approach_NonDR")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("O_Approach_NonDR")%></FONT></TD>
			<%If RS("O_TotalApproached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("O_Approach_NonDR")/RS("O_TotalApproached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
									
			<%
			vTotals(12) = vTotals(12) + RS("O_Consent_NonDR")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("O_Consent_NonDR")%></FONT></TD>
			<%If RS("O_Approach_NonDR") = 0 Then%>
				<TD width="5%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="5%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("O_Consent_NonDR")/RS("O_Approach_NonDR"))*100,0)%>%</FONT></I></TD>
			<%End If%>
														
		</TR>
			
<!-- Row #3 - Tissues -->
		<TR>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Tissues</I></FONT></TD>
			
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("T_TotalApproached")%></FONT></TD>
			<%vTotals(13) = vTotals(13) + RS("T_TotalApproached")%>
				
			<%
			vTotals(16) = vTotals(16) + RS("T_TotalConsented")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("T_TotalConsented")%></FONT></TD>
			<%If RS("T_TotalApproached") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("T_TotalConsented")/RS("T_TotalApproached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
							
			<!-- Detail -->
			<%
			vTotals(14) = vTotals(14) + RS("T_Approach_DR")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("T_Approach_DR")%></FONT></TD>
			<%If RS("T_TotalApproached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("T_Approach_DR")/RS("T_TotalApproached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
				
			<%
			vTotals(17) = vTotals(17) + RS("T_Consent_DR")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("T_Consent_DR")%></FONT></TD>
			<%If RS("T_Approach_DR") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("T_Consent_DR")/RS("T_Approach_DR"))*100,0)%>%</FONT></I></TD>
			<%End If%>
							
			<%
			vTotals(15) = vTotals(15) + RS("T_Approach_NonDR")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("T_Approach_NonDR")%></FONT></TD>
			<%If RS("T_TotalApproached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("T_Approach_NonDR")/RS("T_TotalApproached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
				
			<%
			vTotals(18) = vTotals(18) + RS("T_Consent_NonDR")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("T_Consent_NonDR")%></FONT></TD>
			<%If RS("T_Approach_NonDR") = 0 Then%>
				<TD width="5%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="5%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("T_Consent_NonDR")/RS("T_Approach_NonDR"))*100,0)%>%</FONT></I></TD>
			<%End If%>
														
		</TR>
		
<!-- Row #4 - Eyes -->
		<TR>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Eyes</I></FONT></TD>
			
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("E_TotalApproached")%></FONT></TD>
			<%vTotals(19) = vTotals(19) + RS("E_TotalApproached")%>
				
			<%
			vTotals(22) = vTotals(22) + RS("E_TotalConsented")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("E_TotalConsented")%></FONT></TD>
			<%If RS("E_TotalApproached") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("E_TotalConsented")/RS("E_TotalApproached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
							
			<!-- Detail -->
			<%
			vTotals(20) = vTotals(20) + RS("E_Approach_DR")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("E_Approach_DR")%></FONT></TD>
			<%If RS("E_TotalApproached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("E_Approach_DR")/RS("E_TotalApproached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
				
			<%
			vTotals(23) = vTotals(23) + RS("E_Consent_DR")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("E_Consent_DR")%></FONT></TD>
			<%If RS("E_Approach_DR") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("E_Consent_DR")/RS("E_Approach_DR"))*100,0)%>%</FONT></I></TD>
			<%End If%>
							
			<%
			vTotals(21) = vTotals(21) + RS("E_Approach_NonDR")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("E_Approach_NonDR")%></FONT></TD>
			<%If RS("E_TotalApproached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("E_Approach_NonDR")/RS("E_TotalApproached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
									
			<%
			vTotals(24) = vTotals(24) + RS("E_Consent_NonDR")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("E_Consent_NonDR")%></FONT></TD>
			<%If RS("E_Approach_NonDR") = 0 Then%>
				<TD width="5%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="5%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("E_Consent_NonDR")/RS("E_Approach_NonDR"))*100,0)%>%</FONT></I></TD>
			<%End If%>
														
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
	<TR><TD COLSPAN=13><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

<!-- Row #1 All Totals -->	
	<TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
		
		<!-- Totals -->
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(4)%></B></FONT></TD>
		<%If vTotals(1) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(4)/vTotals(1))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
				
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(2)%></B></FONT></TD>
		<%If vTotals(1) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(2)/vTotals(1))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
		
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(5)%></B></FONT></TD>
		<%If vTotals(2) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(5)/vTotals(2))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
				
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(3)%></B></FONT></TD>
		<%If vTotals(1) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(3)/vTotals(1))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
						
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(6)%></B></FONT></TD>
		<%If vTotals(3) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(6)/vTotals(3))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
		
	</TR>

<!-- Row #2 Organ Totals -->
	<TR><TD></TD>	
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Organs</I></FONT></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(7)%></I></FONT></TD>
		
		<!-- Totals -->
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(10)%></I></FONT></TD>
		<%If vTotals(7) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(10)/vTotals(7))*100,0)%>%</I></FONT></TD>		
		<%End If%>
				
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(8)%></I></FONT></TD>
		<%If vTotals(7) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(8)/vTotals(7))*100,0)%>%</I></FONT></TD>		
		<%End If%>
		
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(11)%></I></FONT></TD>
		<%If vTotals(8) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(11)/vTotals(8))*100,0)%>%</I></FONT></TD>		
		<%End If%>
				
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(9)%></I></FONT></TD>
		<%If vTotals(7) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(9)/vTotals(7))*100,0)%>%</I></FONT></TD>		
		<%End If%>
						
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(12)%></I></FONT></TD>
		<%If vTotals(9) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(12)/vTotals(9))*100,0)%>%</I></FONT></TD>		
		<%End If%>

	</TR>

<!-- Row #3 Tissue Totals -->
	<TR><TD></TD>	
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Tissues</I></FONT></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(13)%></I></FONT></TD>
		
		<!-- Totals -->
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(16)%></I></FONT></TD>
		<%If vTotals(13) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(16)/vTotals(13))*100,0)%>%</I></FONT></TD>		
		<%End If%>
				
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(14)%></I></FONT></TD>
		<%If vTotals(13) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(14)/vTotals(13))*100,0)%>%</I></FONT></TD>		
		<%End If%>
		
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(17)%></I></FONT></TD>
		<%If vTotals(14) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(17)/vTotals(14))*100,0)%>%</I></FONT></TD>		
		<%End If%>
				
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(15)%></I></FONT></TD>
		<%If vTotals(13) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(15)/vTotals(13))*100,0)%>%</I></FONT></TD>		
		<%End If%>
						
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(18)%></I></FONT></TD>
		<%If vTotals(15) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(18)/vTotals(15))*100,0)%>%</I></FONT></TD>		
		<%End If%>

	</TR>
		
<!-- Row #4 Eye Totals -->
	<TR>
		<TD></TD>	
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Eyes</I></FONT></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(19)%></I></FONT></TD>
		
		<!-- Totals -->
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(22)%></I></FONT></TD>
		<%If vTotals(19) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(22)/vTotals(19))*100,0)%>%</I></FONT></TD>		
		<%End If%>
				
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(20)%></I></FONT></TD>
		<%If vTotals(19) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(20)/vTotals(19))*100,0)%>%</I></FONT></TD>		
		<%End If%>
		
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(23)%></I></FONT></TD>
		<%If vTotals(20) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(23)/vTotals(20))*100,0)%>%</I></FONT></TD>		
		<%End If%>
				
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(21)%></I></FONT></TD>
		<%If vTotals(19) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>		
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(21)/vTotals(19))*100,0)%>%</I></FONT></TD>		
		<%End If%>
						
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(24)%></I></FONT></TD>
		<%If vTotals(21) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(24)/vTotals(21))*100,0)%>%</I></FONT></TD>		
		<%End If%>
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