
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
Dim LastOrganizationID
Dim LastMonthYear

Dim vTotals(5)
Dim vOrgTotals(5)
Dim x
Dim i

Dim FontNameHead
Dim FontNameData
Dim NumberCallPerson
Dim CallPersonArray()
ReDim CallPersonArray(8,0)

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes


NumberCallPerson = 1

FontNameHead = "Arial"
FontNameData = "Times New Roman"

%>

<html>
<head>
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Unit Summary A</title>
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
	vMainTitle = "Unit Summary"
	vTitlePeriod = DateLiteral(pvStartDate)
	vTitleTo = DateLiteral(pvEndDate)
	vTitleTimes = "All Times " & ZoneName(vTZ)
	
	%>	
	<!-- Print Report Header -->
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
		
		<TD ALIGN=Left width="14%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
		
		<TD ALIGN=Left width="54%" colspan=6><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Appropriate referrals by option type</B></TD>	
	</TR>
	<TR>
		<TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp &nbsp Unit</B></TD>
		<TD ALIGN=Left width="14%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
		
		<TD ALIGN=Left COLSPAN=1 width="13%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Organs</TD>
		<TD ALIGN=Left COLSPAN=1 width="13%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Tissues</TD>
		<TD ALIGN=Left COLSPAN=1 width="13%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Eyes</TD>
		<TD ALIGN=Left COLSPAN=1 width="13%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Rule Out</TD>	
	</TR>	
		
		
	<TR>
		<TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>

<%
	vCurrentColor = "bgcolor=#FFFFFF"
	
	'Get the list of organizations to be processed
	vQuery = "sps_UnitSummary_A " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
		'Response.Write vQuery
	Set RS = DataWarehouseConn.Execute(vQuery)
	
	Do While Not RS.EOF
	
%>

		<!-- Process Subtotals -->
		<%
		
		If pvOrgID = 0 AND LastOrganizationID <> RS("OrganizationID")AND LastOrganizationID <> "" Then	
			Call SubTotal(1)
		End If	
		If pvOrgID <> 0 AND LastMonthYear <> "" Then
			If LastMonthYear <> RS("MonthYear")Then	
				Call SubTotal(1)
			End If	
		End IF

		If pvOrgID <> 0 Then
			If LastMonthYear <> RS("MonthYear")Then
					LastMonthYear = RS("MonthYear")	
		%>	
				<TR>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("MonthYear")%></TD>
					<TD <%=vCurrentColor%> ColSpan="6"><FONT SIZE="1" FACE="<%=FontNameHead%>"> </TD>
				</TR>
		<%		
				If vCurrentColor = "bgcolor=#FFFFFF" Then
					vCurrentColor = "bgcolor=#F5EBDD"
				Else
					vCurrentColor = "bgcolor=#FFFFFF"
				End If
		%>
										<TR>
					<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"> &nbsp &nbsp &nbsp &nbsp <%=RS("Unit")%></TD>

		<%		
						
			Else
		%>		
				
				<TR>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameData%>"> &nbsp &nbsp &nbsp &nbsp <%=RS("Unit")%></TD>
		<%			
			End If
					
		Else
			If LastOrganizationID <> RS("OrganizationID")OR LastOrganizationID = "" Then
				LastOrganizationID = RS("OrganizationID")
		%>	
				<TR>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("OrganizationName")%></TD>

					<TD <%=vCurrentColor%> ColSpan="6"><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>
				</TR>
		<%		
						
				If vCurrentColor = "bgcolor=#FFFFFF" Then
					vCurrentColor = "bgcolor=#F5EBDD"
				Else
					vCurrentColor = "bgcolor=#FFFFFF"
				End If
		%>
				<TR>
					<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"> &nbsp &nbsp &nbsp &nbsp <%=RS("Unit")%></TD>
		<%
						
			Else
		%>
				<TR>
					<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameData%>">	&nbsp &nbsp &nbsp &nbsp <%=RS("Unit")%></TD>	
		<%			
			End If
		End If	
		%>	
			
					<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">
							<% If pvOrgID <> 0 Then %>
								<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & RS("MonthID")& "/1/" & RS("YearID")& "_" &  "00:00" & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & RS("OrganizationID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralCallerOrganizationID_=_"& RS("OrganizationID") &"__AND_ReferralCallerSublocationID_=_" & RS("LocationID") & CheckSubLocation(RS("SubLocation")) &"_")%>
								<%=vAnd%>"> 
								<%=RS("AllTypes")%>
							<% Else %>
								<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & RS("OrganizationID") & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralCallerOrganizationID_=_"& RS("OrganizationID") &"__AND_ReferralCallerSublocationID_=_" & RS("LocationID") & CheckSubLocation(RS("SubLocation")) &"_")%>
								<%=vAnd%>"> 
								<%=RS("AllTypes")%>
							<% End If %>

								</A></FONT>
					</TD>
					<%
					vTotals(0) = vTotals(0) + RS("AllTypes")
					vOrgTotals(0) = vOrgTotals(0) + RS("AllTypes")
			
					%>
					<!-- Detail -->
					<%
					vTotals(1) = vTotals(1) + RS("AppropriateOrgan")
					vOrgTotals(1) = vOrgTotals(1) + RS("AppropriateOrgan")
					%>			
					<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AppropriateOrgan")%></FONT></TD>
								
					<%
					vTotals(2) = vTotals(2) + RS("AppropriateAllTissue")
					vOrgTotals(2) = vOrgTotals(2) + RS("AppropriateAllTissue")
					%>			
					<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AppropriateAllTissue")%></FONT></TD>
							
					<%
					vTotals(3) = vTotals(3) + RS("AppropriateEyes")			
					vOrgTotals(3) = vOrgTotals(3) + RS("AppropriateEyes")			
					%>
					<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AppropriateEyes")%></FONT></TD>
							
					<%
					vTotals(4) = vTotals(4) + RS("AppropriateRO")
					vOrgTotals(4) = vOrgTotals(4) + RS("AppropriateRO")						
					%>
					<TD width="5%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AppropriateRO")%></FONT></TD>
							
																					
				</TR>
			
		<%
		If vCurrentColor = "bgcolor=#FFFFFF" Then
			vCurrentColor = "bgcolor=#F5EBDD"
		Else
			vCurrentColor = "bgcolor=#FFFFFF"
		End If
		'Build CallPersonArray if OrgId is specified and date range is greater than one month
		If pvOrgID <> 0 AND DatePart("m",pvStartDate) <> DatePart("m",pvEndDate) Then
			For i = 0 To Ubound(CallPersonArray, 2)
				If CallPersonArray(0,i) = RS("Unit") Then
					CallPersonArray(1,i)= CallPersonArray(1,i)+ RS("AllTypes")
					CallPersonArray(2,i)= CallPersonArray(2,i)+ RS("AppropriateOrgan")
					CallPersonArray(3,i)= CallPersonArray(3,i)+ RS("AppropriateAllTissue")
					CallPersonArray(4,i)= CallPersonArray(4,i)+ RS("AppropriateEyes")	
					CallPersonArray(5,i)= CallPersonArray(5,i)+ RS("AppropriateRO")
					CallPersonArray(6,i)= RS("OrganizationID")
					CallPersonArray(7,i)= RS("LocationID")
					
					Exit For
				ElseIf CallPersonArray(0,i) = "" Then 
					NumberCallPerson = (NumberCallPerson + 1)
					CallPersonArray(0,i)= RS("Unit")
					CallPersonArray(1,i)= RS("AllTypes")
					CallPersonArray(2,i)= RS("AppropriateOrgan")
					CallPersonArray(3,i)= RS("AppropriateAllTissue")
					CallPersonArray(4,i)= RS("AppropriateEyes")	
					CallPersonArray(5,i)= RS("AppropriateRO")
					CallPersonArray(6,i)= RS("OrganizationID")
					CallPersonArray(7,i)= RS("LocationID")
					
					ReDim Preserve CallPersonArray(8, NumberCallPerson)
					Exit For
				End IF
			Next
		End If		
			
		RS.MoveNext
		
	Loop
	%>
	
	<!-- Process Subtotals -->
	<%
		Call SubTotal(-1)
	%>	
	
	<!-- Process Totals -->
	<TR>
		<TD COLSPAN=8><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>

	<TR>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
		<TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(2)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(3)%></B></FONT></TD>
		<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(4)%></B></FONT></TD>
	</TR>
	
	<!-- Print Person Totals -->
	<%
	If CallPersonArray(0,0) <> "" Then
	%>
		<TR>
			<TD <%'=vCurrentColor%> ALIGN=Left COLSPAN=6  ><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</FONT></TD>
		</TR>

		<% 
		For i = 0 To Ubound(CallPersonArray, 2)
			If CallPersonArray(0,i)<> "" Then 
		%>
				<TR>
					<TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp &nbsp &nbsp &nbsp 
						<A target="ReferralSummary" HREF="../summary_A.sls?<%=("Type=2&StartDate=" & Request.QueryString("StartDate") & "&EndDate=" & Request.QueryString("EndDate") & "&ReportGroupID=" & pvReportGroupID & "&OrgID=" & CallPersonArray(6,i) & "&userID=" & Request.QueryString("UserID") & "&userOrgID=" & Request.QueryString("UserOrgID") & "&DSN=" & Request.QueryString("DSN") & "&Options=&ReportID=11&NoLog=1&AND=_AND_ReferralCallerOrganizationID_=_"& CallPersonArray(6,i) &"__AND_ReferralCallerSublocationID_=_" & CallPersonArray(7,i) & "_")%>
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
	End If	
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

Private Function CheckSubLocation(RSSubLocation)

	IF NOT ISNULL(RS("SubLocation"))THEN 
	
	CheckSubLocation = "__AND_ReferralCallerSubLocationLevel_=_'" & RS("SubLocation")& "'"
	ELSE
	CheckSubLocation = "__AND_ISNULL(ReferralCallerSubLocationLevel, '')_=_''"
	END IF
	
End Function
%>