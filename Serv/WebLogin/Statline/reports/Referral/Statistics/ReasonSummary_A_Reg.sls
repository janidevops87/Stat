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
Dim pvTotals(48)
Dim pvAppropriate
Dim pvAppropriateReg
Dim pvApproachReg
Dim pvAppropriateNReg
Dim pvUnAppropriate
Dim pvTotalReferrals
Dim pvApproach
Dim pvConsent
Dim txtColumns(7)
Dim txtRow(13)
Dim txtLink(13)
Dim pvConversion
Dim DataWareHouseConn
'DW = DataWareHouse
Dim DWRs 
Dim DWCmd
Dim	DWParam
Dim QuitPage

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes


%>


<%
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "1.5"
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
<TITLE>Referral Statistics - Reason Summary (w/Reg)</TITLE>
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
		vMainTitle = "Reason Summary"	
		vTitlePeriod = DateLiteraL(pvStartDate)
		vTitleTo = DateLiteral(pvEndDate)
		vTitleTimes = "All Times " & ZoneName(vTZ)
	
	%>	
		<!-- Print Report Header -->
		<!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->

		<% 
			'Print Appropriate and Rule Out Totals Header. Store Referral Totals in a variable to calculate % later
			
			'drh 1/6/04 - Changed to unhard-code DSN, User, and Pwd
			'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"		'OLD
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	'CORRECTED
			DWCmd.CommandText = "sps_AppropriateTotal_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			'DWCmd.CommandType = 4
			'DWRs.CursorLocation = 1
			'DWRs.CursorType = 3
			'Response.Write DWCmd.CommandText
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
			'Get Appropriate Registered
			DWCmd.CommandText = "sps_AppropriateRegisteredTotal_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			Set DWRs = DWCmd.Execute
						
			If IsNull(DWRs(0)) Then
				pvAppropriateReg = 0
			Else
				pvAppropriateReg = DWRs(0)
			End if
			
			If IsNull(DWRs(1)) Then
				pvApproachReg = 0
			Else
				pvApproachReg = DWRs(1)		
			End if
			
			'Calculate Appropriate Non-Registered
			pvAppropriateNReg = pvAppropriate - pvAppropriateReg
		
			DWCmd.ActiveConnection = Nothing
			txtColumns(0) = "Totals"
			Call intPrintColumnHeader(txtColumns)

			'Print Totals data			
			txtRow(0) = "Appropriate Referrals"
			txtRow(1) = intCalcPercentage(pvAppropriate, (pvUnAppropriate + pvAppropriate))
			txtRow(2) =	pvAppropriate
			Call intPrintRows(txtRow,0,txtLink)
			
			txtRow(0) = "Rule-Out Referrals"
			txtRow(1) = intCalcPercentage(pvUnAppropriate,(pvUnAppropriate + pvAppropriate))
			txtRow(2) = pvUnAppropriate
			Call intPrintRows(txtRow,0,txtLink)
				'Print line  spanning 3 columns
				%>
				
				<TR><TD COLSPAN=3 ><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 ></HR></TD></TR>
				
				<%

			txtRow(0) = "Total Referrals"
			txtRow(1) = intCalcPercentage((pvUnAppropriate + pvAppropriate), (pvUnAppropriate + pvAppropriate))
			txtRow(2) = pvUnAppropriate + pvAppropriate
			Call intPrintRows(txtRow,1,txtLink)
			
			%>							
				<TR><TD>&nbsp;</TD></TR>
			<%			
			
			'Print Registered Totals data		
			txtRow(0) = "Appropriate Registered Referrals"
			txtRow(1) = intCalcPercentage(pvApproachReg, pvAppropriateReg)
			txtRow(2) = pvApproachReg
			Call intPrintRows(txtRow,0,txtLink)

			txtRow(0) = "Rule-Out Registered Referrals"
			txtRow(1) = intCalcPercentage(pvAppropriateReg - pvApproachReg, pvAppropriateReg)
			txtRow(2) =	pvAppropriateReg - pvApproachReg
			Call intPrintRows(txtRow,0,txtLink)
				'Print line  spanning 3 columns
				%>

				<TR><TD COLSPAN=3 ><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 ></HR></TD></TR>

				<%

			txtRow(0) = "Total Registered Referrals"
			txtRow(1) = intCalcPercentage(pvAppropriateReg, pvAppropriateReg)
			txtRow(2) = pvAppropriateReg
			Call intPrintRows(txtRow,1,txtLink)
				'Print End of Table
				%>
				</Table>
				<%
			
			'Print Appropriate Data
			'drh 1/6/04 - Changed to unhard-code DSN, User, and Pwd
			'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"		'OLD
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	'CORRECTED
			DWCmd.CommandText = "sps_AppropriateReasonSummary_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			'Response.Write DWCmd.CommandText
			Set DWRs = DWCmd.Execute
			
			'************************************************************************************************************************
			'C.Chaput 04/05/2005 commented out link lines and added new registry status table (as of fall 2004) to where 
			'query logic along with old consent/approach where logic. 
			'Example: "AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)" is part of 
			'          the where query for consent = 7,8(in DMV and registry) and approach = 12, 13(in DMV and registry). 
			'          Added new where logic to check registry status table also "
			'          "AND_(RegistryStatus IN(1,2,4)_OR_(ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID IN(12,13)))
			'          for registry status = 1,2,4(state registry, web registry or manually found)
			'         
			'NOTE: The where logic should be the same as the where logic in the corresponding datawarehouse stored proc. For example
			'      in the registered consented section look at spi_Referral_ConsentReasonCount2 
			'***************************************************************************************************************************
			
			txtColumns(0)= "Appropriate"			
			Call intDefaultHeader()
			
			txtRow(0) = "Appropriate"
			txtRow(1) = intCalcPercentage(DWRs("AppropriateOrgan"),(pvUnAppropriate + pvAppropriate))
			txtRow(2) = DWRs("AppropriateOrgan")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("AppropriateBone"),(pvUnAppropriate + pvAppropriate))
			txtRow(4) = DWRs("AppropriateBone")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("AppropriateTissue"),(pvUnAppropriate + pvAppropriate))
			txtRow(6) = DWRs("AppropriateTissue")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("AppropriateSkin"),(pvUnAppropriate + pvAppropriate))
			txtRow(8) = DWRs("AppropriateSkin")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("AppropriateValves"),(pvUnAppropriate + pvAppropriate))
			txtRow(10) = DWRs("AppropriateValves")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("AppropriateEyes"),(pvUnAppropriate + pvAppropriate))
			txtRow(12) = DWRs("AppropriateEyes")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,0,txtLink)
			
			pvTotals(0) = DWRs("AppropriateOrgan")
			pvTotals(1) = DWRs("AppropriateBone")
			pvTotals(2) = DWRs("AppropriateTissue")
			pvTotals(3) = DWRs("AppropriateSkin")
			pvTotals(4) = DWRs("AppropriateValves")
			pvTotals(5) = DWRs("AppropriateEyes")
			pvTotals(6) = DWRs("AppropriateOrganUnappropriate")
			pvTotals(7) = DWRs("AppropriateBoneUnappropriate")
			pvTotals(8) = DWRs("AppropriateTissueUnappropriate")
			pvTotals(9) = DWRs("AppropriateSkinUnappropriate")
			pvTotals(10) = DWRs("AppropriateValvesUnappropriate")
			pvTotals(11) = DWRs("AppropriateEyesUnappropriate")
			
			'drh 10/31/01
			txtRow(0) = "Registered"
			txtRow(1) = intCalcPercentage(DWRs("AppropriateOrganReg"),pvTotals(0))
			txtRow(2) = DWRs("AppropriateOrganReg")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_1_AND_ApproachTypeId_=_8_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_1_AND_DonorRegistryType_IN(1,2)_"
			txtRow(3) = intCalcPercentage(DWRs("AppropriateBoneReg"),pvTotals(1))
			txtRow(4) = DWRs("AppropriateBoneReg")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_1_AND_ApproachTypeId_=_8_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_1_AND_DonorRegistryType_IN(1,2)_"
			txtRow(5) = intCalcPercentage(DWRs("AppropriateTissueReg"),pvTotals(2))
			txtRow(6) = DWRs("AppropriateTissueReg")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_1_AND_ApproachTypeId_=_8_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_1_AND_DonorRegistryType_IN(1,2)_"
			txtRow(7) = intCalcPercentage(DWRs("AppropriateSkinReg"),pvTotals(3))
			txtRow(8) = DWRs("AppropriateSkinReg")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_1_AND_ApproachTypeId_=_8_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_1_AND_DonorRegistryType_IN(1,2)_"
			txtRow(9) = intCalcPercentage(DWRs("AppropriateValvesReg"),pvTotals(4))
			txtRow(10) = DWRs("AppropriateValvesReg")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_1_AND_ApproachTypeId_=_8_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_1_AND_DonorRegistryType_IN(1,2)_"
			txtRow(11) = intCalcPercentage(DWRs("AppropriateEyesReg"),pvTotals(5))
			txtRow(12) = DWRs("AppropriateEyesReg")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_1_AND_ApproachTypeId_=_8_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_1_AND_DonorRegistryType_IN(1,2)_"
			Call intPrintRows(txtRow,1,txtLink)
			
			'drh 10/31/01
			txtRow(0) = "Not Registered"
			txtRow(1) = intCalcPercentage(DWRs("AppropriateOrganNReg"),pvTotals(0))
			txtRow(2) = DWRs("AppropriateOrganNReg")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_1_AND_ApproachTypeId_<>_8_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_1_AND_DonorRegistryType_NOT_IN(1,2)_"
			txtRow(3) = intCalcPercentage(DWRs("AppropriateBoneNReg"),pvTotals(1))
			txtRow(4) = DWRs("AppropriateBoneNReg")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_1_AND_ApproachTypeId_<>_8_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_1_AND_DonorRegistryType_NOT_IN(1,2)_"
			txtRow(5) = intCalcPercentage(DWRs("AppropriateTissueNReg"),pvTotals(2))
			txtRow(6) = DWRs("AppropriateTissueNReg")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_1_AND_ApproachTypeId_<>_8_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_1_AND_DonorRegistryType_NOT_IN(1,2)_"
			txtRow(7) = intCalcPercentage(DWRs("AppropriateSkinNReg"),pvTotals(3))
			txtRow(8) = DWRs("AppropriateSkinNReg")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_1_AND_ApproachTypeId_<>_8_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_1_AND_DonorRegistryType_NOT_IN(1,2)_"
			txtRow(9) = intCalcPercentage(DWRs("AppropriateValvesNReg"),pvTotals(4))
			txtRow(10) = DWRs("AppropriateValvesNReg")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_1_AND_ApproachTypeId_<>_8_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_1_AND_DonorRegistryType_NOT_IN(1,2)_"
			txtRow(11) = intCalcPercentage(DWRs("AppropriateEyesNReg"),pvTotals(5))
			txtRow(12) = DWRs("AppropriateEyesNReg")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_1_AND_ApproachTypeId_<>_8_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_1_AND_DonorRegistryType_NOT_IN(1,2)_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Not Appropriate"
			txtRow(1) = intCalcPercentage(DWRs("AppropriateOrganUnappropriate"),(pvUnAppropriate + pvAppropriate))
			txtRow(2) = DWRs("AppropriateOrganUnappropriate")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_<>_1_"
			txtRow(3) = intCalcPercentage(DWRs("AppropriateBoneUnappropriate"),(pvUnAppropriate + pvAppropriate))
			txtRow(4) = DWRs("AppropriateBoneUnappropriate")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_<>_1_"
			txtRow(5) = intCalcPercentage(DWRs("AppropriateTissueUnappropriate"),(pvUnAppropriate + pvAppropriate))
			txtRow(6) = DWRs("AppropriateTissueUnappropriate")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_<>_1_"
			txtRow(7) = intCalcPercentage(DWRs("AppropriateSkinUnappropriate"),(pvUnAppropriate + pvAppropriate))
			txtRow(8) = DWRs("AppropriateSkinUnappropriate")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_<>_1_"
			txtRow(9) = intCalcPercentage(DWRs("AppropriateValvesUnappropriate"),(pvUnAppropriate + pvAppropriate))
			txtRow(10) = DWRs("AppropriateValvesUnappropriate")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_<>_1_"
			txtRow(11) = intCalcPercentage(DWRs("AppropriateEyesUnappropriate"),(pvUnAppropriate + pvAppropriate))
			txtRow(12) = DWRs("AppropriateEyesUnappropriate")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_<>_1_"
			Call intPrintRows(txtRow,0,txtLink)
			
			txtRow(0) = "Age"
			txtRow(1) = intCalcPercentage(DWRs("AppropriateOrganAge"),pvTotals(6))
			txtRow(2) = DWRs("AppropriateOrganAge")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_2"
			txtRow(3) = intCalcPercentage(DWRs("AppropriateBoneAge"),pvTotals(7))
			txtRow(4) = DWRs("AppropriateBoneAge")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_2"
			txtRow(5) = intCalcPercentage(DWRs("AppropriateTissueAge"),pvTotals(8))
			txtRow(6) = DWRs("AppropriateTissueAge")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_2"
			txtRow(7) = intCalcPercentage(DWRs("AppropriateSkinAge"),pvTotals(9))
			txtRow(8) = DWRs("AppropriateSkinAge")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_2"
			txtRow(9) = intCalcPercentage(DWRs("AppropriateValvesAge"),pvTotals(10))
			txtRow(10) = DWRs("AppropriateValvesAge")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_2"
			txtRow(11) = intCalcPercentage(DWRs("AppropriateEyesAge"),pvTotals(11))
			txtRow(12) = DWRs("AppropriateEyesAge")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_2"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "High Risk"
			txtRow(1) = intCalcPercentage(DWRs("AppropriateOrganHighRisk"),pvTotals(6))
			txtRow(2) = DWRs("AppropriateOrganHighRisk")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_3"
			txtRow(3) = intCalcPercentage(DWRs("AppropriateBoneHighRisk"),pvTotals(7))
			txtRow(4) = DWRs("AppropriateBoneHighRisk")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_3"
			txtRow(5) = intCalcPercentage(DWRs("AppropriateTissueHighRisk"),pvTotals(8))
			txtRow(6) = DWRs("AppropriateTissueHighRisk")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_3"
			txtRow(7) = intCalcPercentage(DWRs("AppropriateSkinHighRisk"),pvTotals(9))
			txtRow(8) = DWRs("AppropriateSkinHighRisk")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_3"
			txtRow(9) = intCalcPercentage(DWRs("AppropriateValvesHighRisk"),pvTotals(10))
			txtRow(10) = DWRs("AppropriateValvesHighRisk")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_3"
			txtRow(11) = intCalcPercentage(DWRs("AppropriateEyesHighRisk"),pvTotals(11))
			txtRow(12) = DWRs("AppropriateEyesHighRisk")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_3"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Med RO"
			txtRow(1) = intCalcPercentage(DWRs("AppropriateOrganMedRO"),pvTotals(6))
			txtRow(2) = DWRs("AppropriateOrganMedRO")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_4"
			txtRow(3) = intCalcPercentage(DWRs("AppropriateBoneMedRO"),pvTotals(7))
			txtRow(4) = DWRs("AppropriateBoneMedRO")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_4"
			txtRow(5) = intCalcPercentage(DWRs("AppropriateTissueMedRO"),pvTotals(8))
			txtRow(6) = DWRs("AppropriateTissueMedRO")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_4"
			txtRow(7) = intCalcPercentage(DWRs("AppropriateSkinMedRO"),pvTotals(9))
			txtRow(8) = DWRs("AppropriateSkinMedRO")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_4"
			txtRow(9) = intCalcPercentage(DWRs("AppropriateValvesMedRO"),pvTotals(10))
			txtRow(10) = DWRs("AppropriateValvesMedRO")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_4"
			txtRow(11) = intCalcPercentage(DWRs("AppropriateEyesMedRO"),pvTotals(11))
			txtRow(12) = DWRs("AppropriateEyesMedRO")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_4"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Not Appropriate"
			txtRow(1) = intCalcPercentage(DWRs("AppropriateOrganNtAppropriate"),pvTotals(6))
			txtRow(2) = DWRs("AppropriateOrganNtAppropriate")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_5"
			txtRow(3) = intCalcPercentage(DWRs("AppropriateBoneNtAppropriate"),pvTotals(7))
			txtRow(4) = DWRs("AppropriateBoneNtAppropriate")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_5"
			txtRow(5) = intCalcPercentage(DWRs("AppropriateTissueNtAppropriate"),pvTotals(8))
			txtRow(6) = DWRs("AppropriateTissueNtAppropriate")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_5"
			txtRow(7) = intCalcPercentage(DWRs("AppropriateSkinNtAppropriate"),pvTotals(9))
			txtRow(8) = DWRs("AppropriateSkinNtAppropriate")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_5"
			txtRow(9) = intCalcPercentage(DWRs("AppropriateValvesNtAppropriate"),pvTotals(10))
			txtRow(10) = DWRs("AppropriateValvesNtAppropriate")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_5"
			txtRow(11) = intCalcPercentage(DWRs("AppropriateEyesNtAppropriate"),pvTotals(11))
			txtRow(12) = DWRs("AppropriateEyesNtAppropriate")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_5"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Previous Vent"
			txtRow(1) = intCalcPercentage(DWRs("AppropriateOrganPreviousVent"),pvTotals(6))
			txtRow(2) = DWRs("AppropriateOrganPreviousVent")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganAppropriateID_=_6"
			txtRow(3) = intCalcPercentage(DWRs("AppropriateBonePreviousVent"),pvTotals(7))
			txtRow(4) = DWRs("AppropriateBonePreviousVent")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneAppropriateID_=_6"
			txtRow(5) = intCalcPercentage(DWRs("AppropriateTissuePreviousVent"),pvTotals(8))
			txtRow(6) = DWRs("AppropriateTissuePreviousVent")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueAppropriateID_=_6"
			txtRow(7) = intCalcPercentage(DWRs("AppropriateSkinPreviousVent"),pvTotals(9))
			txtRow(8) = DWRs("AppropriateSkinPreviousVent")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinAppropriateID_=_6"
			txtRow(9) = intCalcPercentage(DWRs("AppropriateValvesPreviousVent"),pvTotals(10))
			txtRow(10) = DWRs("AppropriateValvesPreviousVent")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesAppropriateID_=_6"
			txtRow(11) = intCalcPercentage(DWRs("AppropriateEyesPreviousVent"),pvTotals(11))
			txtRow(12) = DWRs("AppropriateEyesPreviousVent")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransAppropriateID_=_6"
			Call intPrintRows(txtRow,1,txtLink)
			'Print End of Table
				
			DWCmd.ActiveConnection = Nothing
			%>
			</Table>
			<%

			'Print Approach Data
			'drh 1/6/04 - Changed to unhard-code DSN, User, and Pwd
			'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"		'OLD
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	'CORRECTED
			DWCmd.CommandText = "sps_ApproachReasonSummary_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			Set DWRs = DWCmd.Execute
			txtColumns(0)= "Approach"			
			Call intDefaultHeader()
			
			txtRow(0) = "Registered"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganReg"), pvTotals(0))
			txtRow(2) = DWRs("ApproachOrganReg")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1,2,4)_OR_(ReferralOrganApproachID_IN(12,13)))_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneReg"),pvTotals(1))
			txtRow(4) = DWRs("ApproachBoneReg")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1,2,4)_OR_(ReferralBoneApproachID_IN(12,13)))_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueReg"),pvTotals(2))
			txtRow(6) = DWRs("ApproachTissueReg")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1,2,4)_OR_(ReferralTissueApproachID_IN(12,13)))_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinReg"), pvTotals(3))
			txtRow(8) = DWRs("ApproachSkinReg")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1,2,4)_OR_(ReferralSkinApproachID_IN(12,13)))_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesReg"), pvTotals(4))
			txtRow(10) = DWRs("ApproachValvesReg")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1,2,4)_OR_(ReferralValvesApproachID_IN(12,13)))_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesReg"), pvTotals(5))
			txtRow(12) = DWRs("ApproachEyesReg")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1,2,4)_OR_(ReferralEyesTransApproachID_IN(12,13)))_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,0,txtLink)
			
			'Reset pvTotals (Registered)
			pvTotals(13) = DWRs("ApproachOrganReg")
			pvTotals(14) = DWRs("ApproachBoneReg")
			pvTotals(15) = DWRs("ApproachTissueReg")
			pvTotals(16) = DWRs("ApproachSkinReg")
			pvTotals(17) = DWRs("ApproachValvesReg")
			pvTotals(18) = DWRs("ApproachEyesReg")
			
			txtRow(0) = "DMV"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganDMVReg"), pvTotals(13))
			txtRow(2) = DWRs("ApproachOrganDMVReg")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganApproachID_=_12_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralOrganApproachID_=_12_OR_RegistryStatus_=_1)_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneDMVReg"),pvTotals(14))
			txtRow(4) = DWRs("ApproachBoneDMVReg")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_12_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralBoneApproachID_=_12_OR_RegistryStatus_=_1)_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueDMVReg"),pvTotals(15))
			txtRow(6) = DWRs("ApproachTissueDMVReg")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_12_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralTissueApproachID_=_12_OR_RegistryStatus_=_1)_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinDMVReg"), pvTotals(16))
			txtRow(8) = DWRs("ApproachSkinDMVReg")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_12_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralSkinApproachID_=_12_OR_RegistryStatus_=_1)_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesDMVReg"), pvTotals(17))
			txtRow(10) = DWRs("ApproachValvesDMVReg")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_12_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralValvesApproachID_=_12_OR_RegistryStatus_=_1)_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesDMVReg"), pvTotals(18))
			txtRow(12) = DWRs("ApproachEyesDMVReg")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_12_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralEyesTransApproachID_=_12_OR_RegistryStatus_=_1)_AND_ReferralEyesTransAppropriateID_=_1_"		
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Donor Registry"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganDRReg"), pvTotals(13))
			txtRow(2) = DWRs("ApproachOrganDRReg")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganApproachID_=_13_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralOrganApproachID_=_13_OR_RegistryStatus_=_2)_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneDRReg"),pvTotals(14))
			txtRow(4) = DWRs("ApproachBoneDRReg")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_13_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralBoneApproachID_=_13_OR_RegistryStatus_=_2)_AND_ReferralBoneAppropriateID_=_1_"			
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueDRReg"),pvTotals(15))
			txtRow(6) = DWRs("ApproachTissueDRReg")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_13_AND_ReferralTissueAppropriateID_=_1_"
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralTissueApproachID_=_13_OR_RegistryStatus_=_2)_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinDRReg"), pvTotals(16))
			txtRow(8) = DWRs("ApproachSkinDRReg")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_13_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralSkinApproachID_=_13_OR_RegistryStatus_=_2)_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesDRReg"), pvTotals(17))
			txtRow(10) = DWRs("ApproachValvesDRReg")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_13_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralValvesApproachID_=_13_OR_RegistryStatus_=_2)_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesDRReg"), pvTotals(18))
			txtRow(12) = DWRs("ApproachEyesDRReg")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_13_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_(ReferralEyesTransApproachID_=_13_OR_RegistryStatus_=_2)_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			
			txtRow(0) = "Approached"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrgan"), pvTotals(0))
			txtRow(2) = DWRs("ApproachOrgan")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBone"),pvTotals(1))
			txtRow(4) = DWRs("ApproachBone")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissue"),pvTotals(2))
			txtRow(6) = DWRs("ApproachTissue")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkin"), pvTotals(3))
			txtRow(8) = DWRs("ApproachSkin")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValves"), pvTotals(4))
			txtRow(10) = DWRs("ApproachValves")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyes"), pvTotals(5))
			txtRow(12) = DWRs("ApproachEyes")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			Call intPrintRows(txtRow,0,txtLink)
			
			txtRow(0) = "Not Approached"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganNotApproached"), pvTotals(0))
			txtRow(2) = DWRs("ApproachOrganNotApproached")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_NOT_IN(1,12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_NOT_IN(1,12,13)_AND_ReferralOrganAppropriateID_=_1__AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneNotApproached"), pvTotals(1))
			txtRow(4) = DWRs("ApproachBoneNotApproached")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_NOT_IN(1,12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_NOT_IN(1,12,13)_AND_ReferralBoneAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueNotApproached"), pvTotals(2))
			txtRow(6) = DWRs("ApproachTissueNotApproached")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_NOT_IN(1,12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_NOT_IN(1,12,13)_AND_ReferralTissueAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinNotApproached"), pvTotals(3))
			txtRow(8) = DWRs("ApproachSkinNotApproached")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_NOT_IN(1,12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_NOT_IN(1,12,13)_AND_ReferralSkinAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesNotApproached"), pvTotals(4))
			txtRow(10) = DWRs("ApproachValvesNotApproached") 
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_NOT_IN(1,12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_NOT_IN(1,12,13)_AND_ReferralValvesAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesNotApproached"), pvTotals(5))
			txtRow(12) = DWRs("ApproachEyesNotApproached")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_NOT_IN(1,12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_NOT_IN(1,12,13)_AND_ReferralEyesTransAppropriateID_=_1_AND_RegistryStatus_NOT_IN(1,2,4)_"
			Call intPrintRows(txtRow,0,txtLink)
			
			'Reset pvTotals
			pvTotals(0) = DWRs("ApproachOrgan")
			pvTotals(1) = DWRs("ApproachBone")
			pvTotals(2) = DWRs("ApproachTissue")
			pvTotals(3) = DWRs("ApproachSkin")
			pvTotals(4) = DWRs("ApproachValves")
			pvTotals(5) = DWRs("ApproachEyes")
			pvTotals(19) = DWRs("ApproachOrgan")
			pvTotals(20) = DWRs("ApproachBone")
			pvTotals(21) = DWRs("ApproachTissue")
			pvTotals(22) = DWRs("ApproachSkin")
			pvTotals(23) = DWRs("ApproachValves")
			pvTotals(24) = DWRs("ApproachEyes")
			pvTotals(6) = DWRs("ApproachOrganNotApproached")
			pvTotals(7) = DWRs("ApproachBoneNotApproached")
			pvTotals(8) = DWRs("ApproachTissueNotApproached")
			pvTotals(9) = DWRs("ApproachSkinNotApproached")
			pvTotals(10) = DWRs("ApproachValvesNotApproached")
			pvTotals(11) = DWRs("ApproachEyesNotApproached")
			

			txtRow(0) = "Unknown"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganUnknown"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganUnknown")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_=_2_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneUnknown"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneUnknown")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_2_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueUnknown"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueUnknown")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_2_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinUnknown"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinUnknown")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_2_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesUnknown"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesUnknown")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_2_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesUnknown"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesUnknown")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_2_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Family Unavail."
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganFamilyUnavail"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganFamilyUnavail")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_=_3_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneFamilyUnavail"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneFamilyUnavail")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_3_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueFamilyUnavail"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueFamilyUnavail")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_3_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinFamilyUnavail"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinFamilyUnavail")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_3_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesFamilyUnavail"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesFamilyUnavail")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_3_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesFamilyUnavail"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesFamilyUnavail")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_3_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Coroner RuleOut"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganCoronerRuleout"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganCoronerRuleout")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_=_4_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneCoronerRuleout"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneCoronerRuleout")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_4_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueCoronerRuleout"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueCoronerRuleout")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_4_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinCoronerRuleout"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinCoronerRuleout")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_4_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesCoronerRuleout"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesCoronerRuleout")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_4_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesCoronerRuleout"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesCoronerRuleout")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_4_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Med RO"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganMedRO"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganMedRO")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_=_6_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneMedRO"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneMedRO")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_6_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueMedRO"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueMedRO")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_6_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinMedRO"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinMedRO")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_6_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesMedRO"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesMedRO")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_6_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesMedRO"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesMedRO")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_6_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Time/Logistics"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganTimeLogistics"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganTimeLogistics")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_=_7_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneTimeLogistics"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneTimeLogistics")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_7_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueTimeLogistics"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueTimeLogistics")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_7_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinTimeLogistics"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinTimeLogistics")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_7_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesTimeLogistics"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesTimeLogistics")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_7_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesTimeLogistics"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesTimeLogistics")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_7_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "High Risk"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganHighRisk"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganHighRisk")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganApproachID_=_9_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneHighRisk"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneHighRisk")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_9_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueHighRisk"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueHighRisk")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_9_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinHighRisk"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinHighRisk")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_9_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesHighRisk"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesHighRisk")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_9_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesHighRisk"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesHighRisk")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_9_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Unapproachable"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganUnapproachable"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganUnapproachable")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_=_11_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneUnapproachable"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneUnapproachable")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_11_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueUnapproachable"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueUnapproachable")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_11_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinUnapproachable"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinUnapproachable")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_11_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesUnapproachable"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesUnapproachable")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_11_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesUnapproachable"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesUnapproachable")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_11_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Arrest"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganArrest"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganArrest")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_=_5_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneArrest"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneArrest")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_5_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueArrest"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueArrest")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_5_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinArrest"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinArrest")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_5_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesArrest"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesArrest")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_5_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesArrest"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesArrest")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_5_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Never Brain Dead"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganNeverBrainDead"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganNeverBrainDead")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_=_8_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneNeverBrainDead"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneNeverBrainDead")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_8_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueNeverBrainDead"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueNeverBrainDead")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_8_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinNeverBrainDead"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinNeverBrainDead")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_8_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesNeverBrainDead"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesNeverBrainDead")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_8_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesNeverBrainDead"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesNeverBrainDead")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_8_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Secondary RO"
			txtRow(1) = intCalcPercentage(DWRs("ApproachOrganSecondaryRO"), pvTotals(6))
			txtRow(2) = DWRs("ApproachOrganSecondaryRO")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_=_14_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("ApproachBoneSecondaryRO"), pvTotals(7))
			txtRow(4) = DWRs("ApproachBoneSecondaryRO")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_14_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ApproachTissueSecondaryRO"), pvTotals(8))
			txtRow(6) = DWRs("ApproachTissueSecondaryRO")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_14_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("ApproachSkinSecondaryRO"), pvTotals(9))
			txtRow(8) = DWRs("ApproachSkinSecondaryRO")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_14_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("ApproachValvesSecondaryRO"), pvTotals(10))
			txtRow(10) = DWRs("ApproachValvesSecondaryRO")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_14_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("ApproachEyesSecondaryRO"), pvTotals(11))
			txtRow(12) = DWRs("ApproachEyesSecondaryRO")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_14_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			
			DWCmd.ActiveConnection = Nothing
			%>
			</Table>
			<%
					
			'Print Consent Data
			'drh 1/6/04 - Changed to unhard-code DSN, User, and Pwd
			'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"		'OLD
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	'CORRECTED
			DWCmd.CommandText = "sps_ConsentReasonSummary_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			Set DWRs = DWCmd.Execute
			txtColumns(0)= "Consent"			
			Call intDefaultHeader()
			
			txtRow(0) = "Consented"
			
			txtRow(1) = intCalcPercentage(DWRs("ConsentOrgan"), pvTotals(0))
			txtRow(2) = DWRs("ConsentOrgan")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"		
			txtRow(3) = intCalcPercentage(DWRs("ConsentBone"),pvTotals(1))
			txtRow(4) = DWRs("ConsentBone")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(5) = intCalcPercentage(DWRs("ConsentTissue"),pvTotals(2))
			txtRow(6) = DWRs("ConsentTissue")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(7) = intCalcPercentage(DWRs("ConsentSkin"), pvTotals(3))
			txtRow(8) = DWRs("ConsentSkin")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(9) = intCalcPercentage(DWRs("ConsentValves"), pvTotals(4))
			txtRow(10) = DWRs("ConsentValves")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(11) = intCalcPercentage(DWRs("ConsentEyes"), pvTotals(5))
			txtRow(12) = DWRs("ConsentEyes")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			Call intPrintRows(txtRow,0,txtLink)
			
			txtRow(0) = "Not Consented"
			txtRow(1) = intCalcPercentage(DWRs("ConsentOrganNotConsented"), pvTotals(0))
			txtRow(2) = DWRs("ConsentOrganNotConsented")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_<>_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_<>_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(3) = intCalcPercentage(DWRs("ConsentBoneNotConsented"), pvTotals(1))
			txtRow(4) = DWRs("ConsentBoneNotConsented")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_<>_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_<>_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(5) = intCalcPercentage(DWRs("ConsentTissueNotConsented"), pvTotals(2))
			txtRow(6) = DWRs("ConsentTissueNotConsented")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_<>_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_<>_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(7) = intCalcPercentage(DWRs("ConsentSkinNotConsented"), pvTotals(3))
			txtRow(8) = DWRs("ConsentSkinNotConsented")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_<>_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_<>_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(9) = intCalcPercentage(DWRs("ConsentValvesNotConsented"), pvTotals(4))
			txtRow(10) = DWRs("ConsentValvesNotConsented") 
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_<>_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_<>_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(11) = intCalcPercentage(DWRs("ConsentEyesNotConsented"), pvTotals(5))
			txtRow(12) = DWRs("ConsentEyesNotConsented")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_<>_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_<>_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			Call intPrintRows(txtRow,0,txtLink)
			'Reset pvTotals
			pvTotals(0) = DWRs("ConsentOrgan")
			pvTotals(1) = DWRs("ConsentBone")
			pvTotals(2) = DWRs("ConsentTissue")
			pvTotals(3) = DWRs("ConsentSkin")
			pvTotals(4) = DWRs("ConsentValves")
			pvTotals(5) = DWRs("ConsentEyes")
			pvTotals(25) = DWRs("RegConsentOrgan")
			pvTotals(26) = DWRs("RegConsentBone")
			pvTotals(27) = DWRs("RegConsentTissue")
			pvTotals(28) = DWRs("RegConsentSkin")
			pvTotals(29) = DWRs("RegConsentValves")
			pvTotals(30) = DWRs("RegConsentEyes")
			pvTotals(31) = DWRs("ConsentOrgan")
			pvTotals(32) = DWRs("ConsentBone")
			pvTotals(33) = DWRs("ConsentTissue")
			pvTotals(34) = DWRs("ConsentSkin")
			pvTotals(35) = DWRs("ConsentValves")
			pvTotals(36) = DWRs("ConsentEyes")
			pvTotals(6) = DWRs("ConsentOrganNotConsented")
			pvTotals(7) = DWRs("ConsentBoneNotConsented")
			pvTotals(8) = DWRs("ConsentTissueNotConsented")
			pvTotals(9) = DWRs("ConsentSkinNotConsented")
			pvTotals(10) = DWRs("ConsentValvesNotConsented")
			pvTotals(11) = DWRs("ConsentEyesNotConsented")
			pvTotals(37) = DWRs("RegConsentOrganNotConsented")
			pvTotals(38) = DWRs("RegConsentBoneNotConsented")
			pvTotals(39) = DWRs("RegConsentTissueNotConsented")
			pvTotals(40) = DWRs("RegConsentSkinNotConsented")
			pvTotals(41) = DWRs("RegConsentValvesNotConsented")
			pvTotals(42) = DWRs("RegConsentEyesNotConsented")

			txtRow(0) = "Ethnic"
			txtRow(1) = intCalcPercentage(DWRs("ConsentOrganEthnic"), pvTotals(6))
			txtRow(2) = DWRs("ConsentOrganEthnic")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_2_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_2_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(3) = intCalcPercentage(DWRs("ConsentBoneEthnic"), pvTotals(7))
			txtRow(4) = DWRs("ConsentBoneEthnic")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_2_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_2_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(5) = intCalcPercentage(DWRs("ConsentTissueEthnic"), pvTotals(8))
			txtRow(6) = DWRs("ConsentTissueEthnic")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_2_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_2_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(7) = intCalcPercentage(DWRs("ConsentSkinEthnic"), pvTotals(9))
			txtRow(8) = DWRs("ConsentSkinEthnic")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_2_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_2_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(9) = intCalcPercentage(DWRs("ConsentValvesEthnic"), pvTotals(10))
			txtRow(10) = DWRs("ConsentValvesEthnic")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_2_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_2_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(11) = intCalcPercentage(DWRs("ConsentEyesEthnic"), pvTotals(11))
			txtRow(12) = DWRs("ConsentEyesEthnic")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_2_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_2_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Religious"
			txtRow(1) = intCalcPercentage(DWRs("ConsentOrganReligious"), pvTotals(6))
			txtRow(2) = DWRs("ConsentOrganReligious")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_3_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_3_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(3) = intCalcPercentage(DWRs("ConsentBoneReligious"), pvTotals(7))
			txtRow(4) = DWRs("ConsentBoneReligious")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_3_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_3_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(5) = intCalcPercentage(DWRs("ConsentTissueReligious"), pvTotals(8))
			txtRow(6) = DWRs("ConsentTissueReligious")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_3_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_3_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(7) = intCalcPercentage(DWRs("ConsentSkinReligious"), pvTotals(9))
			txtRow(8) = DWRs("ConsentSkinReligious")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_3_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_3_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(9) = intCalcPercentage(DWRs("ConsentValvesReligious"), pvTotals(10))
			txtRow(10) = DWRs("ConsentValvesReligious")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_3_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_3_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(11) = intCalcPercentage(DWRs("ConsentEyesReligious"), pvTotals(11))
			txtRow(12) = DWRs("ConsentEyesReligious")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_3_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_3_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Emotional"
			txtRow(1) = intCalcPercentage(DWRs("ConsentOrganEmotional"), pvTotals(6))
			txtRow(2) = DWRs("ConsentOrganEmotional")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_4_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_4_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(3) = intCalcPercentage(DWRs("ConsentBoneEmotional"), pvTotals(7))
			txtRow(4) = DWRs("ConsentBoneEmotional")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_4_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_4_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(5) = intCalcPercentage(DWRs("ConsentTissueEmotional"), pvTotals(8))
			txtRow(6) = DWRs("ConsentTissueEmotional")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_4_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_4_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(7) = intCalcPercentage(DWRs("ConsentSkinEmotional"), pvTotals(9))
			txtRow(8) = DWRs("ConsentSkinEmotional")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_4_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_4_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(9) = intCalcPercentage(DWRs("ConsentValvesEmotional"), pvTotals(10))
			txtRow(10) = DWRs("ConsentValvesEmotional")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_4_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_4_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(11) = intCalcPercentage(DWRs("ConsentEyesEmotional"), pvTotals(11))
			txtRow(12) = DWRs("ConsentEyesEmotional")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEmotionalConsentID_=_4_AND_ReferralEmotionalApproachID_=_1_AND_ReferralEmotionalAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEmotionalConsentID_=_4_AND_ReferralEmotionalApproachID_=_1_AND_ReferralEmotionalAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Unknown"
			txtRow(1) = intCalcPercentage(DWRs("ConsentOrganUnknown"), pvTotals(6))
			txtRow(2) = DWRs("ConsentOrganUnknown")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_5_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_5_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(3) = intCalcPercentage(DWRs("ConsentBoneUnknown"), pvTotals(7))
			txtRow(4) = DWRs("ConsentBoneUnknown")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralboneConsentID_=_5_AND_ReferralboneApproachID_=_1_AND_ReferralboneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralboneConsentID_=_5_AND_ReferralboneApproachID_=_1_AND_ReferralboneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(5) = intCalcPercentage(DWRs("ConsentTissueUnknown"), pvTotals(8))
			txtRow(6) = DWRs("ConsentTissueUnknown")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_5_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_5_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(7) = intCalcPercentage(DWRs("ConsentSkinUnknown"), pvTotals(9))
			txtRow(8) = DWRs("ConsentSkinUnknown")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_5_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_5_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(9) = intCalcPercentage(DWRs("ConsentValvesUnknown"), pvTotals(10))
			txtRow(10) = DWRs("ConsentValvesUnknown")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_5_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_5_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(11) = intCalcPercentage(DWRs("ConsentEyesUnknown"), pvTotals(11))
			txtRow(12) = DWRs("ConsentEyesUnknown")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_5_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_5_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			Call intPrintRows(txtRow,1,txtLink)
			

			
			txtRow(0) = "Prev. Discussion"
			txtRow(1) = intCalcPercentage(DWRs("ConsentOrganPrevDiscussion"), pvTotals(6))
			txtRow(2) = DWRs("ConsentOrganPrevDiscussion")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_6_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_6_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(3) = intCalcPercentage(DWRs("ConsentBonePrevDiscussion"), pvTotals(7))
			txtRow(4) = DWRs("ConsentBonePrevDiscussion")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_6_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_6_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(5) = intCalcPercentage(DWRs("ConsentTissuePrevDiscussion"), pvTotals(8))
			txtRow(6) = DWRs("ConsentTissuePrevDiscussion")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_6_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_6_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(7) = intCalcPercentage(DWRs("ConsentSkinPrevDiscussion"), pvTotals(9))
			txtRow(8) = DWRs("ConsentSkinPrevDiscussion")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_6_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_6_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(9) = intCalcPercentage(DWRs("ConsentValvesPrevDiscussion"), pvTotals(10))
			txtRow(10) = DWRs("ConsentValvesPrevDiscussion")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_6_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_6_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			txtRow(11) = intCalcPercentage(DWRs("ConsentEyesPrevDiscussion"), pvTotals(11))
			txtRow(12) = DWRs("ConsentEyesPrevDiscussion")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_6_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_6_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"
			Call intPrintRows(txtRow,1,txtLink)
			
			%>
			</Table>
			<%
			
			txtColumns(0)= "Registered Consent"			
			Call intDefaultHeader()
						
			txtRow(0) = "Consented"						
			txtRow(1) = intCalcPercentage(DWRs("RegConsentOrgan"), pvTotals(13))
			txtRow(2) = DWRs("RegConsentOrgan")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_((ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13))_OR_RegistryStatus_IN(1,2,4))_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("RegConsentBone"),pvTotals(14))
			txtRow(4) = DWRs("RegConsentBone")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_((ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13))_OR_RegistryStatus_IN(1,2,4))_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("RegConsentTissue"),pvTotals(15))
			txtRow(6) = DWRs("RegConsentTissue")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_((ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13))_OR_RegistryStatus_IN(1,2,4))_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("RegConsentSkin"), pvTotals(16))
			txtRow(8) = DWRs("RegConsentSkin")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_((ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13))_OR_RegistryStatus_IN(1,2,4))_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("RegConsentValves"), pvTotals(17))
			txtRow(10) = DWRs("RegConsentValves")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_((ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13))_OR_RegistryStatus_IN(1,2,4))_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("RegConsentEyes"), pvTotals(18))
			txtRow(12) = DWRs("RegConsentEyes")
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_((ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13))_OR_RegistryStatus_IN(1,2,4))_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,0,txtLink)
			
			txtRow(0) = "DMV"									
			txtRow(1) = intCalcPercentage(DWRs("RegConsentOrganDMVReg"), pvTotals(25))
			txtRow(2) = DWRs("RegConsentOrganDMVReg")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_7_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1)_OR_(ReferralOrganConsentID_IN(7)_AND_ReferralOrganApproachID_IN(12,13)))_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("RegConsentBoneDMVReg"),pvTotals(26))
			txtRow(4) = DWRs("RegConsentBoneDMVReg")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_7_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1)_OR_(ReferralBoneConsentID_IN(7)_AND_ReferralBoneApproachID_IN(12,13)))_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("RegConsentTissueDMVReg"),pvTotals(27))
			txtRow(6) = DWRs("RegConsentTissueDMVReg")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_7_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1)_OR_(ReferralTissueConsentID_IN(7)_AND_ReferralTissueApproachID_IN(12,13)))_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("RegConsentSkinDMVReg"), pvTotals(28))
			txtRow(8) = DWRs("RegConsentSkinDMVReg")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_7_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1)_OR_(ReferralSkinConsentID_IN(7)_AND_ReferralSkinApproachID_IN(12,13)))_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("RegConsentValvesDMVReg"), pvTotals(29))
			txtRow(10) = DWRs("RegConsentValvesDMVReg")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_7_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1)_OR_(ReferralValvesConsentID_IN(7)_AND_ReferralValvesApproachID_IN(12,13)))_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("RegConsentEyesDMVReg"), pvTotals(30))
			txtRow(12) = DWRs("RegConsentEyesDMVReg")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_7_AND_ReferralEyesTransApproachID_IN(12)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(1)_OR_(ReferralEyesTransConsentID_IN(7)_AND_ReferralEyesTransApproachID_IN(12,13)))_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Donor Registry"									
			txtRow(1) = intCalcPercentage(DWRs("RegConsentOrganDRReg"), pvTotals(25))
			txtRow(2) = DWRs("RegConsentOrganDRReg")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_8_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(2)_OR_(ReferralOrganConsentID_IN(8)_AND_ReferralOrganApproachID_IN(12,13)))_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("RegConsentBoneDRReg"),pvTotals(26))
			txtRow(4) = DWRs("RegConsentBoneDRReg")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_8_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(2)_OR_(ReferralBoneConsentID_IN(8)_AND_ReferralBoneApproachID_IN(12,13)))_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("RegConsentTissueDRReg"),pvTotals(27))
			txtRow(6) = DWRs("RegConsentTissueDRReg")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_8_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(2)_OR_(ReferralTissueConsentID_IN(8)_AND_ReferralTissueApproachID_IN(12,13)))_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("RegConsentSkinDRReg"), pvTotals(28))
			txtRow(8) = DWRs("RegConsentSkinDRReg")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_8_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(2)_OR_(ReferralSkinConsentID_IN(8)_AND_ReferralSkinApproachID_IN(12,13)))_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("RegConsentValvesDRReg"), pvTotals(29))
			txtRow(10) = DWRs("RegConsentValvesDRReg")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_8_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(2)_OR_(ReferralValvesConsentID_IN(8)_AND_ReferralValvesApproachID_IN(12,13)))_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("RegConsentEyesDRReg"), pvTotals(30))
			txtRow(12) = DWRs("RegConsentEyesDRReg")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_8_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_(RegistryStatus IN(2)_OR_(ReferralEyesTransConsentID_IN(8)_AND_ReferralEyesTransApproachID_IN(12,13)))_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
						
			txtRow(0) = "Not Consented"
			txtRow(1) = intCalcPercentage(DWRs("RegConsentOrganNotConsented"), pvTotals(13))
			txtRow(2) = DWRs("RegConsentOrganNotConsented")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_NOT_IN(1)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=_AND_((ReferralOrganConsentID_NOT_IN(7,8)_AND_ReferralOrganAppropriateID_=_1_AND_ReferralOrganApproachID_IN(12,13))_OR_(ReferralorganAppropriateID_=_1_AND_ReferralorganConsentID_NOT_IN(1,7,8)_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConsentBoneNotConsented"), pvTotals(14))
			txtRow(4) = DWRs("RegConsentBoneNotConsented")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_NOT_IN(1)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=_AND_((ReferralBoneConsentID_NOT_IN(7,8)_AND_ReferralBoneAppropriateID_=_1_AND_ReferralBoneApproachID_IN(12,13))_OR_(ReferralboneAppropriateID_=_1_AND_ReferralBoneConsentID_NOT_IN(1,7,8)_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConsentTissueNotConsented"), pvTotals(15))
			txtRow(6) = DWRs("RegConsentTissueNotConsented")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_NOT_IN(1)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=_AND_((ReferralTissueConsentID_NOT_IN(7,8)_AND_ReferralTissueAppropriateID_=_1_AND_ReferralTissueApproachID_IN(12,13))_OR_(ReferralTissueAppropriateID_=_1_AND_ReferralTissueConsentID_NOT_IN(1,7,8)_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConsentSkinNotConsented"), pvTotals(16))
			txtRow(8) = DWRs("RegConsentSkinNotConsented")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_NOT_IN(1)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=_AND_((ReferralSkinConsentID_NOT_IN(7,8)_AND_ReferralSkinAppropriateID_=_1_AND_ReferralSkinApproachID_IN(12,13))_OR_(ReferralSkinAppropriateID_=_1_AND_ReferralSkinConsentID_NOT_IN(1,7,8)_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConsentValvesNotConsented"), pvTotals(17))
			txtRow(10) = DWRs("RegConsentValvesNotConsented") 
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_NOT_IN(1)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=_AND_((ReferralValvesConsentID_NOT_IN(7,8)_AND_ReferralValvesAppropriateID_=_1_AND_ReferralValvesApproachID_IN(12,13))_OR_(ReferralValvesAppropriateID_=_1_AND_ReferralValvesConsentID_NOT_IN(1,7,8)_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConsentEyesNotConsented"), pvTotals(18))
			txtRow(12) = DWRs("RegConsentEyesNotConsented")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_NOT_IN(1)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=_AND_((ReferralEyesTransConsentID_NOT_IN(7,8)_AND_ReferralEyesTransAppropriateID_=_1_AND_ReferralEyesTransApproachID_IN(12,13))_OR_(ReferralEyesTransAppropriateID_=_1_AND_ReferralEyesTransConsentID_NOT_IN(1,7,8)_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,0,txtLink)
			
			txtRow(0) = "Ethnic"
			txtRow(1) = intCalcPercentage(DWRs("RegConsentOrganEthnic"), pvTotals(37))
			txtRow(2) = DWRs("RegConsentOrganEthnic")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_2_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("RegConsentBoneEthnic"), pvTotals(38))
			txtRow(4) = DWRs("RegConsentBoneEthnic")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_2_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("RegConsentTissueEthnic"), pvTotals(39))
			txtRow(6) = DWRs("RegConsentTissueEthnic")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_2_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("RegConsentSkinEthnic"), pvTotals(40))
			txtRow(8) = DWRs("RegConsentSkinEthnic")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_2_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("RegConsentValvesEthnic"), pvTotals(41))
			txtRow(10) = DWRs("RegConsentValvesEthnic")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_2_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("RegConsentEyesEthnic"), pvTotals(42))
			txtRow(12) = DWRs("RegConsentEyesEthnic")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_2_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_2_AND_(RegistryStatus IN(1,2,4)_OR_ReferralEyesTransApproachID_IN(12,13))_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "Religious"
			txtRow(1) = intCalcPercentage(DWRs("RegConsentOrganReligious"), pvTotals(37))
			txtRow(2) = DWRs("RegConsentOrganReligious")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_3_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("RegConsentBoneReligious"), pvTotals(38))
			txtRow(4) = DWRs("RegConsentBoneReligious")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_3_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("RegConsentTissueReligious"), pvTotals(39))
			txtRow(6) = DWRs("RegConsentTissueReligious")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_3_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("RegConsentSkinReligious"), pvTotals(40))
			txtRow(8) = DWRs("RegConsentSkinReligious")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_3_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("RegConsentValvesReligious"), pvTotals(41))
			txtRow(10) = DWRs("RegConsentValvesReligious")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_3_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("RegConsentEyesReligious"), pvTotals(42))
			txtRow(12) = DWRs("RegConsentEyesReligious")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_3_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_3_AND_(RegistryStatus IN(1,2,4)_OR_ReferralEyesTransApproachID_IN(12,13))_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Emotional"
			txtRow(1) = intCalcPercentage(DWRs("RegConsentOrganEmotional"), pvTotals(37))
			txtRow(2) = DWRs("RegConsentOrganEmotional")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_4_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("RegConsentBoneEmotional"), pvTotals(38))
			txtRow(4) = DWRs("RegConsentBoneEmotional")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_4_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("RegConsentTissueEmotional"), pvTotals(39))
			txtRow(6) = DWRs("RegConsentTissueEmotional")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_4_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("RegConsentSkinEmotional"), pvTotals(40))
			txtRow(8) = DWRs("RegConsentSkinEmotional")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_4_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("RegConsentValvesEmotional"), pvTotals(41))
			txtRow(10) = DWRs("RegConsentValvesEmotional")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_4_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("RegConsentEyesEmotional"), pvTotals(42))
			txtRow(12) = DWRs("RegConsentEyesEmotional")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEmotionalConsentID_=_4_AND_ReferralEmotionalApproachID_IN(12,13)_AND_ReferralEmotionalAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEmotionalConsentID_=_4_AND_(RegistryStatus IN(1,2,4)_OR_ReferralEyesTransApproachID_IN(12,13))_AND_ReferralEmotionalAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Unknown"
			txtRow(1) = intCalcPercentage(DWRs("RegConsentOrganUnknown"), pvTotals(37))
			txtRow(2) = DWRs("RegConsentOrganUnknown")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_5_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_5_AND_(RegistryStatus IN(1,2,4)_OR_ReferralOrganApproachID_IN(12,13))_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("RegConsentBoneUnknown"), pvTotals(38))
			txtRow(4) = DWRs("RegConsentBoneUnknown")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralboneConsentID_=_5_AND_ReferralboneApproachID_IN(12,13)_AND_ReferralboneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralboneConsentID_=_5_AND_(RegistryStatus IN(1,2,4)_OR_ReferralboneApproachID_IN(12,13))_AND_ReferralboneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("RegConsentTissueUnknown"), pvTotals(39))
			txtRow(6) = DWRs("RegConsentTissueUnknown")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_5_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_5_AND_(RegistryStatus IN(1,2,4)_OR_ReferralTissueApproachID_IN(12,13))_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("RegConsentSkinUnknown"), pvTotals(40))
			txtRow(8) = DWRs("RegConsentSkinUnknown")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_5_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_5_AND_(RegistryStatus IN(1,2,4)_OR_ReferralSkinApproachID_IN(12,13))_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("RegConsentValvesUnknown"), pvTotals(41))
			txtRow(10) = DWRs("RegConsentValvesUnknown")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_5_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_5_AND_(RegistryStatus IN(1,2,4)_OR_ReferralEyesTransApproachID_IN(12,13))_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("RegConsentEyesUnknown"), pvTotals(42))
			txtRow(12) = DWRs("RegConsentEyesUnknown")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_5_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_5_AND_(RegistryStatus IN(1,2,4)_OR_ReferralEyesTransApproachID_IN(12,13))_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Prev. Discussion"
			txtRow(1) = intCalcPercentage(DWRs("RegConsentOrganPrevDiscussion"), pvTotals(37))
			txtRow(2) = DWRs("RegConsentOrganPrevDiscussion")
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_6_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtRow(3) = intCalcPercentage(DWRs("RegConsentBonePrevDiscussion"), pvTotals(38))
			txtRow(4) = DWRs("RegConsentBonePrevDiscussion")
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_6_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("RegConsentTissuePrevDiscussion"), pvTotals(39))
			txtRow(6) = DWRs("RegConsentTissuePrevDiscussion")
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_6_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtRow(7) = intCalcPercentage(DWRs("RegConsentSkinPrevDiscussion"), pvTotals(40))
			txtRow(8) = DWRs("RegConsentSkinPrevDiscussion")
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_6_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtRow(9) = intCalcPercentage(DWRs("RegConsentValvesPrevDiscussion"), pvTotals(41))
			txtRow(10) = DWRs("RegConsentValvesPrevDiscussion")
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_6_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtRow(11) = intCalcPercentage(DWRs("RegConsentEyesPrevDiscussion"), pvTotals(42))
			txtRow(12) = DWRs("RegConsentEyesPrevDiscussion")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_6_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_6_AND_(RegistryStatus IN(1,2,4)_OR_ReferralEyesTransApproachID_IN(12,13))_AND_ReferralEyesTransAppropriateID_=_1_"
			Call intPrintRows(txtRow,1,txtLink)
			
			DWCmd.ActiveConnection = Nothing
			%>
			</Table>
			<%

			'Print Conversion Data
			'drh 1/6/04 - Changed to unhard-code DSN, User, and Pwd
			'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"		'OLD
			DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD	'CORRECTED
			DWCmd.CommandText = "sps_ConversionReasonSummary_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
			Set DWRs = DWCmd.Execute
			txtColumns(0)= "Recovery"			
			Call intDefaultHeader()
			
			txtRow(0) = "Recovered"			
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrgan"), pvTotals(0))
			txtRow(2) = DWRs("ConversionOrgan")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_1_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_1_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBone"),pvTotals(1))
			txtRow(4) = DWRs("ConversionBone")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_1_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_1_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissue"),pvTotals(2))
			txtRow(6) = DWRs("ConversionTissue")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_1_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_1_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkin"), pvTotals(3))
			txtRow(8) = DWRs("ConversionSkin")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_1_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_1_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValves"), pvTotals(4))
			txtRow(10) = DWRs("ConversionValves")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_1_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_1_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyes"), pvTotals(5))
			txtRow(12) = DWRs("ConversionEyes")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_1_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_1_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,0,txtLink)
			
			txtRow(0) = "Not Recovered"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganNotRecovered"), pvTotals(0))
			txtRow(2) = DWRs("ConversionOrganNotRecovered")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_<>_1_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_<>_1_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneNotRecovered"), pvTotals(1))
			txtRow(4) = DWRs("ConversionBoneNotRecovered")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_<>_1_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_<>_1_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueNotRecovered"), pvTotals(2))
			txtRow(6) = DWRs("ConversionTissueNotRecovered")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_<>_1_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_<>_1_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinNotRecovered"), pvTotals(3))
			txtRow(8) = DWRs("ConversionSkinNotRecovered")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_<>_1_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_<>_1_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesNotRecovered"), pvTotals(4))
			txtRow(10) = DWRs("ConversionValvesNotRecovered") 
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_<>_1_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_<>_1_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesNotRecovered"), pvTotals(5))
			txtRow(12) = DWRs("ConversionEyesNotRecovered")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_<>_1_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_<>_1_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,0,txtLink)
			
			'Reset pvTotals
			pvTotals(0) = DWRs("ConversionOrgan")
			pvTotals(1) = DWRs("ConversionBone")
			pvTotals(2) = DWRs("ConversionTissue")
			pvTotals(3) = DWRs("ConversionSkin")
			pvTotals(4) = DWRs("ConversionValves")
			pvTotals(5) = DWRs("ConversionEyes")
			pvTotals(6) = DWRs("ConversionOrganNotRecovered")
			pvTotals(7) = DWRs("ConversionBoneNotRecovered")
			pvTotals(8) = DWRs("ConversionTissueNotRecovered")
			pvTotals(9) = DWRs("ConversionSkinNotRecovered")
			pvTotals(10) = DWRs("ConversionValvesNotRecovered")
			pvTotals(11) = DWRs("ConversionEyesNotRecovered")
			pvTotals(43) = DWRs("RegConversionOrganNotRecovered")
			pvTotals(44) = DWRs("RegConversionBoneNotRecovered")
			pvTotals(45) = DWRs("RegConversionTissueNotRecovered")
			pvTotals(46) = DWRs("RegConversionSkinNotRecovered")
			pvTotals(47) = DWRs("RegConversionValvesNotRecovered")
			pvTotals(48) = DWRs("RegConversionEyesNotRecovered")

			txtRow(0) = "Coroner RuleOut"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganCoronerRuleout"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganCoronerRuleout")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_2_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_2_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneCoronerRuleout"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneCoronerRuleout")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_2_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_2_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueCoronerRuleout"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueCoronerRuleout")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_2_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_2_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinCoronerRuleout"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinCoronerRuleout")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_2_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_2_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesCoronerRuleout"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesCoronerRuleout")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_2_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_2_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesCoronerRuleout"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesCoronerRuleout")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_2_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_2_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Med RO"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganMedRO"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganMedRO")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_5_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_5_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneMedRO"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneMedRO")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_5_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_5_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueMedRO"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueMedRO")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_5_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_5_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinMedRO"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinMedRO")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_5_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_5_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesMedRO"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesMedRO")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_5_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_5_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesMedRO"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesMedRO")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_5_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_5_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "High Risk"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganHighRisk"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganHighRisk")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_6_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_6_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneHighRisk"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneHighRisk")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_6_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_6_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueHighRisk"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueHighRisk")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_6_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_6_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinHighRisk"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinHighRisk")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_6_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_6_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesHighRisk"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesHighRisk")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_6_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_6_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesHighRisk"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesHighRisk")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_6_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_6_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Time/Logistics"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganTimeLogistics"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganTimeLogistics")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_7_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_7_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneTimeLogistics"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneTimeLogistics")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_7_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_7_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueTimeLogistics"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueTimeLogistics")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_7_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_7_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"			
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinTimeLogistics"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinTimeLogistics")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_7_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_7_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesTimeLogistics"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesTimeLogistics")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_7_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_7_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesTimeLogistics"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesTimeLogistics")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_7_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_7_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Arrest"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganArrest"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganArrest")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_3_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_3_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneArrest"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneArrest")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_3_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_3_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueArrest"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueArrest")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_3_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_3_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinArrest"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinArrest")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_3_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_3_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesArrest"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesArrest")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_3_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_3_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesArrest"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesArrest")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_3_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_3_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Never Brain Dead"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganNeverBrainDead"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganNeverBrainDead")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_4_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_4_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneNeverBrainDead"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneNeverBrainDead")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_4_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_4_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueNeverBrainDead"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueNeverBrainDead")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_4_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_4_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinNeverBrainDead"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinNeverBrainDead")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_4_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_4_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesNeverBrainDead"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesNeverBrainDead")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_4_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_4_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesNeverBrainDead"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesNeverBrainDead")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_4_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_4_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Heart Txable"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganHeartTxable"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganHeartTxable")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_8_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_8_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneHeartTxable"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneHeartTxable")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_8_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_8_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueHeartTxable"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueHeartTxable")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_8_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_8_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinHeartTxable"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinHeartTxable")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_8_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_8_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesHeartTxable"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesHeartTxable")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_8_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_8_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesHeartTxable"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesHeartTxable")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_8_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_8_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Family RO"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganFamilyRO"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganFamilyRO")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_10_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_10_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneFamilyRO"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneFamilyRO")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_10_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_10_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueFamilyRO"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueFamilyRO")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_10_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_10_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinFamilyRO"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinFamilyRO")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_10_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_10_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesFamilyRO"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesFamilyRO")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_10_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_10_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesFamilyRO"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesFamilyRO")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_10_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_10_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)
			

			txtRow(0) = "Unknown"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganUnknown"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganUnknown")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_9_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_9_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneUnknown"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneUnknown")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_9_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_9_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueUnknown"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueUnknown")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_9_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_9_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinUnknown"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinUnknown")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_9_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_9_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesUnknown"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesUnknown")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_9_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_9_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesUnknown"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesUnknown")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_9_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_9_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "CNR"
			txtRow(1) = intCalcPercentage(DWRs("ConversionOrganCNR"), pvTotals(6))
			txtRow(2) = DWRs("ConversionOrganCNR")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_11_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_11_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(3) = intCalcPercentage(DWRs("ConversionBoneCNR"), pvTotals(7))
			txtRow(4) = DWRs("ConversionBoneCNR")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_11_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_11_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(5) = intCalcPercentage(DWRs("ConversionTissueCNR"), pvTotals(8))
			txtRow(6) = DWRs("ConversionTissueCNR")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_11_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_11_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(7) = intCalcPercentage(DWRs("ConversionSkinCNR"), pvTotals(9))
			txtRow(8) = DWRs("ConversionSkinCNR")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_11_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_11_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(9) = intCalcPercentage(DWRs("ConversionValvesCNR"), pvTotals(10))
			txtRow(10) = DWRs("ConversionValvesCNR")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_11_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_11_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			txtRow(11) = intCalcPercentage(DWRs("ConversionEyesCNR"), pvTotals(11))
			txtRow(12) = DWRs("ConversionEyesCNR")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_11_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_11_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_(RegistryStatus_IS_NULL_OR_RegistryStatus_NOT_IN_(1,2,4))_"	
			Call intPrintRows(txtRow,1,txtLink)
			
			%></Table><%
			
			txtColumns(0)= "Registered Recovery"			
			Call intDefaultHeader()

			txtRow(0) = "Recovered"			
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrgan"), pvTotals(25)+pvTotals(37))
			txtRow(2) = DWRs("RegConversionOrgan")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_1_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_1_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBone"),pvTotals(26)+pvTotals(38))
			txtRow(4) = DWRs("RegConversionBone")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_1_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_1_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissue"),pvTotals(27)+pvTotals(39))
			txtRow(6) = DWRs("RegConversionTissue")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_1_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_1_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkin"), pvTotals(28)+pvTotals(40))
			txtRow(8) = DWRs("RegConversionSkin")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_1_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_1_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValves"), pvTotals(29)+pvTotals(41))
			txtRow(10) = DWRs("RegConversionValves")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_1_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_1_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyes"), pvTotals(30)+pvTotals(42))
			txtRow(12) = DWRs("RegConversionEyes")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_1_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_1_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,0,txtLink)

			txtRow(0) = "Not Recovered"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganNotRecovered"), pvTotals(25)+pvTotals(37))
			txtRow(2) = DWRs("RegConversionOrganNotRecovered")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_NOT_IN(1)_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_NOT_IN(1)_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneNotRecovered"), pvTotals(26)+pvTotals(38))
			txtRow(4) = DWRs("RegConversionBoneNotRecovered")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_NOT_IN(1)_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_NOT_IN(1)_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueNotRecovered"), pvTotals(27)+pvTotals(39))
			txtRow(6) = DWRs("RegConversionTissueNotRecovered")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_NOT_IN(1)_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_NOT_IN(1)_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinNotRecovered"), pvTotals(28)+pvTotals(40))
			txtRow(8) = DWRs("RegConversionSkinNotRecovered")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_NOT_IN(1)_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_NOT_IN(1)_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesNotRecovered"), pvTotals(29)+pvTotals(41))
			txtRow(10) = DWRs("RegConversionValvesNotRecovered") 
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_NOT_IN(1)_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_NOT_IN(1)_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesNotRecovered"), pvTotals(30)+pvTotals(42))
			txtRow(12) = DWRs("RegConversionEyesNotRecovered")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_NOT_IN(1)_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_NOT_IN(1)_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,0,txtLink)

			
			txtRow(0) = "Coroner RuleOut"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganCoronerRuleout"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganCoronerRuleout")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_2_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_2_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneCoronerRuleout"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneCoronerRuleout")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_2_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_2_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueCoronerRuleout"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueCoronerRuleout")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_2_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_2_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinCoronerRuleout"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinCoronerRuleout")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_2_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_2_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesCoronerRuleout"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesCoronerRuleout")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_2_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_2_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesCoronerRuleout"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesCoronerRuleout")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_2_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_2_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Med RO"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganMedRO"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganMedRO")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_5_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_5_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneMedRO"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneMedRO")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_5_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_5_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueMedRO"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueMedRO")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_5_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_5_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinMedRO"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinMedRO")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_5_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_5_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesMedRO"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesMedRO")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_5_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_5_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesMedRO"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesMedRO")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_5_AND_(ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_5_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)


			txtRow(0) = "High Risk"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganHighRisk"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganHighRisk")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_6_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_6_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneHighRisk"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneHighRisk")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_6_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_6_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueHighRisk"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueHighRisk")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_6_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_6_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinHighRisk"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinHighRisk")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_6_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_6_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesHighRisk"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesHighRisk")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_6_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_6_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesHighRisk"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesHighRisk")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_6_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_6_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Time/Logistics"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganTimeLogistics"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganTimeLogistics")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_7_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_7_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneTimeLogistics"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneTimeLogistics")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_7_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_7_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueTimeLogistics"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueTimeLogistics")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_7_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_7_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinTimeLogistics"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinTimeLogistics")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_7_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_7_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesTimeLogistics"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesTimeLogistics")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_7_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_7_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesTimeLogistics"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesTimeLogistics")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_7_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_7_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Arrest"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganArrest"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganArrest")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_3_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_3_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneArrest"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneArrest")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_3_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_3_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueArrest"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueArrest")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_3_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_3_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinArrest"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinArrest")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_3_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_3_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesArrest"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesArrest")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_3_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_3_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesArrest"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesArrest")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_3_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_3_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Never Brain Dead"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganNeverBrainDead"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganNeverBrainDead")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_4_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_4_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneNeverBrainDead"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneNeverBrainDead")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_4_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_4_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueNeverBrainDead"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueNeverBrainDead")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_4_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_4_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinNeverBrainDead"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinNeverBrainDead")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_4_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_4_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesNeverBrainDead"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesNeverBrainDead")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_4_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_4_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesNeverBrainDead"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesNeverBrainDead")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_4_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_4_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Heart Txable"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganHeartTxable"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganHeartTxable")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_8_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_8_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneHeartTxable"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneHeartTxable")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_8_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_8_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueHeartTxable"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueHeartTxable")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_8_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_8_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinHeartTxable"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinHeartTxable")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_8_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_8_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesHeartTxable"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesHeartTxable")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_8_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_8_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesHeartTxable"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesHeartTxable")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_8_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_8_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Family RO"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganFamilyRO"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganFamilyRO")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_10_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_10_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneFamilyRO"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneFamilyRO")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_10_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_10_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueFamilyRO"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueFamilyRO")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_10_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_10_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinFamilyRO"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinFamilyRO")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_10_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_10_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesFamilyRO"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesFamilyRO")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_10_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_10_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesFamilyRO"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesFamilyRO")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_10_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_10_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)

			txtRow(0) = "Unknown"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganUnknown"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganUnknown")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_9_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_9_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneUnknown"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneUnknown")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_9_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_9_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueUnknown"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueUnknown")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_9_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_9_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinUnknown"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinUnknown")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_9_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_9_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesUnknown"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesUnknown")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_9_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_9_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesUnknown"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesUnknown")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_9_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_9_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)
			
			txtRow(0) = "CNR"
			txtRow(1) = intCalcPercentage(DWRs("RegConversionOrganCNR"), pvTotals(43))
			txtRow(2) = DWRs("RegConversionOrganCNR")
			'txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_11_AND_ReferralOrganConsentID_IN(7,8)_AND_ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganAppropriateID_=_1_"
			txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_11_AND_ReferralOrganAppropriateID_=_1_AND_((ReferralOrganApproachID_IN(12,13)_AND_ReferralOrganConsentID_IN(7,8))_OR_(ReferralOrganConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(3) = intCalcPercentage(DWRs("RegConversionBoneCNR"), pvTotals(44))
			txtRow(4) = DWRs("RegConversionBoneCNR")
			'txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_11_AND_ReferralBoneConsentID_IN(7,8)_AND_ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneAppropriateID_=_1_"
			txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_11_AND_ReferralBoneAppropriateID_=_1_AND_((ReferralBoneApproachID_IN(12,13)_AND_ReferralBoneConsentID_IN(7,8))_OR_(ReferralBoneConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(5) = intCalcPercentage(DWRs("RegConversionTissueCNR"), pvTotals(45))
			txtRow(6) = DWRs("RegConversionTissueCNR")
			'txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_11_AND_ReferralTissueConsentID_IN(7,8)_AND_ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueAppropriateID_=_1_"
			txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_11_AND_ReferralTissueAppropriateID_=_1_AND_((ReferralTissueApproachID_IN(12,13)_AND_ReferralTissueConsentID_IN(7,8))_OR_(ReferralTissueConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(7) = intCalcPercentage(DWRs("RegConversionSkinCNR"), pvTotals(46))
			txtRow(8) = DWRs("RegConversionSkinCNR")
			'txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_11_AND_ReferralSkinConsentID_IN(7,8)_AND_ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinAppropriateID_=_1_"
			txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_11_AND_ReferralSkinAppropriateID_=_1_AND_((ReferralSkinApproachID_IN(12,13)_AND_ReferralSkinConsentID_IN(7,8))_OR_(ReferralSkinConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(9) = intCalcPercentage(DWRs("RegConversionValvesCNR"), pvTotals(47))
			txtRow(10) = DWRs("RegConversionValvesCNR")
			'txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_11_AND_ReferralValvesConsentID_IN(7,8)_AND_ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesAppropriateID_=_1_"
			txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_11_AND_ReferralValvesAppropriateID_=_1_AND_((ReferralValvesApproachID_IN(12,13)_AND_ReferralValvesConsentID_IN(7,8))_OR_(ReferralValvesConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			txtRow(11) = intCalcPercentage(DWRs("RegConversionEyesCNR"), pvTotals(48))
			txtRow(12) = DWRs("RegConversionEyesCNR")
			'txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_11_AND_ReferralEyesTransConsentID_IN(7,8)_AND_ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransAppropriateID_=_1_"
			txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_11_AND_ReferralEyesTransAppropriateID_=_1_AND_((ReferralEyesTransApproachID_IN(12,13)_AND_ReferralEyesTransConsentID_IN(7,8))_OR_(ReferralEyesTransConsentID_=_1_AND_RegistryStatus_IN(1,2,4)))_"
			Call intPrintRows(txtRow,1,txtLink)
			
			DWCmd.ActiveConnection = Nothing
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
	
	<%
		
	For i = 2 to Ubound(txtRow,1) Step 2
	%>	
		<TD WIDTH="7%" ALIGN=LEFT>
			<%
			IF FontBold = 0 Then 
				Response.Write("<B>")
			End If
			%>
			<FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>">
			<%
			
			If txtRow(i) <> "" Then 
				If txtRow(i) = 0 Then 
					Response.Write("0%") 
				Else
					on error resume next
					Response.Write(FormatNumber(txtRow(i-1),0) & "%")
				End If 
			End If
			%>
			</FONT>
			<%
			IF FontBold = 0 Then 
				Response.Write("</B>")
			End If
			%>
		</TD>
		<TD WIDTH="8%" ALIGN=LEFT>
			<FONT SIZE="<%=FontSizeData%>" FACE="<%=FontNameData%>">
			<%
			IF FontBold = 0 Then 
				Response.Write("<B>")
			End If
			If txtLink(i) <> "" Then 
				IF txtRow(i) <> 0  Then 
			%>
					<A target="ReferralSummary" HREF="/loginstatline/reports/referral/summary_A.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvOrgID%>&userID=<%=Request("UserID")%>&userOrgID=<%=pvUserOrgID%>&DSN=Production<%=txtLink(i)%>">
			<%
				End If 
			End If
			%>
			<%=txtRow(i)%>
			<% 
			If txtLink(i) <> ""  Then
				If txtRow(i) <> ""  Then 
			%>
					</A>
			<%
				End If 
			End If
			%>
			<%
			IF FontBold = 0 Then 
				Response.Write("</B>")
			End If
			%>
			</FONT> 
		</TD>
		
	<%	
	Next
	%>
	</TR>	
	<%	
	'reset txtRow Array
	For i = 0 to Ubound(txtRow,1)
		txtRow(i) = ""
		txtLink(i) = ""
	Next
End Function
Function intDefaultHeader()
	
	txtColumns(1) = "Organs"
	txtColumns(2) = "Bone"
	txtColumns(3) = "Tissue"
	txtColumns(4) = "Skin"
	txtColumns(5) = "Valves"
	txtColumns(6) = "Eyes"
	Call intPrintColumnHeader(txtColumns)
End Function			

Function intCalcPercentage(intTopNumber, intBottomNumber)
	'Response.Write (".. " & intTopNumber & " .. " & intBottomNumber & " .." ) 
	If intBottomNumber = "" or intTopNumber = "" or intBottomNumber = 0 or intTopNumber = 0 Then
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
