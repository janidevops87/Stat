
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
Dim vReportName
Dim vCurrentColor
Dim LastOrganizationID
Dim LastMonthYear
DIM LastOrgID

Dim vTotals(7)
Dim vOrgTotals(7)
Dim vUnapproached(8)
Dim vUnapproachedTotals(6)
Dim x
Dim i

Dim FontNameHead
Dim FontNameData
Dim NumberCallPerson
Dim CallPersonArray()
ReDim CallPersonArray(7,0)
Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

NumberCallPerson = 1

FontNameHead = "Arial"
FontNameData = "Times New Roman"

'Set Title Values	
vMainTitle = "Approach Person Consent Summary"


%>

<html>
<head>
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title><%=vMainTitle%></title>
<STYLE>
	UL {page-break-before: always}
</STYLE>
</head>
<body bgcolor="#F5EBDD" >
<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 
<%
Call Process

Function Process

'Execute the main page generating routine
If AuthorizeMain Then

	Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD
	
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
	
	'set report header values	
	vTitlePeriod = DateLiteral(pvStartDate)
	vTitleTo = DateLiteral(pvEndDate)
	vTitleTimes = "All Times " & ZoneName(vTZ)

	IF NOT request("BreakOnOrgID") then 
		'Get the list of organizations to be processed
		vQuery = "sps_ApproachPersonConsentSummary_C " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID

		'Response.Write vQuery
		Set RS = DataWarehouseConn.Execute(vQuery)
	ELSE
		'Get the list of organizations to be processed
		vQuery = "sps_ApproachPersonConsentSummary_B " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID & ", 1"

		'Response.Write vQuery
		Set RS = DataWarehouseConn.Execute(vQuery)
		IF NOT RS.EOF and Not RS.BOF Then
			pvOrgID = RS("OrganizationID")
			vReportTitle = RS("OrganizationName")
		END IF
	END IF
%>

	<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->

	<!-- Display Table Header -->

	<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

	<TABLE BORDER="0" WIDTH="100%" cellPadding="2" cellSpacing="0">

	<TR>
		
		<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp &nbsp</B></TD>
		<TD ALIGN=Left width="80%" colspan=11 ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Consent referrals by option type</B></TD>	
	</TR>
	<TR>
		<TD ALIGN=Left width="20%" rowspan=3 valign=middle><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Approach Person </B></TD>
		<TD ALIGN=Left COLSPAN=3 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Organs</TD>
		<TD ALIGN=Left COLSPAN=3 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Tissues</TD>
		<TD ALIGN=Left COLSPAN=3 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Eyes</TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Rule Out</TD>	
		
	</TR>	
	<TR valign=middle bordercolor=Red cellPadding="0">
						
		<TD ALIGN=Left COLSPAN=3 width="10%" height=1 rowspan=0>
		<HR ALIGN=Left COLOR="#000000" NOSHADE size=1 WIDTH="90%"></TD>
		<TD ALIGN=Left COLSPAN=3 width="10%" height=1 rowspan=0>
		<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>
		<TD ALIGN=Left COLSPAN=3 width="10%" height=1 rowspan=0>
		<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>
		<TD ALIGN=Left COLSPAN=1 width="15%" height=1 rowspan=0>
		<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>	
		
	</TR>	
	<TR>
		
				
		<TD ALIGN=Left COLSPAN=1 width="6%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>A</B></TD>
		<TD ALIGN=Left COLSPAN=1 width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>C</B> </TD>
		
		<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>%</I></B> </TD>
		
		<TD ALIGN=Left COLSPAN=1 width="6%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>A</B></TD>
		
		<TD ALIGN=Left COLSPAN=1 width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>C</B></TD>
		
		<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>%</I></B></TD>
		
		<TD ALIGN=Left COLSPAN=1 width="6%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>A</B></TD>
		<TD ALIGN=Left COLSPAN=1 width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>C </B></TD>
		<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>%</I></B></TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp &nbsp</TD>	
		
	</TR>	
		
		
	<TR>
		<TD COLSPAN=11><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>

<%
	vCurrentColor = "bgcolor=#FFFFFF"

	
	IF RS.EOF Then
		%>
		<TR>
			<TD colspan=11><FONT color=Red>No Records Found</FONT></TD>
		</TR>
		<%
	ELSE	
		IF request("BreakOnOrgID") then
			LastOrgID = RS("OrganizationID")
		end if
		Do While Not RS.EOF
			IF NOT request("BreakOnOrgID") then
				LastOrgID = RS("OrganizationID")
				
			end if
			IF LastOrgID <> RS("OrganizationID") then
				pvOrgID = RS("OrganizationID")
				vReportTitle = RS("OrganizationName")
				%>
				
				<!-- Process Subtotals -->
				<%
					Call SubTotal(-1)
				%>	

				<!-- Process Totals -->
				<TR>
					<TD colspan=12><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
				</TR>

				<TR>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(5)%></B></FONT></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=CalcPercentage(vTotals(1),vTotals(5)) %></I></B></FONT></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(6)%></B></FONT></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(2)%></B></FONT></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=CalcPercentage(vTotals(2),vTotals(6)) %></I></B></FONT></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(7)%></B></FONT></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(3)%></B></FONT></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=CalcPercentage(vTotals(3),vTotals(7))%></I></B></FONT></TD>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(4)%></B></FONT></TD>

				</TR>

				<!-- Print Person Totals -->
				<%
				If CallPersonArray(0,0) <> "" Then
				%>
					<TR>
						<TD <%'=vCurrentColor%> ALIGN=Left colspan=11  ><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</FONT></TD>
					</TR>

					<% 
					For i = 0 To Ubound(CallPersonArray, 2)
						If CallPersonArray(0,i)<> "" Then 
					%>
							<TR>
								<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp &nbsp &nbsp &nbsp 
									<A target="ReferralSummary" HREF="../summary_a.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & CallPersonArray(6,i) & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralCallerOrganizationID_=_"& CallPersonArray(6,i) &"_AND_ReferralApproachedByPersonID_=_" & CallPersonArray(7,i) & "_")%>
									<%=vAnd%>"> 
									<%=CallPersonArray(0,i) %></FONT>
								</TD>
								<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(1,i)%></FONT></TD>
								<!-- Detail -->
								<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(2,i)%></FONT></TD>
								<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(3,i)%></FONT></TD>
								<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(4,i)%></FONT></TD>
								<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(5,i)%></FONT></TD>
							</TR>
					<%		
						End If	
						If vCurrentColor = "bgcolor=#FFFFFF" Then
							vCurrentColor = "bgcolor=#F5EBDD"
						Else
							vCurrentColor = "bgcolor=#FFFFFF"
						End If
					Next 	
					' Print Total Unassigned

				End If

					%>
				</TABLE>

				
				
				<!--#include virtual="/loginstatline/includes/copyright.shm"-->
				<UL></UL>
				
				
				
				
				
				
				
				
				<% call ResetTotals %>	
				
				
				
				
				
				
				
				<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->

				<!-- Display Table Header -->

				<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

				<TABLE BORDER="0" WIDTH="100%" cellPadding="2" cellSpacing="0">

				<TR>

					<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp &nbsp</B></TD>
					<TD ALIGN=Left width="80%" colspan=11 ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Consent referrals by option type</B></TD>	
				</TR>
				<TR>
					<TD ALIGN=Left width="20%" rowspan=3 valign=middle><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Approach Person </B></TD>
					<TD ALIGN=Left COLSPAN=3 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Organs</TD>
					<TD ALIGN=Left COLSPAN=3 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Tissues</TD>
					<TD ALIGN=Left COLSPAN=3 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Eyes</TD>
					<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Rule Out</TD>	

				</TR>	
				<TR valign=middle bordercolor=Red cellPadding="0">

					<TD ALIGN=Left COLSPAN=3 width="10%" height=1 rowspan=0>
					<HR ALIGN=Left COLOR="#000000" NOSHADE size=1 WIDTH="90%"></TD>
					<TD ALIGN=Left COLSPAN=3 width="10%" height=1 rowspan=0>
					<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>
					<TD ALIGN=Left COLSPAN=3 width="10%" height=1 rowspan=0>
					<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>
					<TD ALIGN=Left COLSPAN=1 width="15%" height=1 rowspan=0>
					<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>	

				</TR>	
				<TR>

					<TD ALIGN=Left COLSPAN=1 width="6%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>A</B></TD>
					<TD ALIGN=Left COLSPAN=1 width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>C</B> </TD>
					<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>%</I></B> </TD>
					<TD ALIGN=Left COLSPAN=1 width="6%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>A</B></TD>
					<TD ALIGN=Left COLSPAN=1 width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>C</B></TD>
					<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>%</I></B></TD>
					<TD ALIGN=Left COLSPAN=1 width="6%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>A</B></TD>
					<TD ALIGN=Left COLSPAN=1 width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>C </B></TD>
					<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>%</I></B></TD>
					<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp &nbsp</TD>	
				</TR>	
				<TR>
					<TD COLSPAN=11><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
				</TR>	
			<%
			END IF
			%>
			

			<!-- Process Subtotals -->
			<%
			'If pvOrgID = 0 AND LastOrganizationID <> RS("OrganizationID")and LastOrganizationID <> "" Then	
				
			'	Call SubTotal(1)
			'End If	
			'If pvOrgID <> 0 AND LastMonthYear <> "" Then
			'	If LastMonthYear <> RS("MonthYear")Then	
			'		Call SubTotal(1)
			'	End If	
			'End IF
			If RS("ApproachPersonID")<= 0 OR isnull(RS("PersonName")) Then
				'Add to vUnapproached
				'vUnapproached(0)= vUnapproached(0) + RS("TotalApproached")
				'vUnapproached(1)= vUnapproached(1) + RS("ConsentOrgan")
				'vUnapproached(2)= vUnapproached(2) + RS("ConsentAllTissue")
				'vUnapproached(3)= vUnapproached(3) + RS("ConsentEyes")
				'vUnapproached(4)= vUnapproached(4) + RS("ApproachRO")
				'vUnapproached(5)= RS("OrganizationID")
				
				'If PvOrgId <> 0 Then
				'	vUnapproached(6)= RS("MonthID")
				'	vUnapproached(7)= RS("YearID")
				'End IF	
				
				'vUnapproachedTotals(0)= vUnapproachedTotals(0) + RS("TotalApproached")
				'vUnapproachedTotals(1)= vUnapproachedTotals(1) + RS("ConsentOrgan")
				'vUnapproachedTotals(2)= vUnapproachedTotals(2) + RS("ConsentAllTissue")
				'vUnapproachedTotals(3)= vUnapproachedTotals(3) + RS("ConsentEyes")
				'vUnapproachedTotals(4)= vUnapproachedTotals(4) + RS("ApproachRO")
				'vUnapproachedTotals(5)= RS("OrganizationID")
				
				
			ELSE
			
			%>
			
					<TR>
			<%		
				'If RS("ApproachPersonID")> 0 AND NOT RS("PersonName")<>"" Then
						'Call Function PersonNameHeader
						Call PersonNameHeader()	
			
				
						Call AddToTotal
			%>	
						<!-- Detail -->
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ApproachOrgan")%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ConsentOrgan")%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=CalcPercentage(RS("ConsentOrgan"),RS("ApproachOrgan"))%></I></FONT></TD>
						
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ApproachAllTissue")%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ConsentAllTissue")%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=CalcPercentage(RS("ConsentAllTissue"),RS("ApproachAllTissue"))%></I></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ApproachEyes")%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ConsentEyes")%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=CalcPercentage(RS("ConsentEyes"),RS("ApproachEyes"))%></I></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("ApproachRO")%></FONT></TD>
						
					</TR>
			<%
				If vCurrentColor = "bgcolor=#FFFFFF" Then
					vCurrentColor = "bgcolor=#F5EBDD"
				Else
					vCurrentColor = "bgcolor=#FFFFFF"
				End If
				'Build CallPersonArray if OrgId is specified and date range is greater than one month
				'If pvOrgID <> 0 AND DatePart("m",pvStartDate) <> DatePart("m",pvEndDate) Then
				'	For i = 0 To Ubound(CallPersonArray, 2)
				'		If CallPersonArray(0,i) = RS("PersonName") Then
				'			CallPersonArray(1,i)= CallPersonArray(1,i)+ RS("TotalApproached")
				'			CallPersonArray(2,i)= CallPersonArray(2,i)+ RS("ConsentOrgan")
				'			CallPersonArray(3,i)= CallPersonArray(3,i)+ RS("ConsentAllTissue")
				'			CallPersonArray(4,i)= CallPersonArray(4,i)+ RS("ConsentEyes")	
				'			CallPersonArray(5,i)= CallPersonArray(5,i)+ RS("ApproachRO")
				'			CallPersonArray(6,i)= RS("ApproachPersonID")
							
				'			Exit For
				'		ElseIf CallPersonArray(0,i) = "" Then 
				'			NumberCallPerson = (NumberCallPerson + 1)
				'			CallPersonArray(0,i)= RS("PersonName")
				'			CallPersonArray(1,i)= RS("TotalApproached")
				'			CallPersonArray(2,i)= RS("ConsentOrgan")
				'			CallPersonArray(3,i)= RS("ConsentAllTissue")
				'			CallPersonArray(4,i)= RS("ConsentEyes")	
				'			CallPersonArray(5,i)= RS("ApproachRO")
				'			CallPersonArray(6,i)= RS("ApproachPersonID")
							
				'			ReDim Preserve CallPersonArray(7, NumberCallPerson)
				'			Exit For
				'		End IF
				'	Next
				'End If		
			End If	
			
			LastOrgID=RS("OrganizationID")
			RS.MoveNext
			
		Loop
		%>
		
		<!-- Process Subtotals -->
		<%
			Call SubTotal(-1)
		%>	
		
		<!-- Process Totals -->
		<TR>
			<TD colspan=12><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
		</TR>

		<TR>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(5)%></B></FONT></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=CalcPercentage(vTotals(1),vTotals(5)) %></I></B></FONT></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(6)%></B></FONT></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(2)%></B></FONT></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=CalcPercentage(vTotals(2),vTotals(6)) %></I></B></FONT></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(7)%></B></FONT></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(3)%></B></FONT></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=CalcPercentage(vTotals(3),vTotals(7))%></I></B></FONT></TD>
			<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(4)%></B></FONT></TD>
			
		</TR>
		
		<!-- Print Person Totals -->
		<%
		If CallPersonArray(0,0) <> "" Then
		%>
			<TR>
				<TD <%'=vCurrentColor%> ALIGN=Left colspan=11  ><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</FONT></TD>
			</TR>

			<% 
			For i = 0 To Ubound(CallPersonArray, 2)
				If CallPersonArray(0,i)<> "" Then 
			%>
					<TR>
						<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp &nbsp &nbsp &nbsp 
							<A target="ReferralSummary" HREF="../summary_a.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & CallPersonArray(6,i) & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralCallerOrganizationID_=_"& CallPersonArray(6,i) &"_AND_ReferralApproachedByPersonID_=_" & CallPersonArray(7,i) & "_")%>
							<%=vAnd%>"> 
							<%=CallPersonArray(0,i) %></FONT>
						</TD>
						<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(1,i)%></FONT></TD>
						<!-- Detail -->
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(2,i)%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(3,i)%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(4,i)%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(5,i)%></FONT></TD>
					</TR>
			<%		
				End If	
				If vCurrentColor = "bgcolor=#FFFFFF" Then
					vCurrentColor = "bgcolor=#F5EBDD"
				Else
					vCurrentColor = "bgcolor=#FFFFFF"
				End If
			Next 	
			' Print Total Unassigned
			
		End If
			
			%>
		</TABLE>
	<%
	End If
END IF
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


Private Function SubTotal(PrintLine)
'Set PrintLine to Print a horizontal line after printing the subtotals.

			If vUnapproached(0) > 0 Then		
				%>
				<TR>
						<TD width="5%" <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameData%>"> &nbsp &nbsp &nbsp &nbsp Unapproached Referrals</FONT></TD>
						<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=vUnapproachedTotals(0)%></FONT></TD>
						<!-- Detail -->
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=vUnapproachedTotals(1)%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber(vUnapproachedTotals(1)/vUnapproachedTotals(0) *100,0)%>%</I></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=vUnapproachedTotals(2)%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber(vUnapproachedTotals(2)/vUnapproachedTotals(0) *100,0)%>%</I></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=vUnapproachedTotals(3)%></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=FormatNumber(vUnapproachedTotals(3)/vUnapproachedTotals(0) *100,0)%>%</I></FONT></TD>
						<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=vUnapproachedTotals(4)%></FONT></TD>
				</TR>	
				<%
				vTotals(0) = vTotals(0)+ vUnapproached(0)
				vTotals(1) = vTotals(1)+ vUnapproached(1)
				vTotals(2) = vTotals(2)+ vUnapproached(2)
				vTotals(3) = vTotals(3)+ vUnapproached(3)
				vTotals(4) = vTotals(4)+ vUnapproached(4)
				
				vOrgTotals(0) = vOrgTotals(0)+ vUnapproached(0)
				vOrgTotals(1) = vOrgTotals(1)+ vUnapproached(1)
				vOrgTotals(2) = vOrgTotals(2)+ vUnapproached(2)
				vOrgTotals(3) = vOrgTotals(3)+ vUnapproached(3)
				vOrgTotals(4) = vOrgTotals(4)+ vUnapproached(4)

				For i = 0 to UBound(vUnapproached,1)
					vUnapproached(i)=0
				Next
				If vCurrentColor = "bgcolor=#FFFFFF" Then
					vCurrentColor = "bgcolor=#F5EBDD"
				Else
					vCurrentColor = "bgcolor=#FFFFFF"
				End	If
			End If
				%>	
	
<%	
	For i = 0 to UBound(vOrgTotals,1)
			vOrgTotals(i)=0
	Next
	
	LastOrganizationID = ""
End Function

Private Function PersonNameHeader()
						
	If RS("ApproachPersonID")> 0 Then
		%>
			<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"> &nbsp &nbsp &nbsp &nbsp <%=RS("PersonName")%> </TD>
		<%
	End If
										
End Function

Function AddToTotal
	'vTotals(0) = vTotals(0) + RS("TotalApproached")
	'vOrgTotals(0) = vOrgTotals(0) + RS("TotalApproached")

	vTotals(1) = vTotals(1) + RS("ConsentOrgan")
	vOrgTotals(1) = vOrgTotals(1) + RS("ConsentOrgan")				

	vTotals(2) = vTotals(2) + RS("ConsentAllTissue")
	vOrgTotals(2) = vOrgTotals(2) + RS("ConsentAllTissue")

	vTotals(3) = vTotals(3) + RS("ConsentEyes")			
	vOrgTotals(3) = vOrgTotals(3) + RS("ConsentEyes")			

	vTotals(4) = vTotals(4) + RS("ApproachRO")
	vOrgTotals(4) = vOrgTotals(4) + RS("ApproachRO")						
	
	vTotals(5) = vTotals(5) + RS("ApproachOrgan")
	vOrgTotals(5) = vOrgTotals(5) + RS("ApproachOrgan")				

	vTotals(6) = vTotals(6) + RS("ApproachAllTissue")
	vOrgTotals(6) = vOrgTotals(6) + RS("ApproachAllTissue")

	vTotals(7) = vTotals(7) + RS("ApproachEyes")			
	vOrgTotals(7) = vOrgTotals(7) + RS("ApproachEyes")			

				
	
	
End Function					
Function CalcPercentage(Top, Bottom)

	If Bottom = 0 Then
		CalcPercentage = 0
		Exit Function
	ELSE
		CalcPercentage = FormatNumber(Top/Bottom*100, 0)
	END IF

End Function

Function ResetTotals
	vTotals(0) = 0
	vTotals(1) = 0
	vTotals(2) = 0
	vTotals(3) = 0
	vTotals(4) = 0
	vTotals(5) = 0
	vTotals(6) = 0
	vTotals(7) = 0
	vOrgTotals(0) = 0
	vOrgTotals(1) = 0
	vOrgTotals(2) = 0
	vOrgTotals(3) = 0
	vOrgTotals(4) = 0
	vOrgTotals(5) = 0
	vOrgTotals(6) = 0
	vOrgTotals(7) = 0
	vUnapproached(0) = 0
	vUnapproached(1) = 0
	vUnapproached(2) = 0
	vUnapproached(3) = 0
	vUnapproached(4) = 0
	vUnapproached(5) = 0
	vUnapproached(6) = 0
	vUnapproached(7) = 0
	vUnapproached(8) = 0
	vUnapproachedTotals(0) = 0
	vUnapproachedTotals(1) = 0
	vUnapproachedTotals(2) = 0
	vUnapproachedTotals(3) = 0
	vUnapproachedTotals(4) = 0
	vUnapproachedTotals(5) = 0
	vUnapproachedTotals(6) = 0
End Function

'End of Function Section
%>