
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
	vMainTitle = "Consent Summary (By Type - w/Reg)"
	vTitlePeriod = DateLiteral(pvStartDate)
	vTitleTo = DateLiteral(pvEndDate)
	vTitleTimes = "All Times " & ZoneName(vTZ)
	
	
%>
	<!-- Display Table Header -->
	<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->
			
	
	<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

	<TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">

	<TR>
		<%If pvOrgID <> 0 Then%>
			<TD ALIGN=Left width="29%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Year / Month</B></TD>
		<%Else%>
			<TD ALIGN=Left width="29%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referral Facility</B></TD>
		<%End If%>
		
		<TD ALIGN=Left width="8%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		<TD ALIGN=Left width="8%" colspan=2 valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Registered</B></TD>
		<TD ALIGN=Left width="13%" colspan=2 valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Registered</B></TD>

		<TD ALIGN=Left width="24%" colspan=2 valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Registered</B></TD>


	<TR>
		<TD ALIGN=Left width="29%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>

		<TD ALIGN=Left width="8%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
		<TD ALIGN=Left width="8%" colspan=2 valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>& Apprchd</B></TD>
		<TD ALIGN=Left width="13%" colspan=2 valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>& Consented</B></TD>

		<TD ALIGN=Left COLSPAN=2 width="10%" valign="top"><FONT SIZE="1" FACE="<%=FontNameHead%>">& Recovered</TD>

	<TR><TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

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
			
			<%vTotals(1) = vTotals(1) + RS("A_Registry_Approached")%>
			<TD width="4%" <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=RS("A_Registry_Approached")%></B></FONT></TD>
			<%If RS("AllTypes") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("A_Registry_Approached")/RS("AllTypes"))*100,0)%>%</FONT></I></TD>
			<%End If%>
						
			<%
			vTotals(4) = vTotals(4) + RS("A_Registry_Consented")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=RS("A_Registry_Consented")%></B></FONT></TD>
			<%If RS("A_Registry_Approached") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=FormatNumber((RS("A_Registry_Consented")/RS("A_Registry_Approached"))*100,0)%>%</B></FONT></I></TD>
			<%End If%>
									
			<%
			vTotals(2) = vTotals(2) + RS("A_Registry_Recovered")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=RS("A_Registry_Recovered")%></B></FONT></TD>
			<%If RS("A_Registry_Approached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=FormatNumber((RS("A_Registry_Recovered")/RS("A_Registry_Approached"))*100,0)%>%</B></FONT></I></TD>
			<%End If%>
														
		</TR>
			
<!-- Row #2 - Organs -->

		<TR>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Organs</I></FONT></TD>
			
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("O_Registry_Approached")%></FONT></TD>
			<%vTotals(7) = vTotals(7) + RS("O_Registry_Approached")%>
			<%If RS("AllTypes") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("O_Registry_Approached")/RS("AllTypes"))*100,0)%>%</FONT></I></TD>
			<%End If%>
				
			<%
			vTotals(10) = vTotals(10) + RS("O_Registry_Consented")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("O_Registry_Consented")%></FONT></TD>
			<%If RS("O_Registry_Approached") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("O_Registry_Consented")/RS("O_Registry_Approached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
							
			<%
			vTotals(8) = vTotals(8) + RS("O_Registry_Recovered")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("O_Registry_Recovered")%></FONT></TD>
			<%If RS("O_Registry_Consented") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("O_Registry_Recovered")/RS("O_Registry_Consented"))*100,0)%>%</FONT></I></TD>
			<%End If%>
														
		</TR>
			
<!-- Row #3 - Tissues -->
		<TR>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Tissues</I></FONT></TD>
			
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("T_Registry_Approached")%></FONT></TD>
			<%vTotals(13) = vTotals(13) + RS("T_Registry_Approached")%>
			<%If RS("AllTypes") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("T_Registry_Approached")/RS("AllTypes"))*100,0)%>%</FONT></I></TD>
			<%End If%>

			<%
			vTotals(16) = vTotals(16) + RS("T_Registry_Consented")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("T_Registry_Consented")%></FONT></TD>
			<%If RS("T_Registry_Approached") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("T_Registry_Consented")/RS("T_Registry_Approached"))*100,0)%>%</FONT></I></TD>
			<%End If%>

			<%
			vTotals(14) = vTotals(14) + RS("T_Registry_Recovered")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("T_Registry_Recovered")%></FONT></TD>
			<%If RS("T_Registry_Consented") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("T_Registry_Recovered")/RS("T_Registry_Consented"))*100,0)%>%</FONT></I></TD>
			<%End If%>
														
		</TR>
		
<!-- Row #4 - Eyes -->
		<TR>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Eyes</I></FONT></TD>
			
			<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("E_Registry_Approached")%></FONT></TD>
			<%vTotals(19) = vTotals(19) + RS("E_Registry_Approached")%>
			<%If RS("AllTypes") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("E_Registry_Approached")/RS("AllTypes"))*100,0)%>%</FONT></I></TD>
			<%End If%>
				
			<%
			vTotals(22) = vTotals(22) + RS("E_Registry_Consented")			
			%>
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("E_Registry_Consented")%></FONT></TD>
			<%If RS("E_Registry_Approached") = 0 Then%>
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>			
				<TD width="9%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("E_Registry_Consented")/RS("E_Registry_Approached"))*100,0)%>%</FONT></I></TD>
			<%End If%>
							
			<%
			vTotals(20) = vTotals(20) + RS("E_Registry_Recovered")
			%>			
			<TD width="4%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("E_Registry_Recovered")%></FONT></TD>
			<%If RS("E_Registry_Approached") = 0 Then%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
			<%Else%>
				<TD width="7%" <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("E_Registry_Recovered")/RS("E_Registry_Approached"))*100,0)%>%</FONT></I></TD>
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
	<TR><TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

<!-- Row #1 All Totals -->	
	<TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
		<%If vTotals(0) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>0%</B></FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(1)/vTotals(0))*100,0)%>%</B></I></FONT></TD>		
		<%End If%>
		
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
		
	</TR>

<!-- Row #2 Organ Totals -->
	<TR><TD></TD>	
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Organs</I></FONT></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(7)%></I></FONT></TD>
		<%If vTotals(0) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(7)/vTotals(0))*100,0)%>%</I></FONT></TD>		
		<%End If%>
		
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

	</TR>

<!-- Row #3 Tissue Totals -->
	<TR><TD></TD>	
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Tissues</I></FONT></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(13)%></I></FONT></TD>
		<%If vTotals(0) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(13)/vTotals(0))*100,0)%>%</I></FONT></TD>		
		<%End If%>
		
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

	</TR>
		
<!-- Row #4 Eye Totals -->
	<TR>
		<TD></TD>	
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I>Eyes</I></FONT></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=vTotals(19)%></I></FONT></TD>
		<%If vTotals(0) = 0 Then%>
			<TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>			
		<%Else%>			
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber((vTotals(19)/vTotals(0))*100,0)%>%</I></FONT></TD>		
		<%End If%>
		
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