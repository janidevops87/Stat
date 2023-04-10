<%Option Explicit

'Declare variables
Dim ErrorReturn
Dim pvStartDate
Dim pvEndDate
Dim DateTime
Dim vErrorMsg
Dim vOrgList
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim vReportGroupName
Dim pvReferralTypeID
Dim Identify
Dim Org
Dim Refer
Dim vTZ
Dim i
Dim x
Dim y
Dim z
Dim vTemp
Dim ResultArray
Dim TypeName
Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog
Dim FontBold
Dim pvIn
Dim pvOut
Dim vIn(0)
Dim pvTotals(12)
Dim pvAppropriate
Dim pvUnAppropriate
Dim pvTotalReferrals
Dim pvApproach
Dim pvConsent
Dim txtColumns(3)
Dim txtRow(3)
Dim txtLink(3)
Dim pvConversion
Dim DataWareHouseConn
'DW = DataWareHouse
Dim DWRs 
Dim DWCmd
Dim DWParam
Dim QuitPage
Dim vTotalRO
Dim vPotentialDonors
Dim vActualApproached
Dim vPercentage

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

%>


<%
FontNameHead = "Arial"
FontSizeHead = "2.5"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeDataLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"
QuitPage = 0
For i = 0 to Ubound(txtRow,1)
	txtLink(i) = ""
	txtRow(i) = ""
Next

%>




<HTML>
<HEAD>
<META HTTP-EQUIV="Expires" content="now">
<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<TITLE>Referral Statistics - Referral Analysis</TITLE>
</HEAD>
<BODY bgColor=#F5EBDD>

<!-- Include any files here  -->
<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 


<%'Execute the main page generating routine
If AuthorizeMain Then

	If ExecuteMain Then
		Server.ScriptTimeout = 270
		Set DWRs = Server.CreateObject("ADODB.Recordset")
		Set DWCmd = Server.CreateObject("ADODB.Command")
		Set DWParam = Server.CreateObject("ADODB.Parameter")

		'Set Title Values	
		vMainTitle = "Referral Analysis"	
		vTitlePeriod = DateLiteral(pvStartDate)
		vTitleTo = DateLiteral(pvEndDate)
		vTitleTimes = "All Times " & ZoneName(vTZ)
	
	%>	
		<!-- Print Report Header -->
		<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->
		
		<% 
			
			'Print Appropriate and Rule Out Totals Header. Store Referral Totals in a variable to calculate % later
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	
			
			'1/16/04 mds: Getting Appropriate & Ruleout to sum to display the Total Referrals
			DWCmd.CommandText = "sps_AppropriateTotal_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
	
			Set DWRs = DWCmd.Execute
		
			If IsNull(DWRs(0)) Then
				pvAppropriate = 0
			Else
				pvAppropriate = DWRs(0)		
			End if 	
			
			DWCmd.CommandText = "sps_ROTotal_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			Set DWRs = DWCmd.Execute
		
			'Print Totals Header
			
			If IsNull(DWRs(0))Then
				pvUnAppropriate = 0
			Else
			 	pvUnAppropriate = DWRs(0)		
			End if 
			
			'Response.Write (".." & (PvUnAppropriate + pvAppropriate) & "..")
			
			IF IsNull(PvUnAppropriate + pvAppropriate) or PvUnAppropriate + pvAppropriate = 0 Then
				txtColumns(0) = "No Records"
				Call intPrintColumnHeader(txtColumns)
				QuitPage = -1
			End if
			
		If QuitPage = 0 Then	
			
			'****START SECTION 1************************************************
			'1/16/04 mds: Start section 1 - All Referrals
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	
			DWCmd.CommandText = "sps_NWLEB_1_AllReferrals "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			'Response.Write DWCmd.CommandText
			Set DWRs = DWCmd.Execute
			
			txtColumns(0)= "1 - All Referrals"			
			Call intDefaultHeader()
			
			txtRow(0) = "All referrals"
			txtRow(1) = PvUnAppropriate + pvAppropriate
			
			Call intPrintRows(txtRow,0,txtLink)
			
			pvTotals(5) = DWRs("AppropriateEyes")
			pvTotals(11) = DWRs("AppropriateEyesUnappropriate")
			vTotalRO = 0
			
			txtRow(0) = "Age"
			txtRow(1) = DWRs("AppropriateEyesAge")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_2"
			vTotalRO = vTotalRO + txtRow(1) 
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "High Risk"
			txtRow(1) = DWRs("AppropriateEyesHighRisk")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_3"
			vTotalRO = vTotalRO + txtRow(1) 
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Med RO"
			txtRow(1) = DWRs("AppropriateEyesMedRO")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_4"
			vTotalRO = vTotalRO + txtRow(1)  
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Not Appropriate"
			txtRow(1) = DWRs("AppropriateEyesNtAppropriate")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_5"
			vTotalRO = vTotalRO + txtRow(1) 
			Call intPrintRows(txtRow,1,txtLink)
			
			If DWRs("AppropriateEyesPreviousVent") = 0 then
				'do nothing
			Else	
				txtRow(0) = "Previous Vent"
				txtRow(1) = DWRs("AppropriateEyesPreviousVent")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_6"
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)
			End if
			
			txtRow(0) = "Potential Donors"
			txtRow(1) = (PvUnAppropriate + pvAppropriate) - vTotalRO 
			vPotentialDonors = txtRow(1)
			Call intPrintRows(txtRow,0,txtLink)
			
			'Print End of Table
				
			DWCmd.ActiveConnection = Nothing
			'****START SECTION 1************************************************
			%>
			</Table>
			<%
			
			'****START SECTION 2************************************************
			'Print Potential Donor Data
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
			DWCmd.CommandText = "sps_NWLEB_2_PotentialDonors "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			Set DWRs = DWCmd.Execute
			txtColumns(0)= "2 - Potential Donors"			
			Call intDefaultHeader()
			
			
			'Reset pvTotals
			pvTotals(5) = DWRs("ApproachEyes")
			pvTotals(11) = DWRs("ApproachEyesNotApproached")
			vTotalRO = 0
			
			txtRow(0) = "Potential Donors"
			txtRow(1) = vPotentialDonors
			Call intPrintRows(txtRow,0,txtLink)

			txtRow(0) = "Unknown"
			txtRow(1) = DWRs("ApproachEyesUnknown")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_2_AND_ReferralEyesTransAppropriateID_=_1_"
			vTotalRO = vTotalRO + txtRow(1) 
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Family Unavail."
			txtRow(1) = DWRs("ApproachEyesFamilyUnavail")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_3_AND_ReferralEyesTransAppropriateID_=_1_"
			vTotalRO = vTotalRO + txtRow(1) 
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Coroner RuleOut"
			txtRow(1) = DWRs("ApproachEyesCoronerRuleout")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_4_AND_ReferralEyesTransAppropriateID_=_1_"
			vTotalRO = vTotalRO + txtRow(1) 
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Med RO"
			txtRow(1) = DWRs("ApproachEyesMedRO")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_6_AND_ReferralEyesTransAppropriateID_=_1_"
			vTotalRO = vTotalRO + txtRow(1) 
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Time/Logistics"
			txtRow(1) = DWRs("ApproachEyesTimeLogistics")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_7_AND_ReferralEyesTransAppropriateID_=_1_"
			vTotalRO = vTotalRO + txtRow(1)  
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "High Risk"
			txtRow(1) = DWRs("ApproachEyesHighRisk")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_9_AND_ReferralEyesTransAppropriateID_=_1_"
			vTotalRO = vTotalRO + txtRow(1) 
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Unapproachable"
			txtRow(1) = DWRs("ApproachEyesUnapproachable")
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_11_AND_ReferralEyesTransAppropriateID_=_1_"
			vTotalRO = vTotalRO + txtRow(1)  
			Call intPrintRows(txtRow,1,txtLink)
			
			If DWRs("ApproachEyesArrest") = 0 then
				'do nothing
			Else
				txtRow(0) = "Arrest"
				txtRow(1) = DWRs("ApproachEyesArrest")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_5_AND_ReferralEyesTransAppropriateID_=_1_"
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)
			End if
			
			If DWRs("ApproachEyesNeverBrainDead") = 0 then
				'do nothing
			Else
				txtRow(0) = "Never Brain Dead"
				txtRow(1) = DWRs("ApproachEyesNeverBrainDead")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_8_AND_ReferralEyesTransAppropriateID_=_1_"
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)
			End if
			
			If DWRs("ApproachEyesSecondaryRO") = 0 then
				'do nothing
			Else
				txtRow(0) = "Secondary RO"
				txtRow(1) = DWRs("ApproachEyesSecondaryRO")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_14_AND_ReferralEyesTransAppropriateID_=_1_"
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)
			End if
			
			txtRow(0) = "Actual Approached"
			txtRow(1) = vPotentialDonors - vTotalRO 
			vActualApproached = txtRow(1)
			Call intPrintRows(txtRow,0,txtLink)
						
			DWCmd.ActiveConnection = Nothing
			%>
			</Table>
			<%
			'****END SECTION 2**************************************************
			
			
			'****START SECTION 3************************************************
			'Print Total Consented data
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
			DWCmd.CommandText = "sps_NWLEB_3_TotalConsented "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			Set DWRs = DWCmd.Execute
			txtColumns(0)= "3 - Total Consent"			
			Call intDefaultHeader()
			
			txtRow(0) = "Total consented"
			txtRow(1) = DWRs("ConsentEyes") 
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Actual consent rate"
			txtRow(1) = DWRs("ConsentEyes") & "/" & vActualApproached & ": "
			txtRow(2) = intCalcPercentage(DWRs("ConsentEyes"),vActualApproached)
			Call intPrintRows(txtRow,1,txtLink)
			
			DWCmd.ActiveConnection = Nothing
			%>
			</Table>
			<%
			'****END SECTION 3*************************************************
			
			'****START SECTION 4***********************************************
			'Print Actual Recovered data
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
			DWCmd.CommandText = "sps_NWLEB_4_ActualRecovered "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			Set DWRs = DWCmd.Execute
			txtColumns(0)= "4 - Actual Recovered"			
			Call intDefaultHeader()
						
			txtRow(0) = "Actual recovered"
			txtRow(1) = DWRs("ConversionEyes") 
			txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_1_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			DWCmd.ActiveConnection = Nothing
			%>
			</Table>
			<%
			'****END SECTION 4************************************************
			
			'****START SECTION 5**********************************************
			'Print Pre-Referral Approach data
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
			DWCmd.CommandText = "sps_NWLEB_5_PreReferralApproach "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			Set DWRs = DWCmd.Execute
			txtColumns(0)= "5 - Pre-Referral Approach"			
			Call intDefaultHeader()
									
			txtRow(0) = "Pre-referral approach"
			txtRow(1) = DWRs("PreApproach") & "/" & vActualApproached & ": "
			txtRow(2) = intCalcPercentage(DWRs("PreApproach"),vActualApproached) 
			Call intPrintRows(txtRow,1,txtLink)
						
			
			DWCmd.ActiveConnection = Nothing
			'****END SECTION 5************************************************
			%>
			</Table>
			
	<%End If	
	End If

End If
%>

<P STYLE="line-height: 6pt">&nbsp</P>
<HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%">
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
</BODY>
</HTML>

<%Set Refer = Nothing%>

<%Function ExecuteMain()


	'Get the query variables
	Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
	Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
	pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
	pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
	pvReferralTypeID = FormatNumber(Request.QueryString("ReferralType"),0,,0,0)
	
	'Create a connection object
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.CommandTimeout = 90
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Verify the requesting organization if it not Statline

		vQuery  = "sps_IdentifyOrganization " & pvUserOrgID
		'Response.Write pvUserOrgID
		Set RS = Conn.Execute(vQuery)

		If RS.EOF Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
			vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Org.IdentifyOrganization, MultiDetail.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			Exit Function
		End If
		
		vOrgList = RS.GetRows
		Set RS = Nothing


	If pvReportGroupID <> 0 AND pvOrgID = 0 Then
		
		'If a report group has been selected, get the report group name
		'and set the report title to the name of the report group

		vQuery = "sps_ReportGroupName " & pvReportGroupID	 
		
		'Response.Write pvReportGroupID
		Set RS = Conn.Execute(vQuery)
		 

		If RS.EOF Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
			vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Org.GetReportGroupName, ReasonSummary.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function
		Else
			vReportGroupName = RS("WebReportGroupName")
			Set RS = Nothing
		End If

		vReportTitle = vReportGroupName
	
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
		vErrorMsg = vErrorMsg & "Error:     (-1, ReasonSummary.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function

	End if
	
	vQuery = "sps_OrganizationTimeZone " & pvUserOrgID
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing

	ExecuteMain = True

End Function%>


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
Sub MakeQueryString(pvIn, pvOut)
	Dim xxx
	pvOut = ""
	For xxx=1 TO Len(pvIn)
		If Mid(pvIn,xxx,1) = " " Then
			pvOut = pvOut & "_"
		Else
			pvOut = pvOut & Mid(pvIn,xxx,1)
		End If
	Next
End Sub

Function intPrintColumnHeader(txtColumns)
	%>
		<IMG SRC="/loginstatline/images/redline.jpg" ALIGN=CENTER HEIGHT=2 WIDTH="100%" ></IMG>
		
		<TABLE BORDER=0 WIDTH="100%" RULES="NONE" FRAME="VOID" cellPadding="0" cellSpacing="0">
		<TR>
		
	<%
	For i = 0 to Ubound(txtColumns,1)
	%>
			<TD WIDTH="7%" ><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=txtColumns(i)%></FONT></B></TD>
			<% If i > 0 Then %>
			<TD WIDTH="8%"><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"></FONT></B></TD>
			<% End IF %>
	<%
	Next
	%>
		
		</TR>
		<TR>
			<TD COLSPAN=13 ><HR ALIGN=CENTER color=Black NOSHADE SIZE=1 ></HR></TD>
		</TR>
	<%
	'reset txtColumns array
	For i = 0 to Ubound(txtColumns,1)
		txtColumns(i) = ""
	Next

End Function

Function intPrintRows(txtRow(),FontBold,txtLink())
	%>	
	<TR>
		<TD WIDTH="15%" ALIGN=LEFT >
			<%IF FontBold = 0 Then Response.Write("<B>")Else Response.Write(" &nbsp &nbsp ") End If %>
			<FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=txtRow(0)%></FONT>
			<%IF FontBold = 0 Then Response.Write("</B>")End If%>
		</TD>
		
		<TD WIDTH="3%" ALIGN=LEFT >
			<%IF FontBold = 0 Then Response.Write("<B>")End If %>
			<%IF txtLink(1) <> "" Then %> <A target="ReferralSummary" HREF="/loginstatline/reports/referral/summary_A.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvOrgID%>&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&DSN=Production<%=txtLink(1)%>"><%End If%>
			<FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=txtRow(1)%></FONT>
			<%IF txtLink(1) <> "" Then %> </A> <%End If%>
			<%IF FontBold = 0 Then Response.Write("</B>")End If%>
		</TD>
		
		
		<%
		If txtRow(2) <> "" Then
			If txtRow(2) = 0 then
				vPercentage = "0%"
			Else
				vPercentage = FormatNumber(txtRow(2),1) & "%"
			End if
		Else
			vPercentage = ""
		End if
		%>
		<TD WIDTH="5%" ALIGN=LEFT >
			<%IF FontBold = 0 Then Response.Write("<B>")End If %>
			<FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=vPercentage%></FONT>
			<%IF FontBold = 0 Then Response.Write("</B>")End If%>
		</TD>
	
	</TR>	
	<%	
	'reset txtRow Array
	For i = 0 to Ubound(txtRow,1)
		txtRow(i) = ""
		txtLink(i) = ""
	Next
End Function
Function intDefaultHeader()
	Call intPrintColumnHeader(txtColumns)
End Function			

Function intCalcPercentage(intTopNumber, intBottomNumber)
	'Response.Write (".. " & intTopNumber & " .. " & intBottomNumber & " .." ) 
	If intTopNumber = "" or intTopNumber = 0 Then
		intCalcPercentage = 0
	End if
	
	If intBottomNumber = "" or intBottomNumber = 0 then
		intCalcPercentage = "-"
	Else 
		intCalcPercentage = (intTopNumber / intBottomNumber) * 100
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

'End Function Section
%>
