
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
Dim vGroupSection
Dim TimeRangeList
Dim TimeRangeTrack
Dim TimeRangeName
Dim AllTypes
Dim AppropriateOrgan
Dim AppropriateAllTissue
Dim AppropriateEyes
Dim AppropriateRO
Dim vTotals(5)
Dim vGrandTotals(5)
Dim vAverage(5,2)
Dim x
Dim i, ii

Dim FontNameHead
Dim FontNameData

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

FontNameHead = "Arial"
FontNameData = "Times New Roman"
vGroupSection = ""

%>

<html>
<head>
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Hospital Report Time Summary A</title>
</head>
<body bgcolor="#F5EBDD">

<!-- Include any files here  -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<!--#include virtual="/loginstatline/includes/HospitalReportTime.vbs"-->
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
	vMainTitle = "Hospital Report Time Summary"	
	vTitlePeriod = DateLiteral(pvStartDate)
	vTitleTo = DateLiteral(pvEndDate)
	vTitleTimes = "All Times " & ZoneName(vTZ)
	
%>	
		<!-- Print Report Header -->
		<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->

<%	
	vQuery = "select HospitalReportTimeRangeID, TimeRangeName From HospitalReportTimeRange "
	Set RS = DataWarehouseConn.Execute(vQuery)
	
	TimeRangeList = RS.GetRows
	
	Set RS = Nothing
	vCurrentColor = "bgcolor=#FFFFFF"
	
	'Get the list of organizations to be processed
	vQuery = "sps_HospitalReportTimeSummary_A " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID

	Set RS = DataWarehouseConn.Execute(vQuery)
	
	%></TABLE><%
	
	'drh 1/1/04 - Added If statement to prevent error when no records are returned
	If Not RS.EOF Then
		IF pvOrgID = 0 Then
			vGroupSection = RS("OrganizationName")
		Else
		    vGroupSection = DateLiteral(RS("MonthID") & "/1/" & RS("YearID"))
		End IF	
		Call TableHeader()
	End If
	
	'TimeRangeTrack = 0	
	
	Do While Not RS.EOF
		
		'Response.Write RS("DonorGender")
		'Check for a new Gender
		IF pvOrgID = 0 Then
		
			IF vGroupSection <> RS("OrganizationName")   Then
				Call Total()
				vGroupSection = RS("OrganizationName")
				Call TableHeader()
			END IF	
		Else
			IF  vGroupSection <> DateLiteral(RS("MonthID") & "/1/" & RS("YearID")) Then
				Call Total()
			    vGroupSection = DateLiteral(RS("MonthID") & "/1/" & RS("YearID"))
			    Call TableHeader()
			End IF	
			
			'TimeRangeTrack = 0
		End IF
		
		'Do While TimeRangeList(0,TimeRangeTrack) <> RS("TimeRangeID")
		'	TimeRangeName = TimeRangeList(1,TimeRangeTrack)
		'	AllTypes = 0
		'	AppropriateOrgan = 0
		'	AppropriateAllTissue = 0
		'	AppropriateEyes = 0
		'	AppropriateRO = 0
		'	
		'	Call PrintRow()

		'	TimeRangeTrack = TimeRangeTrack + 1
		'Loop
			'Call Total()
	
			'Response.Write "</TABLE>"
					
			
		%>

		<!-- Process Subtotals -->
		<%
		
		'If pvOrgID = 0 AND LastOrganizationID <> RS("OrganizationID")AND LastOrganizationID <> "" Then	
		'	Call SubTotal(1)
		'End If	
		'If pvOrgID <> 0 AND LastMonthYear <> "" Then
		'	If LastMonthYear <> RS("MonthYear")Then	
		'		Call SubTotal(1)
		'	End If	
		'End IF
		
		TimeRangeName = RS("TimeRangeName")
		AllTypes = RS("AllTypes")
		AppropriateOrgan = RS("AppropriateOrgan")
		AppropriateAllTissue = RS("AppropriateAllTissue")
		AppropriateEyes = RS("AppropriateEyes")
		AppropriateRO = RS("AppropriateRO")

		Call PrintRow()
		
		
		'TimeRangeTrack = TimeRangeTrack + 1		
		RS.MoveNext
				
		
	Loop
	%>
	
	<!-- Process Subtotals -->

	<%		
	Call Total()
	
	
				
	'PRINT FINAL BLACK LINE
	%>
	<TR>
		<TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>
	<%
	IF pvOrgID > 0 Then
		call GrandTotal(0)
		%>	</TABLE>
		<%
	End if
	
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
		Function PrintRow()
		%>
				<TR>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%= TimeRangeName%></TD>
								
					<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">
								<%IF pvOrgID > 0 Then%>
								<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_Referral.ReferralID_IN_(SELECT_DISTINCT_ReferralID_FROM_Call_JOIN_Referral_ON_Referral.CallID=Call.CallID_JOIN_Organization_ON_Organization.OrganizationID=Referral.ReferralCallerOrganizationID_JOIN_WebReportGroupOrg_ON_WebReportGroupOrg.OrganizationID=ReferralCallerOrganizationID_JOIN_SourceCode_ON_SourceCode.SourceCodeID=Call.SourceCodeID_JOIN_ViewReferralIDList_ON_ViewReferralIDList.ReportTimeCalcTableID=Referral.ReferralID_WHERE_DATEPART(yyyy,DateAdd(hour," & ZoneDifference(PvStartDate, vTZ)& ",CallDateTime))=" & RS("YEARID") & "_AND_DATEPART(m,DateAdd(hour," & ZoneDifference(PvStartDate, vTZ)& ",CallDateTime))=" & RS("MONTHID") & "_AND_WebReportGroupOrg.WebReportGroupID_=_" & pvReportGroupID & "" & GetHospitalReportCaseStatment()&"_BETWEEN_" & RS("TimeRangeStart") & "_AND_" & RS("TimeRangeEnd")&"_AND_Referral.ReferralCallerOrganizationID_=_" &  RS("OrganizationID")& "_)_")%>
								<%Else%>
								<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_Referral.ReferralID_IN_(SELECT_DISTINCT_ReferralID_FROM_Call_JOIN_Referral_ON_Referral.CallID=Call.CallID_JOIN_Organization_ON_Organization.OrganizationID=Referral.ReferralCallerOrganizationID_JOIN_WebReportGroupOrg_ON_WebReportGroupOrg.OrganizationID=ReferralCallerOrganizationID_JOIN_SourceCode_ON_SourceCode.SourceCodeID=Call.SourceCodeID_JOIN_ViewReferralIDList_ON_ViewReferralIDList.ReportTimeCalcTableID=Referral.ReferralID_WHERE_DateAdd(hour," & ZoneDifference(PvStartDate, vTZ)& ",CallDateTime)_BETWEEN_'" & pvStartDate & "'_AND_'" & pvEndDate & "'_AND_WebReportGroupOrg.WebReportGroupID_=_" & pvReportGroupID & "" & GetHospitalReportCaseStatment()&"_BETWEEN_" & RS("TimeRangeStart") & "_AND_" & RS("TimeRangeEnd")&"_AND_Referral.ReferralCallerOrganizationID_=_" &  RS("OrganizationID")& ")_")%>
								
								<%End IF%>
								<%=vAnd%>"> 
								<%=AllTypes%>
								</A></FONT>
								
					</TD>			
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%= AppropriateOrgan%></FONT></TD>
					<TD  <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%= AppropriateAllTissue%></FONT></TD>
					<TD  <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%= AppropriateEyes%></FONT></TD>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%= AppropriateRO %></FONT></TD>
					<%
					vTotals(0) = vTotals(0) + AllTypes
					vTotals(1) = vTotals(1) + AppropriateOrgan
					vTotals(2) = vTotals(2) + AppropriateAllTissue
					vTotals(3) = vTotals(3) + AppropriateEyes			
					vTotals(4) = vTotals(4) + AppropriateRO
					%>		
																					
				</TR>
			
		<%
			If vCurrentColor = "bgcolor=#FFFFFF" Then
				vCurrentColor = "bgcolor=#F5EBDD"
			Else
				vCurrentColor = "bgcolor=#FFFFFF"
			End If
		
		End Function	

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

Private Function TableHeader()

%>
	<!-- Display Table Header -->

	<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%"> 

	<TABLE BORDER=0 WIDTH="100%" cellpadding=4 cellSpacing="0">

	<TR>
		<TD ALIGN=Left width="30%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%IF pvOrgID = 0 Then Response.Write RS("OrganizationName") ELSE Response.write vGroupSection  %></B></TD>
				
		<TD ALIGN=Left width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		
		<TD ALIGN=Left width="55%" colspan=4><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Appropriate referrals by option type</B></TD>	
	</TR>
	<TR>
		<TD ALIGN=Left width="30%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Report Time Range (Hours)</B></TD>
		<TD ALIGN=Left width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
		
		<TD ALIGN=Left COLSPAN=1 width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Organs</TD>
		<TD ALIGN=Left COLSPAN=1 width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Tissues</TD>
		<TD ALIGN=Left COLSPAN=1 width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Eyes</TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Rule Out</TD>	
	</TR>	
		
		
	<TR>
		<TD COLSPAN=6><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>
<%
End Function
'Function AverageAge
Private Function AverageAge(GenderType)

%>

		<!-- Process Totals -->
	<TR>
	</TR>

	<TR>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Average Age</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vAverage(0, GenderType)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vAverage(1, GenderType)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vAverage(2, GenderType)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vAverage(3, GenderType)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vAverage(4, GenderType)%></B></FONT></TD>
	</TR>
<%	
	For i = 0 to UBound(vAverage,1)
			vAverage(i,GenderType)=0
	Next
End Function



Private Function Total()

%>

		<!-- Process Totals -->
	<TR>
		<TD COLSPAN=6><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>

	<TR>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(2)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(3)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(4)%></B></FONT></TD>
	</TR>
	</Table>
<%	
	vGrandTotals(0) = vGrandTotals(0) + vTotals(0)
	vGrandTotals(1) = vGrandTotals(1) + vTotals(1)
	vGrandTotals(2) = vGrandTotals(2) + vTotals(2)
	vGrandTotals(3) = vGrandTotals(3) + vTotals(3)
	vGrandTotals(4) = vGrandTotals(4) + vTotals(4)
	
	For i = 0 to UBound(vTotals,1)
			vTotals(i)=0
	Next
End Function



Private Function GrandTotal(PrintLine)
'Set PrintLine to Print a horizontal line after printing the subtotals.
%>
	<TABLE BORDER=0 WIDTH="100%" cellpadding=4 cellSpacing="0">
	
	<TR>
		<TD <%=vCurrentColor%> width="30%"  ><FONT SIZE="1" FACE="<%=FontNameData%>"><B>&nbsp Subtotal</B></TD>
		<TD <%=vCurrentColor%> width="15%" ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><%=vGrandTotals(0)%></B></FONT></TD>
		<TD <%=vCurrentColor%> width="15%"><FONT SIZE="1" FACE="<%=FontNameData%>"><B><%=vGrandTotals(1)%></B></FONT></TD>
		<TD <%=vCurrentColor%> width="15%" ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><%=vGrandTotals(2)%></B></FONT></TD>
		<TD <%=vCurrentColor%> width="15%"><FONT SIZE="1" FACE="<%=FontNameData%>"><B><%=vGrandTotals(3)%></B></FONT></TD>
		<TD <%=vCurrentColor%> width="10%" ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><%=vGrandTotals(4)%></B></FONT></TD>
	</TR>
	<% 
	If PrintLine = 1 Then 
	%>
		<TR>
			<TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
		</TR>
	<% 
	End If		
	%>	
<%	
	For i = 0 to UBound(vGrandTotals,1)
			vGrandTotals(i)=0
	Next
End Function


'End of Function Section
%>