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
Dim txtColumns(4)
Dim txtRow(5)
Dim txtLink(5)
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
Dim pvOrgType
Dim pvOrgTypeReportDesc
Dim pvOrgTypeDbDesc
Dim pvPageBreak
Dim pvThisOrgID
Dim AllReferrals
Dim PotentialDonors
Dim TotalConsented
Dim ActualRecovered
Dim PreReferralApproach
Dim iOrgRow
Dim DebugMode
Dim sImmedQuery
Dim pvAnd
Dim pvCallId
Dim ImmedRS
Dim vTotalConsented
Dim vActualRecovered
Dim vPreReferral
Dim RptRs


DebugMode = True

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


<BODY bgColor="#F5EBDD">

<!-- Include any files here  -->
<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 
<!--#include virtual="/loginstatline/includes/QueryReferralSummaryCounter.sls"--> 


<%'Execute the main page generating routine
If AuthorizeMain Then

	' Display all Form and QueryString variables when DebugMode is on.
	If DebugMode = True Then
	    Response.Write "<br>"
	    Dim strItem
	    Response.Write "<b>FORM VARS</b><br>"
	    For Each strItem In Request.Form
	        Response.Write "<br>" & strItem & " = " 
	        Response.Write Request.Form(strItem) & vbCrLf
	    Next
	    Response.Write "<br><br>"
	    Response.Write "<b>QUERYSTRING VARS</b><br>"
	    For Each strItem In Request.QueryString
	        Response.Write "<br>" & strItem & " = " 
	        Response.Write Request.QueryString(strItem) & vbCrLf
	    Next
	    Response.Write "<br><br><br>"    
	End If	


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
	
		If pvPageBreak <> 1 Then %>	
		<!-- Print Report Header -->
		<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->
		
		<% End If
			
		DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	
			
		vQuery = "EXEC sps_ReferralAnalysis	" & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID & ", '" & pvOrgType & "', " & pvPageBreak & " "
		
		Set RptRs = Conn.Execute(vQuery)
				
			
			
			
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
			If pvPageBreak <> 1 Then  ' Display totals, not broken down by Organization, or for a single Organization
			
				'****START SECTION 1************************************************
				'1/16/04 mds: Start section 1 - All Referrals
				DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	
				DWCmd.CommandText = "sps_NWLEB_1_AllReferrals2 "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID & ", " & pvPageBreak
				'Response.Write DWCmd.CommandText
				Set DWRs = DWCmd.Execute

				txtColumns(0)= "1 - All Referrals"			
				Call intDefaultHeader()
				
				txtRow(0) = "&nbsp;"
				txtRow(1) = "&nbsp;"
				txtRow(2) = "Non Registry"
				txtRow(3) = "Registry"
				txtRow(4) = "Total"
				Call intPrintRows(txtRow,0,txtLink)				

				txtRow(0) = "All referrals"
				txtRow(1) = PvUnAppropriate + pvAppropriate
				txtLink(1) = "&Options=&ReportID=9&NoLog=1"
				txtRow(2) = RptRs("AllReferralsNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1"
				txtRow(3) = RptRs("AllReferralsReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1"
				txtRow(4) = CInt(RptRs("AllReferralsNoReg")) + CInt(RptRs("AllReferralsReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1"				
				Call intPrintRows(txtRow,0,txtLink)

				pvTotals(5) = DWRs("Appropriate" & Replace(pvOrgTypeDbDesc, "Trans", ""))
				pvTotals(11) = DWRs("Appropriate" & Replace(pvOrgTypeDbDesc, "Trans", "") & "Unappropriate")
				vTotalRO = 0

				txtRow(0) = "Age"
				txtRow(1) = DWRs("Appropriate" & Replace(pvOrgTypeDbDesc, "Trans", "") & "Age")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_2"
				txtRow(2) = RptRs("AgeRONoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_2_AND_RegistryStatus_NOT_IN_(1,2,4)"
				txtRow(3) = RptRs("AgeROReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_2_AND_RegistryStatus_IN_(1,2,4)"
				vTotalRO = vTotalRO + txtRow(1) 
				txtRow(4) = CInt(RptRs("AgeRONoReg")) + CInt(RptRs("AgeROReg")) 
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_2"				
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "High Risk"
				txtRow(1) = DWRs("Appropriate" & Replace(pvOrgTypeDbDesc, "Trans", "") & "HighRisk")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_3"
				txtRow(2) = RptRs("HighRiskNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_3_AND_RegistryStatus_NOT_IN_(1,2,4)"
				txtRow(3) = RptRs("HighRiskReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_3"
				txtRow(4) = Cint(RptRs("HighRiskNoReg")) + CInt(RptRs("HighRiskReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_3_AND_RegistryStatus_IN_(1,2,4)"
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "Med RO"
				txtRow(1) = DWRs("Appropriate" & Replace(pvOrgTypeDbDesc, "Trans", "") & "MedRO")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_4"
				txtRow(2) = RptRs("MedRONoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_4_AND_RegistryStatus_NOT_IN_(1,2,4)"
				txtRow(3) = RptRs("MedROReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_4_AND_RegistryStatus_IN_(1,2,4)"
				txtRow(4) = Cint(RptRs("MedRONoReg")) + CInt(RptRs("MedROReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_4"
				vTotalRO = vTotalRO + txtRow(1)  
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "Not Appropriate"
				txtRow(1) = DWRs("Appropriate" & Replace(pvOrgTypeDbDesc, "Trans", "") & "NtAppropriate")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_5"
				txtRow(2) = RptRs("NotAppropNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_5_AND_RegistryStatus_NOT_IN_(1,2,4)"
				txtRow(3) = RptRs("NotAppropReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_5_AND_RegistryStatus_IN_(1,2,4)"
				txtRow(4) = CInt(RptRs("NotAppropNoReg")) + CInt(RptRs("NotAppropReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_5"				
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)

				If pvOrgType = "O" Then
					txtRow(0) = "Previous Vent"
					txtRow(1) = DWRs("Appropriate" & Replace(pvOrgTypeDbDesc, "Trans", "") & "PreviousVent")
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_6"
					txtRow(2) = RptRs("PreviousVentNoReg")
					txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_6_AND_RegistryStatus_NOT_IN_(1,2,4)"
					txtRow(3) = RptRs("PreviousVentReg")
					txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_6_AND_RegistryStatus_IN_(1,2,4)"					
					txtRow(4) = CInt(RptRs("PreviousVentNoReg")) + CInt(RptRs("PreviousVentReg"))
					txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_6"					
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)
				End if

				txtRow(0) = "Potential Donors"
				txtRow(1) = (PvUnAppropriate + pvAppropriate) - vTotalRO 
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_NOT_IN_(2,3,4,5,6)"
				txtRow(2) = RptRs("PotentialNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_NOT_IN_(2,3,4,5,6)_AND_RegistryStatus_NOT_IN_(1,2,4)"
				txtRow(3) = RptRs("PotentialReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_NOT_IN_(2,3,4,5,6)_AND_RegistryStatus_IN_(1,2,4)"
				txtRow(4) = CInt(RptRs("PotentialNoReg")) + CInt(RptRs("PotentialReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_NOT_IN_(2,3,4,5,6)"
				vPotentialDonors = txtRow(1)
				Call intPrintRows(txtRow,0,txtLink)

				'Print End of Table

				DWCmd.ActiveConnection = Nothing
				'****END SECTION 1************************************************
				%>
				</Table>
				<%

				'****START SECTION 2************************************************
				'Print Potential Donor Data
				DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
				DWCmd.CommandText = "sps_NWLEB_2_PotentialDonors2 "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID & ", " & pvPageBreak & ", '" & pvOrgType & "' "
				Set DWRs = DWCmd.Execute
				txtColumns(0)= "2 - Potential " & pvOrgTypeReportDesc & " Donors"			
				Call intDefaultHeader()

				'Reset pvTotals
				pvTotals(5) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", ""))
				pvTotals(11) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "NotApproached")
				vTotalRO = 0
				
				txtRow(0) = "&nbsp;"
				txtRow(1) = "&nbsp;"
				txtRow(2) = "Non Registry"
				txtRow(3) = "Registry"
				txtRow(4) = "Total"
				Call intPrintRows(txtRow,0,txtLink)				

				txtRow(0) = "Potential Donors"
				txtRow(1) = vPotentialDonors
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_NOT_IN_(2,3,4,5,6)"
				txtRow(2) = RptRs("PotentialNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_NOT_IN_(2,3,4,5,6)_AND_RegistryStatus_NOT_IN_(1,2,4)"
				txtRow(3) = RptRs("PotentialReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_NOT_IN_(2,3,4,5,6)_AND_RegistryStatus_IN_(1,2,4)"
				txtRow(4) = CInt(RptRs("PotentialNoReg")) + CInt(RptRs("PotentialReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_NOT_IN_(2,3,4,5,6)"				
				Call intPrintRows(txtRow,0,txtLink)
				
				txtRow(0) = "Pending Referrals"  
				txtRow(1) = DWRs("PendingCount")
				' Note:  This link differs from the others on the page, so it is formatted differently
				pvThisOrgID = pvOrgId
				txtLink(1) = "PEND"
				txtRow(2) = RptRs("PendingNoReg")
				' Note:  This link differs from the others on the page, so it is formatted differently
				pvThisOrgID = pvOrgId
				txtLink(2) = "PEND"
				txtRow(3) = RptRs("PendingReg")
				' Note:  This link differs from the others on the page, so it is formatted differently
				pvThisOrgID = pvOrgId
				txtLink(3) = "PEND"	
				txtRow(4) = CInt(RptRs("PendingNoReg")) + CInt(RptRs("PendingNoReg"))
				' Note:  This link differs from the others on the page, so it is formatted differently
				pvThisOrgID = pvOrgId
				txtLink(4) = "PEND"					
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "Unknown"
				txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "Unknown")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_2_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				txtRow(2) = RptRs("UnknownNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_2_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
				txtRow(3) = RptRs("UnknownReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_2_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
				txtRow(4) = Cint(RptRs("UnknownNoReg")) + Cint(RptRs("UnknownReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_2_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"				
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "Family Unavail."
				txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "FamilyUnavail")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_3_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				txtRow(2) = RptRs("FamUnavailNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_3_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
				txtRow(3) = RptRs("FamUnavailReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_3_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
				txtRow(4) = CInt(RptRs("FamUnavailNoReg")) + CInt(RptRs("FamUnavailReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_3_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"		
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "Coroner RuleOut"
				txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "CoronerRuleout")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_4_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				txtRow(2) = RptRs("CoronerRONoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_4_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
				txtRow(3) = RptRs("CoronerROReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_4_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
				txtRow(4) = CInt(RptRs("CoronerRONoReg")) + CInt(RptRs("CoronerROReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_4_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"				
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "Med RO"
				txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "MedRO")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_6_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				txtRow(2) = RptRs("MedApproachNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_6_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
				txtRow(3) = RptRs("MedApproachReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_6_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
				txtRow(4) = CInt(RptRs("MedApproachNoReg")) + CInt(RptRs("MedApproachReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_6_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "Time/Logistics"
				txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "TimeLogistics")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_7_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				txtRow(2) = RptRs("TimeNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_7_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
				txtRow(3) = RptRs("TimeReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_7_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
				txtRow(4) = CInt(RptRs("TimeNoReg")) + CInt(RptRs("TimeReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_7_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				vTotalRO = vTotalRO + txtRow(1)  
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "High Risk"
				txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "HighRisk")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_9_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				txtRow(2) = RptRs("HighRiskApproachNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_9_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
				txtRow(3) = RptRs("HighRiskApproachReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_9_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
				txtRow(4) = CInt(RptRs("HighRiskApproachNoReg")) + CInt(RptRs("HighRiskApproachReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_9_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				vTotalRO = vTotalRO + txtRow(1) 
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "Unapproachable"
				txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "Unapproachable")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_11_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				txtRow(2) = RptRs("UnapproachNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_11_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
				txtRow(3) = RptRs("UnapproachReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_11_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
				txtRow(4) = CInt(RptRs("UnapproachNoReg")) + CInt(RptRs("UnapproachReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_11_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				vTotalRO = vTotalRO + txtRow(1)  
				Call intPrintRows(txtRow,1,txtLink)

				If pvOrgType = "O" Then
					txtRow(0) = "Arrest"
					txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "Arrest")
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_5_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
					txtRow(2) = RptRs("ArrestNoReg")
					txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_5_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
					txtRow(3) = RptRs("ArrestReg")
					txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_5_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
					txtRow(4) = CInt(RptRs("ArrestNoReg")) + CInt(RptRs("ArrestReg"))
					txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_5_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)
				End if

				If pvOrgType = "O" Then
					txtRow(0) = "Never Brain Dead"
					txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "NeverBrainDead")
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_8_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
					txtRow(2) = RptRs("NeverBrainDeadNoReg")
					txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_8_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
					txtRow(3) = RptRs("NeverBrainDeadReg")
					txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_8_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
					txtRow(4) = CInt(RptRs("NeverBrainDeadNoReg")) + CInt(RptRs("NeverBrainDeadReg"))
					txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_8_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"

					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)
				End if

'				If pvOrgType = "O" Then
'					txtRow(0) = "Secondary RO"
'					txtRow(1) = DWRs("Approach" & Replace(pvOrgTypeDbDesc, "Trans", "") & "SecondaryRO")
'					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_14_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
'					vTotalRO = vTotalRO + txtRow(1) 
'					Call intPrintRows(txtRow,1,txtLink)
'				End if

				txtRow(0) = "Actual Approached"
				
				' Prepare the AND statement and call GetSummaryCount() to get accurate count for link.  2/10/05 - SAP
				pvAnd = "AND Referral" & pvOrgTypeDbDesc & "ApproachID IN (1,12,13)"
				sImmedQuery = "/* Single-Page Actual Approached */ " & GetSummaryCount()
				'DebugPrint(sImmedQuery)
				Set ImmedRS = Conn.Execute(sImmedQuery)
				txtRow(1) = ImmedRS("Ctr")
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_IN_(1,12,13)"
				txtRow(2) = RptRs("ActualApproachedNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_IN_(1,12,13)_AND_RegistryStatus_NOT_IN_(1,2,4)"
				txtRow(3) = RptRs("ActualApproachedReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_IN_(1,12,13)_AND_RegistryStatus_IN_(1,2,4)"
				txtRow(4) = CInt(RptRs("ActualApproachedNoReg")) + CInt(RptRs("ActualApproachedReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_IN_(1,12,13)"

				vActualApproached = txtRow(1)
				Call intPrintRows(txtRow,0,txtLink)

				DWCmd.ActiveConnection = Nothing
				%>
				</Table>
				<%
				'****END SECTION 2**************************************************


				'****START SECTION 3************************************************
				'Print Total Consented data
				
				'Uses logic from Summary_A.sls to make sure the numbers match
				pvAnd = " AND Referral" & pvOrgTypeDbDesc & "ConsentID = 1 AND Referral" & pvOrgTypeDbDesc & "ApproachID = 1 AND Referral" & pvOrgTypeDbDesc & "AppropriateID = 1 "
				sImmedQuery = "/* Single-Page Total Consent */ " & GetSummaryCount()
				'DebugPrint(sImmedQuery)
				Set ImmedRS = Conn.Execute(sImmedQuery)
				vTotalConsented = ImmedRS("Ctr")
				ImmedRS.Close
				
				txtColumns(0)= "3 - Total Consent"			
				Call intDefaultHeader()

				txtRow(0) = "&nbsp;"
				txtRow(1) = "&nbsp;"
				txtRow(2) = "Non Registry"
				txtRow(3) = "Registry"
				txtRow(4) = "Total"
				Call intPrintRows(txtRow,0,txtLink)				

				txtRow(0) = "Total consented"
				txtRow(1) = vTotalConsented
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ConsentID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				txtRow(2) = RptRs("ConsentNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ConsentID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
				txtRow(3) = RptRs("ConsentReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ConsentID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
				txtRow(4) = CInt(RptRs("ConsentNoReg")) + CInt(RptRs("ConsentReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ConsentID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				Call intPrintRows(txtRow,1,txtLink)

				txtRow(0) = "Actual consent rate"
				txtRow(1) = vTotalConsented & "/" & vActualApproached & ": "
				txtRow(2) = RptRs("ConsentNoReg") & "/" & RptRs("ActualApproachedNoReg")
				txtRow(3) = RptRs("ConsentReg") & "/" & RptRs("ActualApproachedReg")
				txtRow(4) = CInt(RptRs("ConsentNoReg")) + CInt(RptRs("ConsentReg")) & "/" & CInt(RptRs("ActualApproachedNoReg")) + CInt(RptRs("ActualApproachedReg"))
				txtRow(5) = intCalcPercentage(vTotalConsented,vActualApproached)
				Call intPrintRows(txtRow,1,txtLink)

				DWCmd.ActiveConnection = Nothing
				%>
				</Table>
				<%
				'****END SECTION 3*************************************************

				'****START SECTION 4***********************************************
				'Print Actual Recovered data
				
				'Uses logic from Summary_A.sls to make sure the numbers match
				pvAnd = " AND Referral" & pvOrgTypeDbDesc & "ConversionID = 1 AND Referral" & pvOrgTypeDbDesc & "ConsentID = 1 AND Referral" & pvOrgTypeDbDesc & "ApproachID = 1 AND Referral" & pvOrgTypeDbDesc & "AppropriateID = 1 "
				sImmedQuery = "/* Single-Page Actual Recovered */ " & GetSummaryCount()
				'DebugPrint(sImmedQuery)
				Set ImmedRS = Conn.Execute(sImmedQuery)
				vActualRecovered = ImmedRS("Ctr")
				ImmedRS.Close
				
				txtColumns(0)= "4 - Actual Recovered"			
				Call intDefaultHeader()
				
				txtRow(0) = "&nbsp;"
				txtRow(1) = "&nbsp;"
				txtRow(2) = "Non Registry"
				txtRow(3) = "Registry"
				txtRow(4) = "Total"
				Call intPrintRows(txtRow,0,txtLink)				

				txtRow(0) = "Actual recovered"
				txtRow(1) = vActualRecovered
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ConversionID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ConsentID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				txtRow(2) = RptRs("RecoveredNoReg")
				txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ConversionID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ConsentID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_NOT_IN_(1,2,4)_"
				txtRow(3) = RptRs("RecoveredReg")
				txtLink(3) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ConversionID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ConsentID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_AND_RegistryStatus_IN_(1,2,4)_"
				txtRow(4) = CInt(RptRs("RecoveredNoReg")) + CInt(RptRs("RecoveredReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ConversionID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ConsentID_=_1_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1_AND_Referral" & pvOrgTypeDbDesc & "AppropriateID_=_1_"
				Call intPrintRows(txtRow,1,txtLink)

				DWCmd.ActiveConnection = Nothing
				%>
				</Table>
				<%
				'****END SECTION 4************************************************

				'****START SECTION 5**********************************************
				'Print Pre-Referral Approach data
				
				'Uses logic from Summary_A.sls to make sure the numbers match
				pvAnd = " AND ReferralApproachTypeID IN (2,3) AND Referral" & pvOrgTypeDbDesc & "ApproachID = 1"
				sImmedQuery = "/* Single-Page Pre-Referral Approach */ " & GetSummaryCount()
				'DebugPrint(sImmedQuery)
				Set ImmedRS = Conn.Execute(sImmedQuery)
				vPreReferral = ImmedRS("Ctr")
				ImmedRS.Close
				
				txtColumns(0)= "5 - Pre-Referral Approach"			
				Call intDefaultHeader()
				
				txtRow(0) = "&nbsp;"
				txtRow(1) = "&nbsp;"
				txtRow(2) = "Non Registry"
				txtRow(3) = "Registry"
				txtRow(4) = "Total"
				Call intPrintRows(txtRow,0,txtLink)				

				txtRow(0) = "Pre-referral approach"
				txtRow(1) = vPreReferral & "</a>/" & vActualApproached & ": "
				txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralApproachTypeID_IN_(2,3)_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1"
				txtRow(2) = RptRs("PreReferralApproachNoReg") & "/" & RptRs("ActualApproachedNoReg")
				txtRow(3) = RptRs("PreReferralApproachReg") & "/" & RptRs("ActualApproachedReg")
				txtRow(4) = CInt(RptRs("PreReferralApproachNoReg")) + CInt(RptRs("PreReferralApproachReg")) & "</a>/" & Cint(RptRs("ActualApproachedNoReg")) + Cint(RptRs("ActualApproachedReg"))
				txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralApproachTypeID_IN_(2,3)_AND_Referral" & pvOrgTypeDbDesc & "ApproachID_=_1"
				'''txtRow(5) = intCalcPercentage(vPreReferral,vActualApproached) 
				txtRow(5) = intCalcPercentage(CInt(RptRs("PreReferralApproachNoReg")) + CInt(RptRs("PreReferralApproachReg")) ,Cint(RptRs("ActualApproachedNoReg")) + Cint(RptRs("ActualApproachedReg")))
				Call intPrintRows(txtRow,1,txtLink)


				DWCmd.ActiveConnection = Nothing
				'****END SECTION 5************************************************
				%>
				</Table>
				
		<%	Else   ' If pvPageBreak = 1 Display with page breaks at each organization 
		
				' First, grab the data for each section, storing it in arrays using GetRecords
				' *** Grab SECTION 1 Data *******************
				' All Referrals Data
				DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	
				DWCmd.CommandText = "sps_NWLEB_1_AllReferrals2 "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID & ", " & pvPageBreak
				Set DWRs = DWCmd.Execute
				AllReferrals = DWRs.GetRows
				DWCmd.ActiveConnection = Nothing
				
				' Set Constants to allow easier recall of array contents
				Dim COL1_AppropriateEyes, COL1_AppropriateEyesUnappropriate, COL1_AppropriateEyesAge, COL1_AppropriateEyesHighRisk, COL1_AppropriateEyesMedRO, COL1_AppropriateEyesNtAppropriate, COL1_AppropriateEyesPreviousVent, COL1_AllReferralsOrgId, COL1_AllReferralsOrgName
				Dim COL1_AppropriateTissue, COL1_AppropriateTissueUnappropriate, COL1_AppropriateTissueAge, COL1_AppropriateTissueHighRisk, COL1_AppropriateTissueMedRO, COL1_AppropriateTissueNtAppropriate, COL1_AppropriateTissuePreviousVent
				Dim COL1_AppropriateOrgan, COL1_AppropriateOrganUnappropriate, COL1_AppropriateOrganAge, COL1_AppropriateOrganHighRisk, COL1_AppropriateOrganMedRO, COL1_AppropriateOrganNtAppropriate, COL1_AppropriateOrganPreviousVent, COL1_AllReferralsTotal
				' Eyes
				COL1_AppropriateEyes = 0
				COL1_AppropriateEyesUnappropriate = 1
				COL1_AppropriateEyesAge = 2 
				COL1_AppropriateEyesHighRisk = 3
				COL1_AppropriateEyesMedRO = 4
				COL1_AppropriateEyesNtAppropriate = 5
				COL1_AppropriateEyesPreviousVent = 6
				' Tissue
				COL1_AppropriateTissue = 7
				COL1_AppropriateTissueUnappropriate = 8
				COL1_AppropriateTissueAge = 9 
				COL1_AppropriateTissueHighRisk = 10
				COL1_AppropriateTissueMedRO = 11
				COL1_AppropriateTissueNtAppropriate = 12
				COL1_AppropriateTissuePreviousVent = 13
				'Organs
				COL1_AppropriateOrgan = 14
				COL1_AppropriateOrganUnappropriate = 15
				COL1_AppropriateOrganAge = 16
				COL1_AppropriateOrganHighRisk = 17
				COL1_AppropriateOrganMedRO = 18
				COL1_AppropriateOrganNtAppropriate = 19
				COL1_AppropriateOrganPreviousVent = 20
				' Organization Info
				COL1_AllReferralsOrgName = 21
				COL1_AllReferralsOrgId = 22
				' All Referrals Total
				COL1_AllReferralsTotal = 23
				
				' *** End SECTION 1 Data *******************
				
				' *** Grab SECTION 2 Data *******************
				' Potential Donor Data
				DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
				DWCmd.CommandText = "sps_NWLEB_2_PotentialDonors2 "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID & ", " & pvPageBreak & ", '" & pvOrgType & "' "
				Set DWRs = DWCmd.Execute
				PotentialDonors = DWRs.GetRows			
				DWCmd.ActiveConnection = Nothing		
							
				Dim COL2_ApproachEyes, COL2_ApproachEyesNotApproached, COL2_ApproachEyesUnknown, COL2_ApproachEyesFamilyUnavail, COL2_ApproachEyesCoronerRuleout, COL2_ApproachEyesMedRO, COL2_ApproachEyesTimeLogistics, COL2_ApproachEyesHighRisk, COL2_ApproachEyesUnapproachable, COL2_ApproachEyesArrest, COL2_ApproachEyesNeverBrainDead, COL2_ApproachEyesSecondaryRO, COL2_AppropriateRO, COL2_PotentialDonorsOrgId, COL2_PotentialDonorsOrgName
				Dim COL2_ApproachTissue, COL2_ApproachTissueNotApproached, COL2_ApproachTissueUnknown, COL2_ApproachTissueFamilyUnavail, COL2_ApproachTissueCoronerRuleout, COL2_ApproachTissueMedRO, COL2_ApproachTissueTimeLogistics, COL2_ApproachTissueHighRisk, COL2_ApproachTissueUnapproachable, COL2_ApproachTissueArrest, COL2_ApproachTissueNeverBrainDead, COL2_ApproachTissueSecondaryRO
				Dim COL2_ApproachOrgan, COL2_ApproachOrganNotApproached, COL2_ApproachOrganUnknown, COL2_ApproachOrganFamilyUnavail, COL2_ApproachOrganCoronerRuleout, COL2_ApproachOrganMedRO, COL2_ApproachOrganTimeLogistics, COL2_ApproachOrganHighRisk, COL2_ApproachOrganUnapproachable, COL2_ApproachOrganArrest, COL2_ApproachOrganNeverBrainDead, COL2_ApproachOrganSecondaryRO, COL2_PendingCount

				' Eyes
				COL2_ApproachEyes = 0
				COL2_ApproachEyesNotApproached = 1
				COL2_ApproachEyesUnknown = 2
				COL2_ApproachEyesFamilyUnavail = 3
				COL2_ApproachEyesCoronerRuleout = 4
				COL2_ApproachEyesArrest = 5
				COL2_ApproachEyesMedRO = 6
				COL2_ApproachEyesTimeLogistics = 7
				COL2_ApproachEyesNeverBrainDead = 8
				COL2_ApproachEyesHighRisk = 9
				COL2_ApproachEyesUnapproachable = 10
				COL2_AppropriateRO = 11
				COL2_ApproachEyesSecondaryRO = 12
				' Tissue
				COL2_ApproachTissue = 13
				COL2_ApproachTissueNotApproached = 14
				COL2_ApproachTissueUnknown = 15
				COL2_ApproachTissueFamilyUnavail = 16
				COL2_ApproachTissueCoronerRuleout = 17
				COL2_ApproachTissueArrest = 18
				COL2_ApproachTissueMedRO = 19
				COL2_ApproachTissueTimeLogistics = 20
				COL2_ApproachTissueNeverBrainDead =21
				COL2_ApproachTissueHighRisk = 22
				COL2_ApproachTissueUnapproachable = 23
				COL2_ApproachTissueSecondaryRO = 24
				' Organs
				COL2_ApproachOrgan = 25
				COL2_ApproachOrganNotApproached = 26
				COL2_ApproachOrganUnknown = 27
				COL2_ApproachOrganFamilyUnavail = 28
				COL2_ApproachOrganCoronerRuleout = 29
				COL2_ApproachOrganArrest = 30
				COL2_ApproachOrganMedRO = 31
				COL2_ApproachOrganTimeLogistics = 32
				COL2_ApproachOrganNeverBrainDead = 33
				COL2_ApproachOrganHighRisk = 34
				COL2_ApproachOrganUnapproachable = 35
				COL2_ApproachOrganSecondaryRO = 36
				' Organization Info
				COL2_PotentialDonorsOrgId = 37
				COL2_PotentialDonorsOrgName = 38
				COL2_PendingCount = 39
				
				' *** End SECTION 2 Data *******************
				
				' *** Grab SECTION 3 Data *******************
				' Total Consented data
				DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
				DWCmd.CommandText = "sps_NWLEB_3_TotalConsented2 "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID & ", " & pvPageBreak
				Set DWRs = DWCmd.Execute	
				TotalConsented = DWRs.GetRows			
				DWCmd.ActiveConnection = Nothing
				
				Dim COL3_ConsentEyes, COL3_TotalConsentedOrgId, COL3_TotalConsentedOrgName, COL3_ConsentTissue, COL3_ConsentOrgans
				
				COL3_ConsentEyes = 0
				COL3_ConsentTissue = 1
				COL3_ConsentOrgans = 2
				COL3_TotalConsentedOrgId = 3
				COL3_TotalConsentedOrgName = 4
				
				' *** End SECTION 3 Data *******************
				
				' *** Grab SECTION 4 Data *******************
				' Actual Recovered data
				DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
				DWCmd.CommandText = "sps_NWLEB_4_ActualRecovered2 "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID & ", " & pvPageBreak
				Set DWRs = DWCmd.Execute
				ActualRecovered = DWRs.GetRows			
				DWCmd.ActiveConnection = Nothing
				
				Dim COL4_ConversionEyes, COL4_ActualRecoveredOrgId, COL4_ActualRecoveredOrgName, COL4_ConversionTissue, COL4_ConversionOrgans
				
				COL4_ConversionEyes = 0
				COL4_ConversionTissue = 1
				COL4_ConversionOrgans = 2
				COL4_ActualRecoveredOrgId = 3
				COL4_ActualRecoveredOrgName = 4
				
				' *** End SECTION 4 Data *******************
				
				' *** Grab SECTION 5 Data *******************
				' Pre-Referral Approach data
				DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
				DWCmd.CommandText = "sps_NWLEB_5_PreReferralApproach2 "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID & ", " & pvPageBreak
				Set DWRs = DWCmd.Execute
				PreReferralApproach = DWRs.GetRows			
				DWCmd.ActiveConnection = Nothing
				
				Dim COL5_PreApproachEyes, COL5_PreReferralApproachOrgId, COL5_PreReferralApproachOrgName, COL5_PreApproachTissue, COL5_PreApproachOrgans
				
				COL5_PreApproachEyes = 0
				COL5_PreApproachTissue = 1
				COL5_PreApproachOrgans = 2
				COL5_PreReferralApproachOrgId = 3
				COL5_PreReferralApproachOrgName = 4
				
				' *** End SECTION 5 Data *******************
				
				
				' Now, display all pages by walking through the arrays
				For iOrgRow = LBound(AllReferrals, 2) To UBound(AllReferrals, 2)

				   Response.Write "<!-- iOrgRow: " & Cstr(iOrgRow) & " -->"
				   
				   	'Set Title Values for individual Organizations	
					vMainTitle = "Referral Analysis by Organization"	
				  	vTitlePeriod = DateLiteral(pvStartDate)
				   	vTitleTo = DateLiteral(pvEndDate)
				   	vTitleTimes = "All Times " & ZoneName(vTZ)
				   	vReportTitle = AllReferrals(COL1_AllReferralsOrgName, iOrgRow)
				   	
				   	%>	
				   	<!-- Print Report Header -->
					<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->
				   
				   
				   	<%
					'**** Display SECTION 1 ************************************************

					DebugPrint(" 1 >> " & AllReferrals(COL1_AllReferralsOrgId, iOrgRow) & " " & AllReferrals(COL1_AllReferralsOrgName, iOrgRow))
					txtColumns(0)= "1 - All Referrals "
					' Reset the global pvOrgID variable
					pvOrgID = AllReferrals(COL1_AllReferralsOrgId, iOrgRow)
					Call intDefaultHeader()

					txtRow(0) = "All referrals"
					txtRow(1) = AllReferrals(COL1_AllReferralsTotal, iOrgRow)					
					txtLink(1) = "&Options=&ReportID=9&NoLog=1"

					Call intPrintRows(txtRow,0,txtLink)
					
					Select Case pvOrgType
						Case "E"
							pvTotals(5) = AllReferrals(COL1_AppropriateEyes, iOrgRow)
							pvTotals(11) = AllReferrals(COL1_AppropriateEyesUnappropriate, iOrgRow)
						Case "T"
							pvTotals(5) = AllReferrals(COL1_AppropriateTissue, iOrgRow)
							pvTotals(11) = AllReferrals(COL1_AppropriateTissueUnappropriate, iOrgRow)
						Case "O"
							pvTotals(5) = AllReferrals(COL1_AppropriateOrgan, iOrgRow)
							pvTotals(11) = AllReferrals(COL1_AppropriateOrganUnappropriate, iOrgRow)
					End Select
					vTotalRO = 0

					txtRow(0) = "Age"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = AllReferrals(COL1_AppropriateEyesAge, iOrgRow)
						Case "T"
							txtRow(1) = AllReferrals(COL1_AppropriateTissueAge, iOrgRow)
						Case "O"
							txtRow(1) = AllReferrals(COL1_AppropriateOrganAge, iOrgRow)
					End Select					
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_2"
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "High Risk"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = AllReferrals(COL1_AppropriateEyesHighRisk, iOrgRow)
						Case "T"
							txtRow(1) = AllReferrals(COL1_AppropriateTissueHighRisk, iOrgRow)
						Case "O"
							txtRow(1) = AllReferrals(COL1_AppropriateOrganHighRisk, iOrgRow)
					End Select						
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_3"
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "Med RO"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = AllReferrals(COL1_AppropriateEyesMedRO, iOrgRow)
						Case "T"
							txtRow(1) = AllReferrals(COL1_AppropriateTissueMedRO, iOrgRow)
						Case "O"
							txtRow(1) = AllReferrals(COL1_AppropriateOrganMedRO, iOrgRow)
					End Select					
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_4"
					vTotalRO = vTotalRO + txtRow(1)  
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "Not Appropriate"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = AllReferrals(COL1_AppropriateEyesNtAppropriate, iOrgRow)
						Case "T"
							txtRow(1) = AllReferrals(COL1_AppropriateTissueNtAppropriate, iOrgRow)
						Case "O"
							txtRow(1) = AllReferrals(COL1_AppropriateOrganNtAppropriate, iOrgRow)
					End Select					
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_5"
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)
					
					Select Case pvOrgType
						Case "E"
							If AllReferrals(COL1_AppropriateEyesPreviousVent, iOrgRow) = 0 Then
								'do nothing
							Else	
								txtRow(0) = "Previous Vent"
								txtRow(1) = AllReferrals(COL1_AppropriateEyesPreviousVent, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_6"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if
						Case "T"
							If AllReferrals(COL1_AppropriateTissuePreviousVent, iOrgRow) = 0 Then
								'do nothing
							Else	
								txtRow(0) = "Previous Vent"
								txtRow(1) = AllReferrals(COL1_AppropriateTissuePreviousVent, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_6"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

						Case "O"
							If AllReferrals(COL1_AppropriateOrganPreviousVent, iOrgRow) = 0 Then
								'do nothing
							Else	
								txtRow(0) = "Previous Vent"
								txtRow(1) = AllReferrals(COL1_AppropriateOrganPreviousVent, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_6"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if
					End Select					
					
					txtRow(0) = "Potential Donors"
					txtRow(1) = AllReferrals(COL1_AllReferralsTotal, iOrgRow) - vTotalRO 
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_NOT_IN_(2,3,4,5,6)"
					vPotentialDonors = txtRow(1)
					Call intPrintRows(txtRow,0,txtLink)

					'**** END Display SECTION 1 ************************************************
					%>
					</Table>
					<%
					'**** Display SECTION 2************************************************

					txtColumns(0)= "2 - Potential " & pvOrgTypeReportDesc & " Donors " & DebugPrint(" 2 >> " & PotentialDonors(COL2_PotentialDonorsOrgId, iOrgRow) & " " & PotentialDonors(COL2_PotentialDonorsOrgName, iOrgRow))
					Call intDefaultHeader()

					'Reset pvTotals
					Select Case pvOrgType
						Case "E"
							pvTotals(5) = PotentialDonors(COL2_ApproachEyes, iOrgRow)
							pvTotals(11) = PotentialDonors(COL2_ApproachEyesNotApproached, iOrgRow)
						Case "T"
							pvTotals(5) = PotentialDonors(COL2_ApproachTissue, iOrgRow)
							pvTotals(11) = PotentialDonors(COL2_ApproachTissueNotApproached, iOrgRow)
						Case "O"
							pvTotals(5) = PotentialDonors(COL2_ApproachOrgan, iOrgRow)
							pvTotals(11) = PotentialDonors(COL2_ApproachOrganNotApproached, iOrgRow)
					End Select
					
					vTotalRO = 0

					txtRow(0) = "Potential Donors"
					txtRow(1) = vPotentialDonors
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_NOT_IN_(2,3,4,5,6)"
					Call intPrintRows(txtRow,0,txtLink)
					
					txtRow(0) = "Pending Referrals"   
					txtRow(1) = PotentialDonors(COL2_PendingCount, iOrgRow)
					pvThisOrgID = PotentialDonors(COL2_PotentialDonorsOrgId, iOrgRow)  ' Assign this org's Id to variable for correct Pending Referral link
					txtLink(1) = "PEND" 
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "Unknown"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = PotentialDonors(COL2_ApproachEyesUnknown, iOrgRow)
						Case "T"
							txtRow(1) = PotentialDonors(COL2_ApproachTissueUnknown, iOrgRow)
						Case "O"
							txtRow(1) = PotentialDonors(COL2_ApproachOrganUnknown, iOrgRow)
					End Select
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_2_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "Family Unavail."
					Select Case pvOrgType
						Case "E"
							txtRow(1) = PotentialDonors(COL2_ApproachEyesFamilyUnavail, iOrgRow)
						Case "T"
							txtRow(1) = PotentialDonors(COL2_ApproachTissueFamilyUnavail, iOrgRow)
						Case "O"
							txtRow(1) = PotentialDonors(COL2_ApproachOrganFamilyUnavail, iOrgRow)
					End Select					
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_3_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "Coroner RuleOut"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = PotentialDonors(COL2_ApproachEyesCoronerRuleout, iOrgRow)
						Case "T"
							txtRow(1) = PotentialDonors(COL2_ApproachTissueCoronerRuleout, iOrgRow)
						Case "O"
							txtRow(1) = PotentialDonors(COL2_ApproachOrganCoronerRuleout, iOrgRow)
					End Select					
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_4_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "Med RO"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = PotentialDonors(COL2_ApproachEyesMedRO, iOrgRow)
						Case "T"
							txtRow(1) = PotentialDonors(COL2_ApproachTissueMedRO, iOrgRow)
						Case "O"
							txtRow(1) = PotentialDonors(COL2_ApproachOrganMedRO, iOrgRow)
					End Select
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_6_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "Time/Logistics"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = PotentialDonors(COL2_ApproachEyesTimeLogistics, iOrgRow)
						Case "T"
							txtRow(1) = PotentialDonors(COL2_ApproachTissueTimeLogistics, iOrgRow)
						Case "O"
							txtRow(1) = PotentialDonors(COL2_ApproachOrganTimeLogistics, iOrgRow)
					End Select						
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_7_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
					vTotalRO = vTotalRO + txtRow(1)  
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "High Risk"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = PotentialDonors(COL2_ApproachEyesHighRisk, iOrgRow)
						Case "T"
							txtRow(1) = PotentialDonors(COL2_ApproachTissueHighRisk, iOrgRow)
						Case "O"
							txtRow(1) = PotentialDonors(COL2_ApproachOrganHighRisk, iOrgRow)
					End Select					
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_9_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
					vTotalRO = vTotalRO + txtRow(1) 
					Call intPrintRows(txtRow,1,txtLink)

					txtRow(0) = "Unapproachable"
					Select Case pvOrgType
						Case "E"
							txtRow(1) = PotentialDonors(COL2_ApproachEyesUnapproachable, iOrgRow)
						Case "T"
							txtRow(1) = PotentialDonors(COL2_ApproachTissueUnapproachable, iOrgRow)
						Case "O"
							txtRow(1) = PotentialDonors(COL2_ApproachOrganUnapproachable, iOrgRow)
					End Select					
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_11_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
					vTotalRO = vTotalRO + txtRow(1)  
					Call intPrintRows(txtRow,1,txtLink)


					Select Case pvOrgType
						Case "E"
							If PotentialDonors(COL2_ApproachEyesArrest, iOrgRow) = 0 then
								'do nothing
							Else
								txtRow(0) = "Arrest"
								txtRow(1) = PotentialDonors(COL2_ApproachEyesArrest, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_5_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

							If PotentialDonors(COL2_ApproachEyesNeverBrainDead, iOrgRow) = 0 then
								'do nothing
							Else
								txtRow(0) = "Never Brain Dead"
								txtRow(1) = PotentialDonors(COL2_ApproachEyesNeverBrainDead, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_8_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

							If PotentialDonors(COL2_ApproachEyesSecondaryRO, iOrgRow) = 0 then
								'do nothing
							Else
								txtRow(0) = "Secondary RO"
								txtRow(1) = PotentialDonors(COL2_ApproachEyesSecondaryRO, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_14_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

						Case "T"
							If PotentialDonors(COL2_ApproachTissueArrest, iOrgRow) = 0 then
								'do nothing
							Else
								txtRow(0) = "Arrest"
								txtRow(1) = PotentialDonors(COL2_ApproachTissueArrest, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_5_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

							If PotentialDonors(COL2_ApproachTissueNeverBrainDead, iOrgRow) = 0 then
								'do nothing
							Else
								txtRow(0) = "Never Brain Dead"
								txtRow(1) = PotentialDonors(COL2_ApproachTissueNeverBrainDead, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_8_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

							If PotentialDonors(COL2_ApproachTissueSecondaryRO, iOrgRow) = 0 then
								'do nothing
							Else
								txtRow(0) = "Secondary RO"
								txtRow(1) = PotentialDonors(COL2_ApproachTissueSecondaryRO, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_14_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

						Case "O"
							If PotentialDonors(COL2_ApproachOrganArrest, iOrgRow) = 0 then
								'do nothing
							Else
								txtRow(0) = "Arrest"
								txtRow(1) = PotentialDonors(COL2_ApproachOrganArrest, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_5_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

							If PotentialDonors(COL2_ApproachOrganNeverBrainDead, iOrgRow) = 0 then
								'do nothing
							Else
								txtRow(0) = "Never Brain Dead"
								txtRow(1) = PotentialDonors(COL2_ApproachOrganNeverBrainDead, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_8_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

							If PotentialDonors(COL2_ApproachOrganSecondaryRO, iOrgRow) = 0 then
								'do nothing
							Else
								txtRow(0) = "Secondary RO"
								txtRow(1) = PotentialDonors(COL2_ApproachOrganSecondaryRO, iOrgRow)
								txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_14_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
								vTotalRO = vTotalRO + txtRow(1) 
								Call intPrintRows(txtRow,1,txtLink)
							End if

					End Select					
					
					txtRow(0) = "Actual Approached"
					
					'Uses logic from Summary_A.sls to make sure the numbers match					
					pvAnd = " AND Referral" & pvOrgTypeDbDesc & "ApproachID IN (1,12,13)"
					sImmedQuery = "/* Multi-Page Actual Approached */ " & GetSummaryCount()
					'DebugPrint(sImmedQuery)
					Set ImmedRS = Conn.Execute(sImmedQuery)
					txtRow(1) = ImmedRS("Ctr")
					ImmedRS.Close
					
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & pvOrgTypeDbDesc & "ApproachID_IN_(1,12,13)"
					
					vActualApproached = txtRow(1)
					Call intPrintRows(txtRow,0,txtLink)

					DWCmd.ActiveConnection = Nothing
					%>
					</Table>
					<%
					'****END Display SECTION 2************************************************** 

					'**** Display SECTION 3************************************************
					'Print Total Consented data

					txtColumns(0)= "3 - Total Consent " & DebugPrint(" 3 >> " & TotalConsented(COL3_TotalConsentedOrgId, iOrgRow) & " " & TotalConsented(COL3_TotalConsentedOrgName, iOrgRow))
					Call intDefaultHeader()
					
					'Uses logic from Summary_A.sls to make sure the numbers match
					pvAnd = " AND Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ConsentID = 1 AND Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID = 1 AND Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID = 1 "
					sImmedQuery = "/* Multi-Page Total Consent */ " & GetSummaryCount()
					'DebugPrint(sImmedQuery)
					Set ImmedRS = Conn.Execute(sImmedQuery)
					vTotalConsented = ImmedRS("Ctr")
					ImmedRS.Close

					txtRow(0) = "Total consented"
					txtRow(1) = vTotalConsented				
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ConsentID_=_1_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_1_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
					
					Call intPrintRows(txtRow,1,txtLink)
					
					txtRow(0) = "Actual consent rate"
					txtRow(1) = vTotalConsented & "/" & vActualApproached & ": "
					txtRow(2) = intCalcPercentage(vTotalConsented,vActualApproached)				
					
					Call intPrintRows(txtRow,1,txtLink)

					DWCmd.ActiveConnection = Nothing
					%>
					</Table>
					<%
					'****END Display SECTION 3*************************************************
					
					'****START SECTION 4***********************************************
					'Print Actual Recovered data

					txtColumns(0)= "4 - Actual Recovered " & DebugPrint(" 4 >> " & ActualRecovered(COL4_ActualRecoveredOrgId, iOrgRow) & " " & ActualRecovered(COL4_ActualRecoveredOrgName, iOrgRow))
					Call intDefaultHeader()
					
					'Uses logic from Summary_A.sls to make sure the numbers match
					pvAnd = " AND Referral" & pvOrgTypeDbDesc & "ConversionID = 1 AND Referral" & pvOrgTypeDbDesc & "ConsentID = 1 AND Referral" & pvOrgTypeDbDesc & "ApproachID = 1 AND Referral" & pvOrgTypeDbDesc & "AppropriateID = 1 "
					sImmedQuery = "/* Multi-Page Actual Recovered */ " & GetSummaryCount()
					                                                 
					'DebugPrint(sImmedQuery)
					Set ImmedRS = Conn.Execute(sImmedQuery)
					vActualRecovered = ImmedRS("Ctr")
					ImmedRS.Close	
					txtRow(0) = "Actual recovered"
					txtRow(1) = vActualRecovered

					'Select Case pvOrgType
					'	Case "E"
					'		txtRow(1) = ActualRecovered(COL4_ConversionEyes, iOrgRow) 
					'	Case "T"
					'		txtRow(1) = ActualRecovered(COL4_ConversionTissue, iOrgRow) 
					'	Case "O"
					'		txtRow(1) = ActualRecovered(COL4_ConversionOrgans, iOrgRow) 
					'End Select						
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ConversionID_=_1_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ConsentID_=_1_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_1_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "AppropriateID_=_1_"
					Call intPrintRows(txtRow,1,txtLink)

					DWCmd.ActiveConnection = Nothing
					%>
					</Table>
					<%
					'****END SECTION 4************************************************

					'****START SECTION 5**********************************************
					'Print Pre-Referral Approach data
					
					txtColumns(0)= " 5 - Pre-Referral Approach " & DebugPrint("5 >> " & PreReferralApproach(COL5_PreReferralApproachOrgId, iOrgRow) & " " & PreReferralApproach(COL5_PreReferralApproachOrgName, iOrgRow))
					Call intDefaultHeader()

					'Uses logic from Summary_A.sls to make sure the numbers match
					pvAnd = " AND ReferralApproachTypeID IN (2,3) AND Referral" & pvOrgTypeDbDesc & "ApproachID = 1"
					sImmedQuery = "/* Multi-Page Pre-Referral Approach */ " & GetSummaryCount()
					'DebugPrint(sImmedQuery)
					Set ImmedRS = Conn.Execute(sImmedQuery)
					vPreReferral = ImmedRS("Ctr")
					ImmedRS.Close

					txtRow(0) = "Pre-referral approach"
					txtRow(1) = vPreReferral & "</a>/" & vActualApproached & ": "
					txtRow(2) = intCalcPercentage(vPreReferral,vActualApproached) 
					txtLink(1) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralApproachTypeID_IN_(2,3)_AND_Referral" & Replace(pvOrgTypeDbDesc, "Trans", "") & "ApproachID_=_1"					
					Call intPrintRows(txtRow,1,txtLink)

					DWCmd.ActiveConnection = Nothing
					'****END SECTION 5************************************************
					%>
					</Table><br><br>
					
				<%
				Next ' iOrgRow
				
			End If  ' If pvPageBreak <> 1 
		End If	
	End If  ' If ExecuteMain

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
	pvOrgType = UCase(Request.QueryString("OrgType"))
	pvThisOrgID = pvThisOrgID ' Get individual org Id for link to pending referrals.  
	If Instr(pvOrgType, "O") > 0 Then
		pvOrgType = "O"
		pvOrgTypeReportDesc = "Organ"
		pvOrgTypeDbDesc = "Organ"
	ElseIf Instr(pvOrgType, "T") > 0 Then
		pvOrgType = "T"
		pvOrgTypeReportDesc = "Tissue"
		pvOrgTypeDbDesc = "Tissue"
	Else  ' Default to Eyes
		pvOrgType = "E"
		pvOrgTypeReportDesc = "Eye"
		pvOrgTypeDbDesc = "EyesTrans"
	End If
	
	If DebugMode = True Then
		Response.Write "<br>pvOrgType: " & pvOrgType & "<br><br>"
	End If
	
	pvPageBreak = Request.QueryString("PageBreak")
	
	' If a single OrgId was sent, set Page Break value to 0
	If Len(pvPageBreak) = 0 Or PvOrgId > 0 Then 
		pvPageBreak = 0
	End If
	
	
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
		
		<TABLE BORDER="2" WIDTH="100%" <%'RULES="NONE" FRAME="VOID"%> cellPadding="0" cellSpacing="0">
		<TR>
		
	<%
	For i = 0 to Ubound(txtColumns,1)
	%>
			<TD WIDTH="7%"><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=txtColumns(i)%></FONT></B></TD>
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
<%	If DebugMode = True Then ' Only write first row if debugging %>		
		<TD WIDTH="3%" ALIGN=Right >
			<%IF FontBold = 0 Then Response.Write("<B>")End If %>
			<%IF txtLink(1) <> "" Then 
				' If the first four characters of the link are "PEND" - go to the pending referrals report
				If Left(txtLink(1), 4) = "PEND" Then %> 
					<A target="ReferralSummary" HREF="/loginstatline/forms/incompletereferrals.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvThisOrgID%>&ReferralType=0&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&OrderBy=&DSN=Production&Options=0&ReportID=33&SortOrgType=1&OrgType=<%=pvOrgType%>">
			<%	' Otherwise, go to the Referral Summary page
				Else %>
					<A target="ReferralSummary" HREF="/loginstatline/reports/referral/summary_A.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvOrgID%>&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&DSN=Production<%=txtLink(1)%>">
			<%	End If
			End If%>
			<FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=txtRow(1)%></FONT>
			<%IF txtLink(1) <> "" Then %> </A> <%End If%>
			<%IF FontBold = 0 Then Response.Write("</B>")End If%>
		</TD>
<%	End If  ' If DebugMode = True	%>	
		<TD WIDTH="3%" ALIGN=Right >
			<%IF FontBold = 0 Then Response.Write("<B>")End If %>
			<%IF txtLink(2) <> "" Then 
				' If the first four characters of the link are "PEND" - go to the pending referrals report
				If Left(txtLink(2), 4) = "PEND" Then %> 
					<A target="ReferralSummary" HREF="/loginstatline/forms/incompletereferrals.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvThisOrgID%>&ReferralType=0&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&OrderBy=&DSN=Production&Options=0&ReportID=33&SortOrgType=1&OrgType=<%=pvOrgType%>">
			<%	' Otherwise, go to the Referral Summary page
				Else %>
					<A target="ReferralSummary" HREF="/loginstatline/reports/referral/summary_A.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvOrgID%>&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&DSN=Production<%=txtLink(2)%>">
			<%	End If
			End If%>
			<FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=txtRow(2)%></FONT>
			<%IF txtLink(2) <> "" Then %> </A> <%End If%>
			<%IF FontBold = 0 Then Response.Write("</B>")End If%>
		</TD>		
		<TD WIDTH="3%" ALIGN=Right >
			<%IF FontBold = 0 Then Response.Write("<B>")End If %>
			<%IF txtLink(3) <> "" Then 
				' If the first four characters of the link are "PEND" - go to the pending referrals report
				If Left(txtLink(3), 4) = "PEND" Then %> 
					<A target="ReferralSummary" HREF="/loginstatline/forms/incompletereferrals.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvThisOrgID%>&ReferralType=0&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&OrderBy=&DSN=Production&Options=0&ReportID=33&SortOrgType=1&OrgType=<%=pvOrgType%>">
			<%	' Otherwise, go to the Referral Summary page
				Else %>
					<A target="ReferralSummary" HREF="/loginstatline/reports/referral/summary_A.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvOrgID%>&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&DSN=Production<%=txtLink(3)%>">
			<%	End If
			End If%>
			<FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=txtRow(3)%></FONT>
			<%IF txtLink(3) <> "" Then %> </A> <%End If%>
			<%IF FontBold = 0 Then Response.Write("</B>")End If%>
		</TD>
		<TD WIDTH="3%" ALIGN=Right >
			<%IF FontBold = 0 Then Response.Write("<B>")End If %>
			<%IF txtLink(4) <> "" Then 
				' If the first four characters of the link are "PEND" - go to the pending referrals report
				If Left(txtLink(4), 4) = "PEND" Then %> 
					<A target="ReferralSummary" HREF="/loginstatline/forms/incompletereferrals.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvThisOrgID%>&ReferralType=0&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&OrderBy=&DSN=Production&Options=0&ReportID=33&SortOrgType=1&OrgType=<%=pvOrgType%>">
			<%	' Otherwise, go to the Referral Summary page
				Else %>
					<A target="ReferralSummary" HREF="/loginstatline/reports/referral/summary_A.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvOrgID%>&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&DSN=Production<%=txtLink(4)%>">
			<%	End If
			End If%>
			<FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>"><%=txtRow(4)%></FONT>
			<%IF txtLink(4) <> "" Then %> </A> <%End If%>
			<%IF FontBold = 0 Then Response.Write("</B>")End If%>
		</TD>		
		<%
		' Percentages
		If txtRow(5) <> "" Then
			If txtRow(5) = 0 then
				vPercentage = "0%"
			Else
				vPercentage = FormatNumber(txtRow(5),1) & "%"
			End if
		Else
			vPercentage = ""
		End if
		%>
		<TD WIDTH="5%" ALIGN=Right >
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
	'Response.Write (".. " & intTopNumber & " .. " & intBottomNumber & " ..<br>" ) 
	If intTopNumber = "" or intTopNumber = 0 Then
		intCalcPercentage = 0
	End if
	
	If intBottomNumber = "" or intBottomNumber = 0 then
		intCalcPercentage = "0"
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

Function DebugPrint(sPrintString)
	If DebugMode = True Then
		Response.Write "<br>" & sPrintString & "<br><br>"
	End If
End Function

'End Function Section
%>
