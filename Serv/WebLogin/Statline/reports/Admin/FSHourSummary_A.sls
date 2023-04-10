
<% 
Option Explicit

'Dim DataWarehouseConn
Dim pvStartDate
Dim pvEndDate
Dim pvUserOrg
Dim pvOrgID
Dim pvReportGroupID
Dim vReportTitle
Dim vTZ
Dim vErrorMsg
Dim vAnd
Dim ErrorReturn
Dim vReportName
Dim vCurrentColor
Dim LastOrganizationID
Dim LastMonthYear

Dim vTotals(8,23)
Dim vOrgTotals(8)
Dim vUnapproached(8)
Dim vUnapproachedTotals(6)
Dim x
Dim i

Dim vColFieldName(10)
Dim FontNameHead
Dim FontNameData
Dim NumberCallPerson
Dim CallPersonArray()
ReDim CallPersonArray(7,0)

vColFieldName(0)=""
vColFieldName(1)=""
vColFieldName(2)="SecondaryScreening"
vColFieldName(3)="FamilyApproaches"
vColFieldName(4)="FamilyUnavailable"
vColFieldName(5)="TotalApproaches"
vColFieldName(6)="Consent"
vColFieldName(7)=""
vColFieldName(8)=""
vColFieldName(9)=""



NumberCallPerson = 1

FontNameHead = "Arial"
FontNameData = "Times New Roman"
LastOrganizationID = ""



vReportName = "Approach Person Consent Summary"

%>

<html>
<head>
<meta HTTP-EQUIV="Expires" content="0"> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title><%=vReportName%></title>
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

	'Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	'DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrg = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)

	'Verify the requesting organization if it not Statline
	If pvUserOrg <> 194 then
		
		vQuery = "sps_OrganizationName " & pvUserOrg
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
				pvUserOrg = RS("OrgHierarchyParentID")
				vReportTitle = RS("OrganizationName") & " - "
			End If
			Set RS = Nothing
		End If		

	End If

	'If pvReportGroupID <> 0 AND pvOrgID = 0 Then
		
		'If a report group has been selected, get the report group name
		'and set the report title to the name of the report group
		'vQuery = "sps_ReportGroupName " & pvReportGroupID & " "
		'Set RS = Conn.Execute(vQuery)

		'If Conn.Errors.Count > 0 Then
			'vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			'vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
			'vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			'vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			'vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			'vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			'vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
			'vErrorMsg = vErrorMsg & "</FONT></FONT>"
			'Response.Write(vErrorMsg)
		'End If
		
		'If RS.EOF = True Then
			'vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			'vErrorMsg = vErrorMsg & "The selected report group is no longer valid. Please select another group.<BR> <BR>"
			'vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			'vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			'vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			'vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, FacilitySummary.sls) <BR> <BR>"
			'vErrorMsg = vErrorMsg & "</FONT></FONT>"
			'Response.Write(vErrorMsg)
			
		'Else
		'	vReportTitle = vReportTitle & RS("WebReportGroupName")		
		'End If
		
		'Set RS = Nothing
		
	'ElseIf pvOrgID <> 0  Then

		'Else if a single organization has been selected, get the organization data 
		'and set the report title to the name of the selected organization

		'Get the organization information
		'vQuery = "sps_OrganizationName " & pvOrgID
		
		'Set RS = Conn.Execute(vQuery)
		
		'If RS.EOF = True Then
		'	vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		'	vErrorMsg = vErrorMsg & "The organization selected for this report does not exist. <BR> <BR>"
		'	vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
		'	vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		'	vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		'	vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
		'	vErrorMsg = vErrorMsg & "</FONT></FONT>"
		'Else
			'vReportTitle = RS("OrganizationName")			
		'End If
		
		'Set RS = Nothing
		
	'ElseIf pvOrgID = 0 AND pvReportGroupID = 0 Then

	'	vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
	'	vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
	'	vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
	'	vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
	'	vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
	'	vErrorMsg = vErrorMsg & "Error:     (-1, UnitSummary.sls) <BR> <BR>"
	'	vErrorMsg = vErrorMsg & "</FONT></FONT>"
	'	Response.Write(vErrorMsg)

	'Else

	'	vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
	'	vErrorMsg = vErrorMsg & "Unexpected Error. <BR> "
	'	vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
	'	vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
	'	vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
	'	vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
	'	vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, UnitSummary.sls) <BR> <BR>"
	'	vErrorMsg = vErrorMsg & "</FONT></FONT>"
	'	Response.Write(vErrorMsg)

	'End if

	vQuery = "sps_OrganizationTimeZone " & pvUserOrg & " "
	
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing
	
%>

	<!--#include virtual="/loginstatline/reports/admin/FSSummary_AHead.sls"-->

	<!-- Display Table Header -->

	<IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

	<TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">

	<TR>
		<!--
		<TD ALIGN=Left width="20%" rowspan=1 valign=middle><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp</TD>
		<TD ALIGN=Left COLSPAN=4 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Tissues</TD>
		<TD ALIGN=Left COLSPAN=4 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Eyes</TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>	
		-->
		
	</TR>	
	<TR valign=middle bordercolor=Red cellPadding="0">
						
		<TD ALIGN=Left COLSPAN=6 width="15%" height=1 rowspan=0><FONT SIZE="1" FACE="<%=FontNameHead%>"><B> Source Code Name</B></TD>
		<!--
		<TD ALIGN=Left COLSPAN=4 width="10%" height=1 rowspan=0>
		<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>
		<TD ALIGN=Left COLSPAN=4 width="10%" height=1 rowspan=0>
		<HR ALIGN=Left COLOR="#000000" NOSHADE SIZE=1 WIDTH="90%"></TD>
		<TD ALIGN=Left COLSPAN=1 width="15%" height=1 rowspan=0>&nbsp</TD>	
		-->
		
	</TR>	
	<TR>
		
				
		<TD ALIGN=Left  width="30%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp &nbsp Statline Employee</B></TD>
		<TD ALIGN=Left COLSPAN=1 width="14%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Secondary Screening</B></TD>


	<!--'tissue -->
		<TD ALIGN=CENTER COLSPAN=1 width="14%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Family Approach</B></TD>
		
		<TD ALIGN=CENTER  COLSPAN=1 width="14%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Family Unavailable</B></TD>
		

		<TD ALIGN=CENTER  COLSPAN=1 width="14%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total Approaches</B></TD>

		<TD ALIGN=CENTER  COLSPAN=1 width="14%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Consent</B></TD>
	<!--' eyes -->
	<!--
		<TD ALIGN=Left COLSPAN=1 width="6%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>A</B></TD>
		<TD ALIGN=Left COLSPAN=1 width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>C </B></TD>
		<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>%</I></B></TD>
		<TD ALIGN=Left COLSPAN=1 width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I>Family Unav.</I></B></TD>
		<TD ALIGN=Left COLSPAN=1 width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"></TD>	
		-->
		
	</TR>	
		
		
	<TR>
		<TD COLSPAN=11><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
	</TR>

<%
	vCurrentColor = "bgcolor=#FFFFFF"
	
	'Get the list of organizations to be processed
	vQuery = "SPS_FSCHourSummary" & " '" & pvStartDate & "', '" & pvEndDate & "'"
	'Print(vQuery)
	Set RS = Conn.Execute(vQuery)
	
	IF RS.EOF Then
		%>
		<TR>
			<TD colspan=6><FONT color=Red>No Records Found</FONT></TD>		
		</TR>
		<%
	ELSE IF true Then	
		Do While Not RS.EOF
		
	%>

			<!-- Process Subtotals -->
			<%
			
			If LastOrganizationID <> RS("Date") Then	
				If LastOrganizationID <> "" Then
					CALL SubTotal("")
				End If
				CALL ReferralOrganizationHeader()

			End If	
			LastOrganizationID = RS("Date")
			'If pvOrgID <> 0 AND LastMonthYear <> "" Then
			'	If LastMonthYear <> RS("MonthYear")Then	
			'		Call SubTotal(1)
			'	End If	
			'End IF
			'If RS("ApproachPersonID")<= 0 OR isnull(RS("PersonName")) Then
				'Add to vUnapproached
				'vUnapproached(0)= vUnapproached(0) + RS("TotalApproached")
				'vUnapproached(1)= vUnapproached(1) + RS("ConsentOrgan")
				'vUnapproached(2)= vUnapproached(2) + RS("ConsentAllTissue")
				'vUnapproached(3)= vUnapproached(3) + RS("ConsentEyes")
				'vUnapproached(4)= vUnapproached(4) + RS("AppropriateRO")
				'vUnapproached(5)= RS("OrganizationID")
				
				'If PvOrgId <> 0 Then
				'	vUnapproached(6)= RS("MonthID")
				'	vUnapproached(7)= RS("YearID")
				'End IF	
				
				'vUnapproachedTotals(0)= vUnapproachedTotals(0) + RS("TotalApproached")
				'vUnapproachedTotals(1)= vUnapproachedTotals(1) + RS("ConsentOrgan")
				'vUnapproachedTotals(2)= vUnapproachedTotals(2) + RS("ConsentAllTissue")
				'vUnapproachedTotals(3)= vUnapproachedTotals(3) + RS("ConsentEyes")
				'vUnapproachedTotals(4)= vUnapproachedTotals(4) + RS("AppropriateRO")
				'vUnapproachedTotals(5)= RS("OrganizationID")
				
				
			'ELSE
			
			%>
			
					<TR>
			<%		
				'If RS("ApproachPersonID")> 0 AND NOT RS("PersonName")<>"" Then
						Call PersonNameHeader()
						'Call ApproachOrganizationHeader()	
			
				
						Call AddToTotal
			%>	
						<!-- Detail -->
						<TD ALIGN=CENTER width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("SecondaryScreening")%></FONT></TD>
						
														
						<TD ALIGN=CENTER width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("FamilyApproaches")%></FONT></TD>
						<TD ALIGN=CENTER width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("FamilyUnavailable")%></FONT></TD>
						<TD ALIGN=CENTER width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("TotalApproaches")%></FONT></TD>
						
						<TD ALIGN=CENTER width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("Consent")%></FONT></TD>

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
				'			CallPersonArray(5,i)= CallPersonArray(5,i)+ RS("AppropriateRO")
				'			CallPersonArray(6,i)= RS("ApproachPersonID")
							
				'			Exit For
				'		ElseIf CallPersonArray(0,i) = "" Then 
				'			NumberCallPerson = (NumberCallPerson + 1)
				'			CallPersonArray(0,i)= RS("PersonName")
				'			CallPersonArray(1,i)= RS("TotalApproached")
				'			CallPersonArray(2,i)= RS("ConsentOrgan")
				'			CallPersonArray(3,i)= RS("ConsentAllTissue")
				'			CallPersonArray(4,i)= RS("ConsentEyes")	
				'			CallPersonArray(5,i)= RS("AppropriateRO")
				'			CallPersonArray(6,i)= RS("ApproachPersonID")
							
				'			ReDim Preserve CallPersonArray(7, NumberCallPerson)
				'			Exit For
				'		End IF
				'	Next
				'End If		
			'End If	
				
			RS.MoveNext
			
		Loop
		%>
		
		<!-- Process Subtotals -->
		<%
			Call SubTotal(-1)
		%>	
		
		<!-- Process Totals -->
		<TR>
			<!--<TD colspan=12><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>-->
		</TR>
		
		<TR>
			<TD ALIGN=CENTER <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
			
		</TR>
		

		<%

			If vCurrentColor = "bgcolor=#FFFFFF" Then
				vCurrentColor = "bgcolor=#F5EBDD"
			Else
				vCurrentColor = "bgcolor=#FFFFFF"
			End If
		
		For i = 0 to UBound(vTotals,2)
		
	
		%>
		<TR>
			
			<TD ALIGN=CENTER <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=i%></B></TD>
			<TD ALIGN=CENTER <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%If vTotals(2,i) = "" Then %>0<% Else %><%=vTotals(2,i)%><% End If %></B></FONT></TD>
			 
			<TD ALIGN=CENTER <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%If vTotals(3,i) = "" Then %>0<% Else %><%=vTotals(3,i)%><% End If %></B></FONT></TD>	
			<TD ALIGN=CENTER <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%If vTotals(4,i) = "" Then %>0<% Else %><%=vTotals(4,i)%><% End If %></B></FONT></TD>			
			<TD ALIGN=CENTER <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%If vTotals(5,i) = "" Then %>0<% Else %><%=vTotals(5,i)%><% End If %></B></FONT></TD>			
			
			<TD ALIGN=CENTER <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%If vTotals(6,i) = "" Then %>0<% Else %><%=vTotals(6,i)%><% End If %></B></FONT></TD>
			
		</TR>
		<%
			If vCurrentColor = "bgcolor=#FFFFFF" Then
				vCurrentColor = "bgcolor=#F5EBDD"
			Else
				vCurrentColor = "bgcolor=#FFFFFF"
			End If
		Next
		%>
		
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
						<TD width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(2,i)%></FONT></TD>
						<TD width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(3,i)%></FONT></TD>
						<TD width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(4,i)%></FONT></TD>
						<TD width="14%" <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=CallPersonArray(5,i)%></FONT></TD>
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
	End If
END IF
Set RS = Nothing
Set Conn = Nothing


End Function
%>
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
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Sub Totals</B></TD>
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vOrgTotals(3)%></B></FONT></TD>

					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vOrgTotals(4)%></B></FONT></TD>	
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vOrgTotals(5)%></B></FONT></TD>			
					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vOrgTotals(6)%></B></FONT></TD>			

					<TD ALIGN=CENTER ><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vOrgTotals(7)%></B></FONT></TD>
				</TR>	
				<TR>
					<TD colspan=12><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD>
				</TR>

				<%
								
				
				If vCurrentColor = "bgcolor=#FFFFFF" Then
					vCurrentColor = "bgcolor=#F5EBDD"
				Else
					vCurrentColor = "bgcolor=#FFFFFF"
				End	If
			
				%>	
	
<%	
	For i = 0 to UBound(vOrgTotals,1)
			vOrgTotals(i)=0
	Next
	
	LastOrganizationID = ""
End Function

Private Function ReferralOrganizationHeader()
	%>
	<TR>
	
		<TD COLSPAN=6 <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"><%=RS("Date")%> </TD>
	</TR>
	<%
	If vCurrentColor = "bgcolor=#FFFFFF" Then
		vCurrentColor = "bgcolor=#F5EBDD"
	Else
		vCurrentColor = "bgcolor=#FFFFFF"
	End If

End Function
Private Function ApproachOrganizationHeader()
						
	
		%>
			<TD width=30% <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>">&nbsp &nbsp <%=RS("ApproachOrganizationName")%> </TD>
		<%
	
										
End Function

Private Function PersonNameHeader()
						
	If LEN(RS("HOUR"))> 0 Then
		%>
			<TD <%=vCurrentColor%> ><FONT SIZE="1" FACE="<%=FontNameData%>"> &nbsp &nbsp &nbsp &nbsp <%=RS("HOUR")%> </TD>
		<%
	End If
										
End Function

Function AddToTotal
	'vTotals(0) = vTotals(0) + RS("TotalApproached")
	'vOrgTotals(0) = vOrgTotals(0) + RS("TotalApproached")

	'vTotals(1) = vTotals(1) + RS("ConsentOrgan")
	'vOrgTotals(1) = vOrgTotals(1) + RS("ConsentOrgan")				

	vTotals(2,RS("HOUR")) = vTotals(2,RS("HOUR")) + RS(vColFieldName(2))
	vOrgTotals(2) = vOrgTotals(2) + RS(vColFieldName(2))

	
	vTotals(3,RS("HOUR")) = vTotals(3,RS("HOUR")) + RS(vColFieldName(3))
	vOrgTotals(3) = vOrgTotals(3) + RS(vColFieldName(3))

	vTotals(4,RS("HOUR")) = vTotals(4,RS("HOUR")) + RS(vColFieldName(4))
	vOrgTotals(4) = vOrgTotals(4) + RS(vColFieldName(4))

	vTotals(5,RS("HOUR")) = vTotals(5,RS("HOUR")) + RS(vColFieldName(5))
	vOrgTotals(5) = vOrgTotals(5) + RS(vColFieldName(5))

	vTotals(6,RS("HOUR")) = vTotals(6,RS("HOUR")) + RS(vColFieldName(6))
	vOrgTotals(6) = vOrgTotals(6) + RS(vColFieldName(6))

	'vTotals(7) = vTotals(7) + RS(vColFieldName(7))
	'vOrgTotals(7) = vOrgTotals(7) + RS(vColFieldName(7))

	'vTotals(8) = vTotals(8) + RS(vColFieldName(8))
	'vOrgTotals(8) = vOrgTotals(8) + RS(vColFieldName(8))

	
	
End Function					
Function CalcPercentage(Top, Bottom)

	If Bottom = 0 Then
		CalcPercentage = 0
		Exit Function
	ELSE
		CalcPercentage = FormatNumber(Top/Bottom*100, 0)
	END IF

End Function

'End of Function Section
%>