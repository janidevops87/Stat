<%
Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 
 %>
<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<title>UNOS Report</title>
<STYLE>
	UL {page-break-before: always}
</STYLE>
</head>

<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/Environment.sls"-->

<%	
Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData

Dim pvStartDate
Dim pvEndDate
Dim pvUserOrgID
Dim vOrgID
Dim vReportGroupID
Dim vSourceCodeID

Dim ReferralTypeList
Dim RSAccess

Dim vOrgName
Dim vMsgCount
Dim vImportCount

Dim vTotalNoSecondary
Dim vTotalSecondary
Dim vFamilyApproachTotals
Dim vFamilyUnavailableTotals	'1/20/03 drh
Dim vCryolifeFormTotals		'1/20/03 drh
Dim vFamilyApproachTotalsCount	'1/20/03 drh
Dim vMedSocTotalsCount		'1/20/03 drh
Dim vCryolifeFormTotalsCount	'1/20/03 drh
Dim vTotalMedSoc

Dim vTotalOTE
Dim vTotalTissue
Dim vTotalTE
Dim vTotalE
Dim vTotalOther
Dim vTotalOtherEye
Dim vTotalRO
Dim vTotalROA
Dim vTotalROM

Dim vGrandTotal

Dim vValue
Dim x
Dim vErrorMsg
Dim RS0, RS1
Dim DataWarehouseConn
Dim ErrorReturn

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

'Dim vCurrentColor
Dim iTempOrgID


'Column Totals
Dim vTotals(3)
vTotals(0) = 0
vTotals(1) = 0
vTotals(2) = 0


FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "1"


Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
pvUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
vOrgID = Request.QueryString("OrgID")

%>

<%

'========================================================================
'MH - 08/20/03
'This page is similar to Referral Overview report, except create DB connection and do 
'	other checks before entering the main function.  This will help with loading 
'	time and creating/dropping DB connections.
'========================================================================


'Do authorization checks, and other common DB checks.
If AuthorizeMain Then
	'Set Title Values	
	vMainTitle = "UNOS Report"	
	vTitlePeriod = DateLiteral(pvStartDate)
	vTitleTo = DateLiteral(pvEndDate)
	vTitleTimes = ""
	pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)		


	'Open data connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Open DataWarehouse Connection
	Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD

	%>

	<!-- User Org Section -->
	<%
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
		
	If (pvReportGroupID <> 0 AND pvOrgID = 0) Then

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


	'Main Page Logic Starts Here!!!!
	'==============================================

	'If user does not select "BreakOnOrg" then just display the results (i.e. Call Process).
	'Else grab the orgIDs within the selected report group, and loop though each one, calling 
	' the same Process function, but this time passing in the orgID parameter.
	IF NOT request("BreakOnOrgID") then 
		Call Process
	ELSE

		'If AuthorizeMain Then
		'	Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
		'	DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD

		'	Set Conn = server.CreateObject("ADODB.Connection")
		'	Conn.Open DataSourceName, DBUSER, DBPWD

		pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)

		IF ENVIRONMENT = "DEV" THEN
			vQuery = "SELECT _ReferralDev.dbo.Organization.OrganizationID as 'OrgID'"
			vQuery = vQuery + " FROM _ReferralDev.dbo.Organization"
			vQuery = vQuery + " LEFT JOIN _ReferralDev.dbo.WebReportGroupOrg ON _ReferralDev.dbo.WebReportGroupOrg.OrganizationID = _ReferralDev.dbo.Organization.OrganizationID"
			vQuery = vQuery + " WHERE WebReportGroupID =" & pvReportGroupID		
			vQuery = vQuery + " ORDER BY OrganizationName"
		ELSE
			vQuery = "SELECT _ReferralProdReport.dbo.Organization.OrganizationID as 'OrgID'"
			vQuery = vQuery + " FROM _ReferralProdReport.dbo.Organization"
			vQuery = vQuery + " LEFT JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID"
			vQuery = vQuery + " WHERE WebReportGroupID =" & pvReportGroupID		
			vQuery = vQuery + " ORDER BY OrganizationName"		
		END IF

		DIM RSOrgIDs
		Set RSOrgIDs = Conn.Execute(vQuery)

		Do while not RSOrgIDs.EOF
			'pvOrgID=RSOrgIDs("OrgID")
			vOrgID=RSOrgIDs("OrgID")
			Call Process
		RSOrgIDs.MoveNext
		Loop
	END IF
	
END IF%>  <!--End the IF Authorization clause-->



<%
'The main page generating routine
'============================================================================
Function Process

	'UNOS Query
	'------------------------------------
	UNOSQuery = "sps_GOLM_UNOS_Monthly " & pvReportGroupID & ", '" & pvStartDate & "', '" &  pvEndDate & "', " & vOrgID
	Set RS_UNOS = DataWarehouseConn.Execute(UNOSQuery)
	'Response.Write "UNOSQuery: " & UNOSQuery & "<BR>"

	If RS_UNOS.EOF = True Then

		If NOT Request("BreakOnOrgID") Then%>

			<P STYLE="line-height: 1pt">&nbsp</P>

			<!-- Header -->
			<TABLE WIDTH="100%" BORDER=0>
				<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial"><B> Referral Counts </B></FONT> </TD></TR>
				<TR><TD ALIGN=LEFT COLSPAN=4> <FONT FACE="Arial" SIZE="<%=FontSizeData%>"> No Data Available </FONT> </TD></TR>
			</TABLE>

		
			<!--#include virtual="/loginstatline/includes/copyright.shm"-->
			
		<%End If%>

	<%Else%>
		<%
		IF Request("BreakOnOrgID") then
			vReportTitle = RS_UNOS("OrganizationName")
		End IF
		%>

		<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->
		<!-- Header -->
		<TABLE WIDTH="100%" BORDER=0>
			<TR>
				<TD COLSPAN=4>&nbsp;</TD>
			</TR>
			<TR>
				<TD WIDTH="40%" ALIGN=LEFT><FONT FACE="<%=FontNameHead%>" SIZE="1"><B><%IF vOrgID = 0 And Not Request("BreakOnOrgID") then Response.Write("Organization's Name") else Response.Write("Year/Month") end if%></B></TD>
				<TD WIDTH="20%" ALIGN=CENTER><FONT FACE="<%=FontNameHead%>" SIZE="1"><B>Total Referrals</B></TD>
				<TD WIDTH="20%" ALIGN=CENTER><FONT FACE="<%=FontNameHead%>" SIZE="1"><B>Total Potential<BR>Organ Donors</B></TD>
				<TD WIDTH="20%" ALIGN=CENTER><FONT FACE="<%=FontNameHead%>" SIZE="1"><B>Total Consented<BR>Potential Organ Donors</TD>
			</TR>
			<TR>
				<TD ALIGN=CENTER COLSPAN="4"><HR width="100%" /></TD>
			</TR>


		<%
		'Set firt row color 
		vCurrentColor = "bgcolor=#FFFFFF"
		
		'Reset totals
		vTotals(0) = 0
		vTotals(1) = 0
		vTotals(2) = 0
		
		'Loop through the RS.
		Do Until RS_UNOS.EOF%>
			<%iTempOrgID = RS_UNOS("OrganizationID")%>

			<TR <%=vCurrentColor%>>

				<%IF vOrgID = 0 then%>
					<TD WIDTH="40%" ALIGN=LEFT>
						<FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeData%>"><%=RS_UNOS("OrganizationName")%></FONT>
					</TD>
				<%else%>
					<TD WIDTH="40%" ALIGN=LEFT>
						<FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeData%>"><%=DateLiteralFull(RS_UNOS("MonthID"),RS_UNOS("YearID"))%></FONT>
					</TD>
				<%End IF%>

				<TD WIDTH="20%" ALIGN=CENTER>
					<%vTotals(0) = vTotals(0) + RS_UNOS("Referral_Count")%>
					<FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeData%>"><%=RS_UNOS("Referral_Count")%></FONT>
				</TD>
				<TD WIDTH="20%" ALIGN=CENTER>
					<%vTotals(1) = vTotals(1) + RS_UNOS("Potential_Organ_Donors_CT")%>
					<FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeData%>"><%=RS_UNOS("Potential_Organ_Donors_CT")%></FONT>
				</TD>
				<TD WIDTH="20%" ALIGN=CENTER>
					<%vTotals(2) = vTotals(2) + RS_UNOS("Consent_CT")%>
					<FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeData%>"><%=RS_UNOS("Consent_CT")%></FONT>
				</TD>
			</TR>

			<%				
			'Change Row Color
			If vCurrentColor = "bgcolor=#FFFFFF" Then
				vCurrentColor = "bgcolor=#F5EBDD"
			Else
				vCurrentColor = "bgcolor=#FFFFFF"
			End If


		RS_UNOS.MOVENEXT	
			'If NOT RS_UNOS.EOF AND Request("BreakOnOrgID")  Then
			'If NOT RS_UNOS.EOF Then
			If RS_UNOS.EOF Then
				'IF NOT (iTempOrgID = RS_UNOS("OrganizationID"))  then
				%>

				<!-- Process Totals -->
				<TR><TD COLSPAN=5><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>
				<TR>
					<TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
					<TD ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>		
					<TD ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>		
					<TD ALIGN=CENTER><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(2)%></B></FONT></TD>
					<TD ALIGN=CENTER>&nbsp;</TD>
				</TR>

				</TABLE>

				<!--#include virtual="/loginstatline/includes/copyright.shm"-->

				</BODY>
				</HTML>

				<%IF Request("BreakOnOrgID") THEN%>
					<UL></UL>
				<%End IF%>

				<%
				'END IF
			END IF			
		Loop

		Set RS_UNOS = Nothing

	End If 
		
End Function  
  
  
  
'*************************************************************************************
' Subs and Funcs.
'*************************************************************************************
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

'MH 08/18/03
'DateLiteralFull() returns the full month name.
Function DateLiteralFull(pvMonthID, pvYearID)

	Select Case pvMonthID
	
		Case 1
			DateLiteralFull = "January "
		Case 2
			DateLiteralFull = "February "
		Case 3
			DateLiteralFull = "March "
		Case 4
			DateLiteralFull = "April "
		Case 5
			DateLiteralFull = "May "
		Case 6
			DateLiteralFull = "June "
		Case 7
			DateLiteralFull = "July "
		Case 8
			DateLiteralFull = "August "
		Case 9
			DateLiteralFull = "September "
		Case 10
			DateLiteralFull = "October "
		Case 11
			DateLiteralFull = "November "
		Case 12
			DateLiteralFull = "December "
	End Select
	
	DateLiteralFull = pvYearID & " " & DateLiteralFull
	
End Function


function LastDayOfMonth(DateIn)
    	Dim TempDate
    	TempDate = Year(dateIn) & "-" & Month(DateIn) & "-"
    	if IsDate(TempDate & "28") Then LastDayOfMonth = 28
    	if IsDate(TempDate & "29") Then LastDayOfMonth = 29
    	if IsDate(TempDate & "30") Then LastDayOfMonth = 30
    	if IsDate(TempDate & "31") Then LastDayOfMonth = 31
End function



%>