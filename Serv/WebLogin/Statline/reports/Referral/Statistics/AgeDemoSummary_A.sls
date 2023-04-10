
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
Dim LastDonorGender
Dim vTotals(5)
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


%>

<html>
<head>
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Age Demographics A</title>
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
	DataWarehouseConn.CommandTimeout = 90
	DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD	'drh 1/6/04 - Un-hardcoded DSN
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Server.ScriptTimeout = 270
	Conn.CommandTimeout = 90
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
	vMainTitle = "Age Demographics"
	vTitlePeriod = pvStartDate
	vTitleTo = pvEndDate
	vTitleTimes = "All Times " & ZoneName(vTZ)

%>

	<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->

<%
	vQuery = "sps_AverageAgeSummary_A " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID

	Set RS = DataWarehouseConn.Execute(vQuery)
	
	'initialize vAverage
	For ii = 0 to Ubound(vAverage,2)
		For i = 0 to UBound(vAverage,1)
				vAverage(i, ii)= 0
		Next
	Next	
	Do While Not RS.EOF
		IF RS("DonorGender")= "M" Then
	
			If IsNull(RS("AllTypesAge")) Then 
				vAverage(0,0) = 0
			Else
				vAverage(0,0)= RS("AllTypesAge")
			End IF
			If IsNull(RS("AppropriateOrganAge")) Then
				vAverage(1,0)= 0
			Else
				vAverage(1,0)= RS("AppropriateOrganAge")
			End IF
			If IsNull(RS("AppropriateAllTissueAge")) Then
				vAverage(2,0)= 0
			Else
				vAverage(2,0)= RS("AppropriateAllTissueAge")
			End IF	
			If IsNull(RS("AppropriateEyesAge")) Then
				vAverage(3,0)= 0
			Else
				vAverage(3,0)= RS("AppropriateEyesAge")		
			End IF	
			If IsNull(RS("AppropriateROAge")) Then
				vAverage(4,0)= 0
			Else
				vAverage(4,0)= RS("AppropriateROAge")
			End IF	
		ELSE
			If IsNull(RS("AllTypesAge")) Then 
				vAverage(0,1) = 0
			Else
				vAverage(0,1)= RS("AllTypesAge")
			End IF
			If IsNull(RS("AppropriateOrganAge")) Then
				vAverage(1,1)= 0
			Else
				vAverage(1,1)= RS("AppropriateOrganAge")
			End IF
			If IsNull(RS("AppropriateAllTissueAge")) Then
				vAverage(2,1)= 0
			Else
				vAverage(2,1)= RS("AppropriateAllTissueAge")
			End IF	
			If IsNull(RS("AppropriateEyesAge")) Then
				vAverage(3,1)= 0
			Else
				vAverage(3,1)= RS("AppropriateEyesAge")		
			End IF	
			If IsNull(RS("AppropriateROAge")) Then
				vAverage(4,1)= 0
			Else
				vAverage(4,1)= RS("AppropriateROAge")
			End IF	
		END IF

		RS.MoveNext
	Loop	
	Set RS = Nothing
	vCurrentColor = "bgcolor=#FFFFFF"
	
	'Get the list of organizations to be processed
	vQuery = "sps_AgeDemoSummary_A " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID

	Set RS = DataWarehouseConn.Execute(vQuery)
	
	Call TableHeader()
	
	Do While Not RS.EOF
		
		'Response.Write RS("DonorGender")
		'Check for a new Gender
		If RS("DonorGender") <> LastDonorGender AND LastDonorGender <> "" Then
			Call Total()
			If LastDonorGender = "M" Then
				Call AverageAge(0)
			ELSE
				Call AverageAge(1)
			End IF	
			Response.Write "</TABLE>"
			Call TableHeader()
			
		End IF
		
		'Set LastDonorGender
		LastDonorGender = RS("DonorGender")	
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

		%>	
				<TR>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AgeName")%></TD>
								
					<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">
						
								<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & Request.QueryString("OrgID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralDonorGender_=_" & "'" & RS("DonorGender") & "'" &"_AND_((Cast(ReferralDonorAge_AS_int)_BETWEEN_" & RS("AgeRangeStart") & "_AND_" & RS("AgeRangeEnd") & "_AND_ReferralDonorAgeUnit_=_'Years'_)_Or_(Cast(ReferralDonorAge_AS_int)_BETWEEN_" & (RS("AgeRangeStart")*365) & "_AND_" & (RS("AgeRangeEnd")*365) & "_AND_ReferralDonorAgeUnit_=_'Days'_)_Or_(Cast(ReferralDonorAge_AS_int)_BETWEEN_" & (RS("AgeRangeStart")*12) & "_AND_" & (RS("AgeRangeEnd")*12) & "_AND_ReferralDonorAgeUnit_=_'Months'_))")%>
								<%=vAnd%>"> 
								<%=RS("AllTypes")%>
								</A></FONT>
					</TD>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AppropriateOrgan")%></FONT></TD>
					<TD  <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AppropriateAllTissue")%></FONT></TD>
					<TD  <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AppropriateEyes")%></FONT></TD>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AppropriateRO")%></FONT></TD>
					<%
					vTotals(0) = vTotals(0) + RS("AllTypes")
					vTotals(1) = vTotals(1) + RS("AppropriateOrgan")
					vTotals(2) = vTotals(2) + RS("AppropriateAllTissue")
					vTotals(3) = vTotals(3) + RS("AppropriateEyes")			
					vTotals(4) = vTotals(4) + RS("AppropriateRO")
					%>		
																					
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
	
	<!-- Process Subtotals -->

	<%		
	Call Total()
	If LastDonorGender = "M" Then
		Call AverageAge(0)
	ELSE
		Call AverageAge(1)
	End IF	
	'PRINT FINAL BLACK LINE
	%>
	<TR>
		<TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>
	<%
	
	%>
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

Private Function TableHeader()

%>
	<!-- Display Table Header -->

	<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

	<TABLE BORDER=0 WIDTH="100%" cellpadding=4 cellSpacing="0">

	<TR>
		<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%IF RS("DonorGender") = "M" Then Response.Write "Male" Else Response.Write "Female" End If   %></B></TD>
				
		<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		
		<TD ALIGN=Left width="60%" colspan=4><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Appropriate referrals by option type</B></TD>	
	</TR>
	<TR>
		<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Age Range</B></TD>
		<TD ALIGN=Left width="20%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
		
		<TD ALIGN=Left COLSPAN=1 width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Organs</TD>
		<TD ALIGN=Left COLSPAN=1 width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Tissues</TD>
		<TD ALIGN=Left COLSPAN=1 width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Eyes</TD>
		<TD ALIGN=Left COLSPAN=1 width="15%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Rule Out</TD>	
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
<%	
	For i = 0 to UBound(vTotals,1)
			vTotals(i)=0
	Next
End Function



Private Function SubTotal(PrintLine)
'Set PrintLine to Print a horizontal line after printing the subtotals.
%>
	<TR>
		<TD <%=vCurrentColor%>  ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i>&nbsp &nbsp &nbsp &nbsp Subtotal</i></B></TD>
		<TD <%=vCurrentColor%>  ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(0)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(1)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(2)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(3)%></i></B></FONT></TD>
		<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><B><i><%=vOrgTotals(4)%></i></B></FONT></TD>
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
	For i = 0 to UBound(vOrgTotals,1)
			vOrgTotals(i)=0
	Next
End Function

'End of Function Section
%>