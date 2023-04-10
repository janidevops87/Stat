<%
'****************************************************************************************************
'File Name:                HospitalAnalysis.sls
'Created:                04/18/01
'Created By:            Thomas T. Worster, Statline,LLC
'Description:            Hospital Analysis Report
'
'Revised:                
'****************************************************************************************************
'Section I:  Variables 
'****************************************************************************************************
'Pre-defined variables:
'Conn                    'Variable used for Database Connection.  Used in \includes\Authorize.sls
'DataSourceName            'Variable defining Database to be used. Used and defined in \includes\Authorize.sls
'ReportID                'The ReportID of the desired Report. Passed from parameters\FrameCustomParams.sls
'RS                        'Variable for RecordSets. Used in \includes\Authorize.sls
'UserID                    'The current user's UserID. Used in \includes\Authorize.sls
'UserOrgID                'The Organization the current user belongs to. Used in \includes\Authorize.sls
'vQuery                    'Variable that contains the Query sent to the Database. Used in \includes\Authorize.sls
'strHttpHeader            'Variable used for header URL.  Used in \includes\Authorize.sls
%>

<%Option Explicit

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 
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
Dim vCurrentColor
Dim pvIn
Dim pvOut
Dim vIn(0)
Dim pvTotals(12)
Dim pvAppropriate
Dim pvUnAppropriate
Dim pvTotalReferrals
Dim pvApproach
Dim pvConsent
Dim txtColumns(7)
Dim txtRow(13)
Dim txtLink(13)
Dim pvConversion
'DW = DataWareHouse
Dim DWRs 
Dim DWCmd
Dim    DWParam
Dim QuitPage
Dim CompUpdateTest
Dim RSTestPermission
Dim cmd

'HOSPITAL REPORT TIMES global variables
Dim vGroupSection
Dim TimeRangeName
Dim vAnd
Dim AllTypes
Dim AppropriateOrgan
Dim AppropriateAllTissue
Dim AppropriateEyes
Dim AppropriateRO
Dim vTotals(5)
Dim vGrandTotals(5)
Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

'drh 04/13/04
Dim vOriginalUserOrgId

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
<TITLE>Hospital Analysis Report</TITLE>
</HEAD>
<BODY bgColor=#F5EBDD>

<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 
<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->

<%'Execute the main page generating routine
If AuthorizeMain Then

    If ExecuteMain Then
        'Set Title Values    
        vMainTitle = "Hospital Analysis"    
        vTitlePeriod = DateLiteral(pvStartDate)
        vTitleTo = DateLiteral(pvEndDate)
        vTitleTimes = "All Times " & ZoneName(vTZ)
    
    %>    
        <!-- Print Report Header -->
        <!--#include virtual="/loginstatline/reports/referral/statistics/Head.sls"-->
    
        <!-- Begin Table-->            
        <% 
        
        txtColumns(0) = "REFERRAL COMPLIANCE"
        Call intPrintHeader(txtColumns)
        Call ProcessReferralComp

        txtColumns(0) = "HOSPITAL REPORT TIMES"
        Call intPrintHeader(txtColumns)
        Call ProcessHospitalReportTimes
        
        txtColumns(0) = "APPROACH SUMMARY"
        Call intPrintHeader(txtColumns)
        Call ProcessApproachSummary
        
        Set DWRs = Server.CreateObject("ADODB.Recordset")
        Set DWCmd = Server.CreateObject("ADODB.Command")
        Set DWParam = Server.CreateObject("ADODB.Parameter")
        
        
            'Print Appropriate and Rule Out Totals Header. Store Referral Totals in a variable to calculate % later
            
            'drh 1/6/04 - Changed to unhard-code DSN, User, and Pwd
            'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"        'OLD
            DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD    'CORRECTED
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
            
            txtColumns(0) = "REASON SUMMARY"
            Call intPrintHeader(txtColumns)
            
            DWCmd.ActiveConnection = Nothing
            txtColumns(0) = "Totals"
            Call intPrintColumnHeader(txtColumns)

            'Print Totals data            
            txtRow(0) = "Appropriate Referrals"
            txtRow(1) = intCalcPercentage(pvAppropriate, (pvUnAppropriate + pvAppropriate))
            txtRow(2) =    pvAppropriate
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
                'Print End of Table
                %>
                </Table>
                <%
            
            'Print Appropriate Data
            'drh 1/6/04 - Changed to unhard-code DSN, User, and Pwd
            'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"        'OLD
            DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD    'CORRECTED
            DWCmd.CommandText = "sps_AppropriateReasonSummary_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
            'Response.Write DWCmd.CommandText
            Set DWRs = DWCmd.Execute
            
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
            'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"        'OLD
            DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD    'CORRECTED
            DWCmd.CommandText = "sps_ApproachReasonSummary_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
            Set DWRs = DWCmd.Execute
            txtColumns(0)= "Approach"            
            Call intDefaultHeader()
            
            txtRow(0) = "Approached"
            txtRow(1) = intCalcPercentage(DWRs("ApproachOrgan"), pvTotals(0))
            txtRow(2) = DWRs("ApproachOrgan")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ApproachBone"),pvTotals(1))
            txtRow(4) = DWRs("ApproachBone")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ApproachTissue"),pvTotals(2))
            txtRow(6) = DWRs("ApproachTissue")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ApproachSkin"), pvTotals(3))
            txtRow(8) = DWRs("ApproachSkin")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ApproachValves"), pvTotals(4))
            txtRow(10) = DWRs("ApproachValves")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ApproachEyes"), pvTotals(5))
            txtRow(12) = DWRs("ApproachEyes")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,0,txtLink)
            
            txtRow(0) = "Not Approached"
            txtRow(1) = intCalcPercentage(DWRs("ApproachOrganNotApproached"), pvTotals(0))
            txtRow(2) = DWRs("ApproachOrganNotApproached")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralorganApproachID_<>_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ApproachBoneNotApproached"), pvTotals(1))
            txtRow(4) = DWRs("ApproachBoneNotApproached")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneApproachID_<>_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ApproachTissueNotApproached"), pvTotals(2))
            txtRow(6) = DWRs("ApproachTissueNotApproached")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueApproachID_<>_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ApproachSkinNotApproached"), pvTotals(3))
            txtRow(8) = DWRs("ApproachSkinNotApproached")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinApproachID_<>_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ApproachValvesNotApproached"), pvTotals(4))
            txtRow(10) = DWRs("ApproachValvesNotApproached") 
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesApproachID_<>_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ApproachEyesNotApproached"), pvTotals(5))
            txtRow(12) = DWRs("ApproachEyesNotApproached")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransApproachID_<>_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,0,txtLink)
            'Reset pvTotals
            pvTotals(0) = DWRs("ApproachOrgan")
            pvTotals(1) = DWRs("ApproachBone")
            pvTotals(2) = DWRs("ApproachTissue")
            pvTotals(3) = DWRs("ApproachSkin")
            pvTotals(4) = DWRs("ApproachValves")
            pvTotals(5) = DWRs("ApproachEyes")
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
            
            
            DWCmd.ActiveConnection = Nothing
            %>
            </Table>
            <%
                    
            'Print Consent Data
            'drh 1/6/04 - Changed to unhard-code DSN, User, and Pwd
            'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"        'OLD
            DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD    'CORRECTED
            DWCmd.CommandText = "sps_ConsentReasonSummary_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
            Set DWRs = DWCmd.Execute
            txtColumns(0)= "Consent"            
            Call intDefaultHeader()
            
            txtRow(0) = "Consented"
            
            txtRow(1) = intCalcPercentage(DWRs("ConsentOrgan"), pvTotals(0))
            txtRow(2) = DWRs("ConsentOrgan")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConsentBone"),pvTotals(1))
            txtRow(4) = DWRs("ConsentBone")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConsentTissue"),pvTotals(2))
            txtRow(6) = DWRs("ConsentTissue")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConsentSkin"), pvTotals(3))
            txtRow(8) = DWRs("ConsentSkin")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConsentValves"), pvTotals(4))
            txtRow(10) = DWRs("ConsentValves")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConsentEyes"), pvTotals(5))
            txtRow(12) = DWRs("ConsentEyes")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,0,txtLink)
            
            txtRow(0) = "Not Consented"
            txtRow(1) = intCalcPercentage(DWRs("ConsentOrganNotConsented"), pvTotals(0))
            txtRow(2) = DWRs("ConsentOrganNotConsented")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_<>_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConsentBoneNotConsented"), pvTotals(1))
            txtRow(4) = DWRs("ConsentBoneNotConsented")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_<>_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConsentTissueNotConsented"), pvTotals(2))
            txtRow(6) = DWRs("ConsentTissueNotConsented")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_<>_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConsentSkinNotConsented"), pvTotals(3))
            txtRow(8) = DWRs("ConsentSkinNotConsented")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_<>_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConsentValvesNotConsented"), pvTotals(4))
            txtRow(10) = DWRs("ConsentValvesNotConsented") 
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_<>_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConsentEyesNotConsented"), pvTotals(5))
            txtRow(12) = DWRs("ConsentEyesNotConsented")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_<>_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,0,txtLink)
            'Reset pvTotals
            pvTotals(0) = DWRs("ConsentOrgan")
            pvTotals(1) = DWRs("ConsentBone")
            pvTotals(2) = DWRs("ConsentTissue")
            pvTotals(3) = DWRs("ConsentSkin")
            pvTotals(4) = DWRs("ConsentValves")
            pvTotals(5) = DWRs("ConsentEyes")
            pvTotals(6) = DWRs("ConsentOrganNotConsented")
            pvTotals(7) = DWRs("ConsentBoneNotConsented")
            pvTotals(8) = DWRs("ConsentTissueNotConsented")
            pvTotals(9) = DWRs("ConsentSkinNotConsented")
            pvTotals(10) = DWRs("ConsentValvesNotConsented")
            pvTotals(11) = DWRs("ConsentEyesNotConsented")

            txtRow(0) = "Ethnic"
            txtRow(1) = intCalcPercentage(DWRs("ConsentOrganEthnic"), pvTotals(6))
            txtRow(2) = DWRs("ConsentOrganEthnic")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_2_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConsentBoneEthnic"), pvTotals(7))
            txtRow(4) = DWRs("ConsentBoneEthnic")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_2_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConsentTissueEthnic"), pvTotals(8))
            txtRow(6) = DWRs("ConsentTissueEthnic")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_2_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConsentSkinEthnic"), pvTotals(9))
            txtRow(8) = DWRs("ConsentSkinEthnic")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_2_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConsentValvesEthnic"), pvTotals(10))
            txtRow(10) = DWRs("ConsentValvesEthnic")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_2_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConsentEyesEthnic"), pvTotals(11))
            txtRow(12) = DWRs("ConsentEyesEthnic")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_2_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)

            txtRow(0) = "Religious"
            txtRow(1) = intCalcPercentage(DWRs("ConsentOrganReligious"), pvTotals(6))
            txtRow(2) = DWRs("ConsentOrganReligious")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_3_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConsentBoneReligious"), pvTotals(7))
            txtRow(4) = DWRs("ConsentBoneReligious")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_3_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConsentTissueReligious"), pvTotals(8))
            txtRow(6) = DWRs("ConsentTissueReligious")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_3_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConsentSkinReligious"), pvTotals(9))
            txtRow(8) = DWRs("ConsentSkinReligious")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_3_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConsentValvesReligious"), pvTotals(10))
            txtRow(10) = DWRs("ConsentValvesReligious")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_3_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConsentEyesReligious"), pvTotals(11))
            txtRow(12) = DWRs("ConsentEyesReligious")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_3_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)

            txtRow(0) = "Emotional"
            txtRow(1) = intCalcPercentage(DWRs("ConsentOrganEmotional"), pvTotals(6))
            txtRow(2) = DWRs("ConsentOrganEmotional")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_4_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConsentBoneEmotional"), pvTotals(7))
            txtRow(4) = DWRs("ConsentBoneEmotional")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_4_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConsentTissueEmotional"), pvTotals(8))
            txtRow(6) = DWRs("ConsentTissueEmotional")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_4_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConsentSkinEmotional"), pvTotals(9))
            txtRow(8) = DWRs("ConsentSkinEmotional")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_4_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConsentValvesEmotional"), pvTotals(10))
            txtRow(10) = DWRs("ConsentValvesEmotional")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_4_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConsentEyesEmotional"), pvTotals(11))
            txtRow(12) = DWRs("ConsentEyesEmotional")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEmotionalConsentID_=_4_AND_ReferralEmotionalApproachID_=_1_AND_ReferralEmotionalAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)
            
            txtRow(0) = "Unknown"
            txtRow(1) = intCalcPercentage(DWRs("ConsentOrganUnknown"), pvTotals(6))
            txtRow(2) = DWRs("ConsentOrganUnknown")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_5_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConsentBoneUnknown"), pvTotals(7))
            txtRow(4) = DWRs("ConsentBoneUnknown")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralboneConsentID_=_5_AND_ReferralboneApproachID_=_1_AND_ReferralboneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConsentTissueUnknown"), pvTotals(8))
            txtRow(6) = DWRs("ConsentTissueUnknown")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_5_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConsentSkinUnknown"), pvTotals(9))
            txtRow(8) = DWRs("ConsentSkinUnknown")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_5_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConsentValvesUnknown"), pvTotals(10))
            txtRow(10) = DWRs("ConsentValvesUnknown")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_5_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConsentEyesUnknown"), pvTotals(11))
            txtRow(12) = DWRs("ConsentEyesUnknown")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_5_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)
            

            
            txtRow(0) = "Prev. Discussion"
            txtRow(1) = intCalcPercentage(DWRs("ConsentOrganPrevDiscussion"), pvTotals(6))
            txtRow(2) = DWRs("ConsentOrganPrevDiscussion")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConsentID_=_6_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConsentBonePrevDiscussion"), pvTotals(7))
            txtRow(4) = DWRs("ConsentBonePrevDiscussion")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConsentID_=_6_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConsentTissuePrevDiscussion"), pvTotals(8))
            txtRow(6) = DWRs("ConsentTissuePrevDiscussion")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConsentID_=_6_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConsentSkinPrevDiscussion"), pvTotals(9))
            txtRow(8) = DWRs("ConsentSkinPrevDiscussion")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConsentID_=_6_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConsentValvesPrevDiscussion"), pvTotals(10))
            txtRow(10) = DWRs("ConsentValvesPrevDiscussion")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConsentID_=_6_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConsentEyesPrevDiscussion"), pvTotals(11))
            txtRow(12) = DWRs("ConsentEyesPrevDiscussion")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConsentID_=_6_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)
            
            DWCmd.ActiveConnection = Nothing
            %>
            </Table>
            <%

            'Print Conversion Data
            'drh 1/6/04 - Changed to unhard-code DSN, User, and Pwd
            'DWCmd.ActiveConnection = "DSN=ProductionDataWarehouse;UID=user;Password=user_pwd"        'OLD
            DWCmd.ActiveConnection = "DSN=" & WAREHOUSEDSN & ";UID=" & DBUSER & ";Password=" & DBPWD    'CORRECTED
            DWCmd.CommandText = "sps_ConversionReasonSummary_A "& pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
            Set DWRs = DWCmd.Execute
            txtColumns(0)= "Recovery"            
            Call intDefaultHeader()
            
            txtRow(0) = "Recovered"
            
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrgan"), pvTotals(0))
            txtRow(2) = DWRs("ConversionOrgan")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_1_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBone"),pvTotals(1))
            txtRow(4) = DWRs("ConversionBone")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_1_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissue"),pvTotals(2))
            txtRow(6) = DWRs("ConversionTissue")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_1_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkin"), pvTotals(3))
            txtRow(8) = DWRs("ConversionSkin")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_1_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValves"), pvTotals(4))
            txtRow(10) = DWRs("ConversionValves")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_1_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyes"), pvTotals(5))
            txtRow(12) = DWRs("ConversionEyes")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_1_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,0,txtLink)
            
            txtRow(0) = "Not Recovered"
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrganNotRecovered"), pvTotals(0))
            txtRow(2) = DWRs("ConversionOrganNotRecovered")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_<>_1_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBoneNotRecovered"), pvTotals(1))
            txtRow(4) = DWRs("ConversionBoneNotRecovered")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_<>_1_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissueNotRecovered"), pvTotals(2))
            txtRow(6) = DWRs("ConversionTissueNotRecovered")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_<>_1_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkinNotRecovered"), pvTotals(3))
            txtRow(8) = DWRs("ConversionSkinNotRecovered")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_<>_1_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValvesNotRecovered"), pvTotals(4))
            txtRow(10) = DWRs("ConversionValvesNotRecovered") 
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_<>_1_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyesNotRecovered"), pvTotals(5))
            txtRow(12) = DWRs("ConversionEyesNotRecovered")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_<>_1_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
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

            txtRow(0) = "Coroner RuleOut"
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrganCoronerRuleout"), pvTotals(6))
            txtRow(2) = DWRs("ConversionOrganCoronerRuleout")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_2_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBoneCoronerRuleout"), pvTotals(7))
            txtRow(4) = DWRs("ConversionBoneCoronerRuleout")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_2_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissueCoronerRuleout"), pvTotals(8))
            txtRow(6) = DWRs("ConversionTissueCoronerRuleout")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_2_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkinCoronerRuleout"), pvTotals(9))
            txtRow(8) = DWRs("ConversionSkinCoronerRuleout")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_2_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValvesCoronerRuleout"), pvTotals(10))
            txtRow(10) = DWRs("ConversionValvesCoronerRuleout")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_2_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyesCoronerRuleout"), pvTotals(11))
            txtRow(12) = DWRs("ConversionEyesCoronerRuleout")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_2_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)

            txtRow(0) = "Med RO"
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrganMedRO"), pvTotals(6))
            txtRow(2) = DWRs("ConversionOrganMedRO")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_5_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBoneMedRO"), pvTotals(7))
            txtRow(4) = DWRs("ConversionBoneMedRO")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_5_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissueMedRO"), pvTotals(8))
            txtRow(6) = DWRs("ConversionTissueMedRO")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_5_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkinMedRO"), pvTotals(9))
            txtRow(8) = DWRs("ConversionSkinMedRO")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_5_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValvesMedRO"), pvTotals(10))
            txtRow(10) = DWRs("ConversionValvesMedRO")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_5_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyesMedRO"), pvTotals(11))
            txtRow(12) = DWRs("ConversionEyesMedRO")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_5_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)

            txtRow(0) = "High Risk"
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrganHighRisk"), pvTotals(6))
            txtRow(2) = DWRs("ConversionOrganHighRisk")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_6_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBoneHighRisk"), pvTotals(7))
            txtRow(4) = DWRs("ConversionBoneHighRisk")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_6_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissueHighRisk"), pvTotals(8))
            txtRow(6) = DWRs("ConversionTissueHighRisk")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_6_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkinHighRisk"), pvTotals(9))
            txtRow(8) = DWRs("ConversionSkinHighRisk")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_6_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValvesHighRisk"), pvTotals(10))
            txtRow(10) = DWRs("ConversionValvesHighRisk")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_6_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyesHighRisk"), pvTotals(11))
            txtRow(12) = DWRs("ConversionEyesHighRisk")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_6_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)

            txtRow(0) = "Time/Logistics"
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrganTimeLogistics"), pvTotals(6))
            txtRow(2) = DWRs("ConversionOrganTimeLogistics")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_7_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBoneTimeLogistics"), pvTotals(7))
            txtRow(4) = DWRs("ConversionBoneTimeLogistics")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_7_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissueTimeLogistics"), pvTotals(8))
            txtRow(6) = DWRs("ConversionTissueTimeLogistics")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_7_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkinTimeLogistics"), pvTotals(9))
            txtRow(8) = DWRs("ConversionSkinTimeLogistics")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_7_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValvesTimeLogistics"), pvTotals(10))
            txtRow(10) = DWRs("ConversionValvesTimeLogistics")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_7_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyesTimeLogistics"), pvTotals(11))
            txtRow(12) = DWRs("ConversionEyesTimeLogistics")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_7_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)

            txtRow(0) = "Arrest"
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrganArrest"), pvTotals(6))
            txtRow(2) = DWRs("ConversionOrganArrest")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_3_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBoneArrest"), pvTotals(7))
            txtRow(4) = DWRs("ConversionBoneArrest")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_3_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissueArrest"), pvTotals(8))
            txtRow(6) = DWRs("ConversionTissueArrest")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_3_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkinArrest"), pvTotals(9))
            txtRow(8) = DWRs("ConversionSkinArrest")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_3_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValvesArrest"), pvTotals(10))
            txtRow(10) = DWRs("ConversionValvesArrest")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_3_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyesArrest"), pvTotals(11))
            txtRow(12) = DWRs("ConversionEyesArrest")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_3_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)

            txtRow(0) = "Never Brain Dead"
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrganNeverBrainDead"), pvTotals(6))
            txtRow(2) = DWRs("ConversionOrganNeverBrainDead")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_4_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBoneNeverBrainDead"), pvTotals(7))
            txtRow(4) = DWRs("ConversionBoneNeverBrainDead")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_4_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissueNeverBrainDead"), pvTotals(8))
            txtRow(6) = DWRs("ConversionTissueNeverBrainDead")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_4_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkinNeverBrainDead"), pvTotals(9))
            txtRow(8) = DWRs("ConversionSkinNeverBrainDead")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_4_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValvesNeverBrainDead"), pvTotals(10))
            txtRow(10) = DWRs("ConversionValvesNeverBrainDead")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_4_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyesNeverBrainDead"), pvTotals(11))
            txtRow(12) = DWRs("ConversionEyesNeverBrainDead")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_4_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)

            txtRow(0) = "Heart Txable"
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrganHeartTxable"), pvTotals(6))
            txtRow(2) = DWRs("ConversionOrganHeartTxable")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_8_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBoneHeartTxable"), pvTotals(7))
            txtRow(4) = DWRs("ConversionBoneHeartTxable")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_8_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissueHeartTxable"), pvTotals(8))
            txtRow(6) = DWRs("ConversionTissueHeartTxable")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_8_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkinHeartTxable"), pvTotals(9))
            txtRow(8) = DWRs("ConversionSkinHeartTxable")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_8_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValvesHeartTxable"), pvTotals(10))
            txtRow(10) = DWRs("ConversionValvesHeartTxable")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_8_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyesHeartTxable"), pvTotals(11))
            txtRow(12) = DWRs("ConversionEyesHeartTxable")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_8_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
            Call intPrintRows(txtRow,1,txtLink)

            txtRow(0) = "Unknown"
            txtRow(1) = intCalcPercentage(DWRs("ConversionOrganUnknown"), pvTotals(6))
            txtRow(2) = DWRs("ConversionOrganUnknown")
            txtLink(2) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralOrganConversionID_=_9_AND_ReferralOrganConsentID_=_1_AND_ReferralOrganApproachID_=_1_AND_ReferralOrganAppropriateID_=_1_"
            txtRow(3) = intCalcPercentage(DWRs("ConversionBoneUnknown"), pvTotals(7))
            txtRow(4) = DWRs("ConversionBoneUnknown")
            txtLink(4) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralBoneConversionID_=_9_AND_ReferralBoneConsentID_=_1_AND_ReferralBoneApproachID_=_1_AND_ReferralBoneAppropriateID_=_1_"
            txtRow(5) = intCalcPercentage(DWRs("ConversionTissueUnknown"), pvTotals(8))
            txtRow(6) = DWRs("ConversionTissueUnknown")
            txtLink(6) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralTissueConversionID_=_9_AND_ReferralTissueConsentID_=_1_AND_ReferralTissueApproachID_=_1_AND_ReferralTissueAppropriateID_=_1_"
            txtRow(7) = intCalcPercentage(DWRs("ConversionSkinUnknown"), pvTotals(9))
            txtRow(8) = DWRs("ConversionSkinUnknown")
            txtLink(8) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralSkinConversionID_=_9_AND_ReferralSkinConsentID_=_1_AND_ReferralSkinApproachID_=_1_AND_ReferralSkinAppropriateID_=_1_"
            txtRow(9) = intCalcPercentage(DWRs("ConversionValvesUnknown"), pvTotals(10))
            txtRow(10) = DWRs("ConversionValvesUnknown")
            txtLink(10) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralValvesConversionID_=_9_AND_ReferralValvesConsentID_=_1_AND_ReferralValvesApproachID_=_1_AND_ReferralValvesAppropriateID_=_1_"
            txtRow(11) = intCalcPercentage(DWRs("ConversionEyesUnknown"), pvTotals(11))
            txtRow(12) = DWRs("ConversionEyesUnknown")
            txtLink(12) = "&Options=&ReportID=9&NoLog=1&And=AND_ReferralEyesTransConversionID_=_9_AND_ReferralEyesTransConsentID_=_1_AND_ReferralEyesTransApproachID_=_1_AND_ReferralEyesTransAppropriateID_=_1_"
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
    vOriginalUserOrgId = pvUserOrgID    'drh 04/13/04 Added to fix permissions problem in Reason Summary
    pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
    pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
    pvReferralTypeID = FormatNumber(Request.QueryString("ReferralType"),0,,0,0)
    
    'Create a connection object
    Set Conn = server.CreateObject("ADODB.Connection")
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

Function intPrintHeader(txtColumns)
    %>
        <IMG SRC="/loginstatline/images/redline.jpg" ALIGN=CENTER HEIGHT=2 WIDTH="100%" ></IMG>
        
        <TABLE BORDER=0 WIDTH="100%" RULES="NONE" FRAME="VOID" cellPadding="0" cellSpacing="0">
        <TR>
        
    <%
    For i = 0 to Ubound(txtColumns,1)
    %>
            <TD><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"><%=txtColumns(i)%></FONT></B></TD>
            <% If i > 0 Then %>
            <TD WIDTH="8%"><B><FONT SIZE="<%=FontSizeHead%>" FACE="<%=FontNameHead%>"></FONT></B></TD>
            <% End IF %>
    <%
    Next
    %>
        
        </TR>
        </TABLE>
    <%
    'reset txtColumns array
    For i = 0 to Ubound(txtColumns,1)
        txtColumns(i) = ""
    Next
End Function%>

<%Function intPrintColumnHeader(txtColumns)
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
                    <A target="ReferralSummary" HREF="/loginstatline/reports/referral/summary_A.sls?StartDate=<%=Request("StartDate")%>&EndDate=<%=Request("EndDate")%>&ReportGroupID=<%=pvReportGroupID%>&OrgID=<%=pvOrgID%>&userID=<%=Request("UserID")%>&userOrgID=<%=vOriginalUserOrgId%>&DSN=Production<%=txtLink(i)%>">
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
%>

<!--REFERRAL COMP-->

<%
Function ProcessReferralComp()
    Dim DataWarehouseConn
    Dim vQString
    Dim vReportName
    Dim vTotals(2)
    Dim vPrevOrgID
        
'Execute the main page generating routine
'If AuthorizeMain Then

    Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
    DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD    'drh 1/6/04 - Un-hardcoded DSN
    
    Set Conn = server.CreateObject("ADODB.Connection")
    Conn.Open DataSourceName, DBUSER, DBPWD

    'Get the query variables
    Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
    Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
    pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
    pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
    pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)

    vQString = Request.QueryString


   'Check the Referral Compliance Update View Permission
    Set RSTestPermission = Server.CreateObject("ADODB.Recordset")
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
    cmd.CommandText = "SPS_FunctionsPermission"
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@USERID", adInteger, adParamInput)
    cmd.Parameters.Append cmd.CreateParameter("@FUNCTIONID", adInteger, adParamInput)
    cmd.Parameters("@USERID").Value = USERID
    cmd.Parameters("@FUNCTIONID").Value = 4 'FunctionID of the Referral Compliance Update
    Set RSTestPermission = cmd.Execute
    IF Not RSTestPermission.EOF then
        CompUpdateTest=RSTestPermission("FunctionString")
    ELSE
        CompUpdateTest=FALSE
    END IF


    
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
    
%>

    <!-- include virtual="/loginstatline/reports/referral/statistics/SummaryHeader.sls"-->

    <!-- Display Table Header -->

    <IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

    <TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">

    <TR>
        <%If pvOrgID <> 0 Then%>
            <TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Year / Month</B></TD>
        <%Else%>
            <TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referral Facility</B></TD>
        <%End If%>
        
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>%</B></TD>
        <TD ALIGN=Left width="11%"><% If CompUpdateTest then %><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Update</B><% End If %></TD>
                
        
        
    <TR><TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp;</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Deaths</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Compliance</B></TD>
        <TD ALIGN=Left width="11%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Deaths</B></TD>    
        
    <TR><TD COLSPAN=5><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>    
        
<%
    vCurrentColor = "bgcolor=#FFFFFF"
    vTotals(0) = 0
    vPrevOrgID = 0
    
    'A report group has been selected so get the list of organizations
    'to be processed
    vQuery = "sps_ReferralCompliance4 " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
    
    Set RS = DataWarehouseConn.Execute(vQuery)

    Do While Not RS.EOF
%>
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
            
            <%If IsNull(RS("AllTypes")) Then%>
                <TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">0</FONT></TD>
            <%Else%>
                <TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("AllTypes")%></FONT></TD>
            <%End If%>
            
            <%
            If IsNull(RS("AllTypes")) Then
                vTotals(0) = vTotals(0) + 0
            Else
                vTotals(0) = vTotals(0) + RS("AllTypes")
            End If
            %>
            
            <!-- Detail -->
            <%' Added If statement to check if the value of RS("TotalDeaths") is equal
	    ' to -1. Value of -1 means that organization did not report any deaths during timeframe
	    ' specified. If Organization's Source Code = "GOLM" then insert cross symbol (&#134),
	    ' if not, insert a 0  -- Copied from ReferralComp.sls 11/2/04 - SAP %>
	    <%If RS("TotalDeaths")=-1 then%>
		<%If GetSourceCodeNameReportGroupID(request("ReportGroupID"))="GOLM" Then%>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%="&#134"%></FONT></TD>
		<%Else%>
			<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">-</FONT></TD>
		<%End If%>
	    <%Else
		vTotals(1) = vTotals(1) + RS("TotalDeaths")   ' Moved inside of IF/Else to eliminate adding -1.  9/9/04 - SAP  %>
		<TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("TotalDeaths")%></FONT></TD>
            <%End If%>
            
            <%If (RS("TotalDeaths") = 0 Or IsNull(RS("TotalDeaths"))) And RS("AllTypes") > 0 Then%>
                <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">-</FONT></I></TD>            
            <%ElseIf (RS("TotalDeaths") = 0 Or IsNull(RS("TotalDeaths"))) And RS("AllTypes") = 0 Then%> 
                <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">100%</FONT></I></TD>    
            <%Else%>
                <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("AllTypes")/RS("TotalDeaths"))*100,0)%>%</FONT></I></TD>
            <%End If%>
    
            <%
            'Response.write vPrevOrgID
            
            vQString = Replace(vQString, "&OrgID=" & vPrevOrgID, "&OrgID=" & RS("OrganizationID"))
            vPrevOrgID = RS("OrganizationID")
            'Response.Write (" RS(OrganizationID) " & RS("OrganizationID"))
            'Response.Write (" OrgID " & OrgID)
            'Response.Write (" UserOrgID " & UserOrgID)
            
            %>
            
            
            <TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">
            <% If CompUpdateTest then %>
                        <A target="UpdateReferralCompliance" HREF="/loginstatline/forms/UpdateReferralComp.sls?<%=vQString%>&NoLog=1&Update=1">Update<A>
            <% End If %>
            </FONT>
            </TD>
            
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
    <TR><TD COLSPAN=5><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

    <TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
        <TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>
        <TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
        <%If  vTotals(0) > 0 And vTotals(1) = 0 Then%>
            <TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">-</FONT></I></TD>            
        <%ElseIf vTotals(0) = 0 And vTotals(1) = 0 Then%>
            <TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">100%</FONT></I></TD>
        <%Else%>    
            <TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(0)/vTotals(1))*100,0)%>%</B></I></FONT></TD>        
        <%End If%>
    </TR>

    </TABLE>
<%
'End If

Set RS = Nothing
Set Conn = Nothing
Set DataWarehouseConn = Nothing

End Function
%>

<!--HOSPITAL REPORT TIMES-->
<!--#include virtual="/loginstatline/includes/HospitalReportTime.vbs"-->

<%
Function ProcessHospitalReportTimes()
    Dim DataWarehouseConn
    Dim TimeRangeList
    
    
'Execute the main page generating routine
'If AuthorizeMain Then

    Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
    DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD    'drh 1/6/04 - Un-hardcoded DSN
    
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
    
%>

    <!-- include virtual="/loginstatline/reports/referral/statistics/HospitalReportTimeSummary_AHead.sls"-->

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
    
    IF pvOrgID = 0 Then
        vGroupSection = RS("OrganizationName")
    Else
            vGroupSection = DateLiteral(RS("MonthID") & "/1/" & RS("YearID"))
    End IF    
    Call TableHeader()
    
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
        '    TimeRangeName = TimeRangeList(1,TimeRangeTrack)
        '    AllTypes = 0
        '    AppropriateOrgan = 0
        '    AppropriateAllTissue = 0
        '    AppropriateEyes = 0
        '    AppropriateRO = 0
        '    
        '    Call PrintRow()

        '    TimeRangeTrack = TimeRangeTrack + 1
        'Loop
            'Call Total()
    
            'Response.Write "</TABLE>"
                    
            
        %>

        <!-- Process Subtotals -->
        <%
        
        'If pvOrgID = 0 AND LastOrganizationID <> RS("OrganizationID")AND LastOrganizationID <> "" Then    
        '    Call SubTotal(1)
        'End If    
        'If pvOrgID <> 0 AND LastMonthYear <> "" Then
        '    If LastMonthYear <> RS("MonthYear")Then    
        '        Call SubTotal(1)
        '    End If    
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
        %>    </TABLE>
        <%
    End if
    
'End If

Set RS = Nothing
Set Conn = Nothing
Set DataWarehouseConn = Nothing

End Function
%>
</body>
</html>
<%
        Function PrintRow()
        %>
                <TR>
                    <TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%= TimeRangeName%></TD>
                                
                    <TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>">
		<%	' Changed construction of these links to match those of HospitalReportTimeSummary_A.sls
			' because the report summary page being returned contained non-organization-specific referrals. 11/14/04 - SAP
			IF pvOrgID > 0 Then%>
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
End Function%>

<!--APPROACH SUMMARY-->

<%
Function ProcessApproachSummary()
    Dim DataWarehouseConn
    
'Execute the main page generating routine
'If AuthorizeMain Then

    Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
    DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD    'drh 1/6/04 - Un-hardcoded DSN
    
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
    
%>

    <!-- include virtual="/loginstatline/reports/referral/statistics/SummaryHeader.sls"-->

    <!-- Display Table Header -->

    <IMG SRC="/loginstatline/images/redline.jpg" height=2 WIDTH="100%">

    <TABLE BORDER=0 WIDTH="100%" cellPadding="2" cellSpacing="0">

    <TR>
        <%If pvOrgID <> 0 Then%>
            <TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Year / Month</B></TD>
        <%Else%>
            <TD ALIGN=Left width="32%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referral Facility</B></TD>
        <%End If%>
        
        <TD ALIGN=Left width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
        <TD ALIGN=Left width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Total</B></TD>
        
        <TD ALIGN=Left width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
        <TD ALIGN=Left width="8%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
        <TD ALIGN=Left width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
        <TD ALIGN=Left width="8%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
        <TD ALIGN=Left width="5%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
        <TD ALIGN=Left width="12%"><FONT SIZE="1" FACE="<%=FontNameHead%>">&nbsp;</TD>
        
        <TD ALIGN=Left width="8%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Unknown</B></TD>
        
    <TR><TD ALIGN=Left width="30%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>&nbsp</B></TD>
        <TD ALIGN=Left width="9%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Referrals</B></TD>
        <TD ALIGN=Left width="10%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Approached</B></TD>

        <TD ALIGN=Left COLSPAN=2 width="13%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Pre-Referral</TD>
        <TD ALIGN=Left COLSPAN=2 width="13%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Post Referral</TD>
        <TD ALIGN=Left COLSPAN=2 width="17%"><FONT SIZE="1" FACE="<%=FontNameHead%>">Family Initiated</TD>
        
        <TD ALIGN=Left width="8%"><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Approach</B></TD>
        
    <TR><TD COLSPAN=10><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

<%
    vCurrentColor = "bgcolor=#FFFFFF"
    
    'A report group has been selected so get the list of organizations
    'to be processed
    vQuery = "sps_ApproachSummary_A " & pvReportGroupID & ", '" & pvStartDate & "', '" & pvEndDate & "', " & pvOrgID
    
    Set RS = DataWarehouseConn.Execute(vQuery)

    Do While Not RS.EOF
                        
        vAnd = "_AND_ReferralCallerOrganizationID_=_" & RS("OrganizationID") & "_" 
            
%>
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
            <TD <%=vCurrentColor%> ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><I><%=RS("AllTypes")%></I></FONT></TD>
<%
            vTotals(0) = vTotals(0) + RS("AllTypes")
%>
    <!-- Approach Types -->
            <%
            vTotals(1) = vTotals(1) + RS("TotalApproached")
            %>            
            <TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("TotalApproached")%></FONT></TD>
    
            <%
            vTotals(2) = vTotals(2) + RS("PreRefFacilityApproach")
            %>            
            <TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("PreRefFacilityApproach")%></FONT></TD>
            <%If RS("TotalApproached") = 0 Then%>
                <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>            
            <%Else%>
                <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("PreRefFacilityApproach")/RS("TotalApproached"))*100,0)%>%</FONT></I></TD>
            <%End If%>
            
            <%            
            vTotals(3) = vTotals(3) + RS("PostRefApproach")
            %>
            <TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("PostRefApproach")%></FONT></TD>
            <%If RS("TotalApproached") = 0 Then%>
                <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>            
            <%Else%>            
                <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("PostRefApproach")/RS("TotalApproached"))*100,0)%>%</FONT></I></TD>
            <%End If%>
            
            <%
            vTotals(4) = vTotals(4) + RS("PreRefFamilyApproach")            
            %>
            <TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=RS("PreRefFamilyApproach")%></FONT></TD>
            <%If RS("TotalApproached") = 0 Then%>
                <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>            
            <%Else%>            
                <TD <%=vCurrentColor%>><I><FONT SIZE="1" FACE="<%=FontNameHead%>"><%=FormatNumber((RS("PreRefFamilyApproach")/RS("TotalApproached"))*100,0)%>%</FONT></I></TD>
            <%End If%>
                
            <%
            vTotals(5) = vTotals(5) + RS("UnknownApproach")            
            vAnd = "_AND_ReferralCallerOrganizationID_=_" & RS("OrganizationID") & "_" & "AND_ReferralApproachTypeID_IN_(7,-1)_" 
            %>
            <TD <%=vCurrentColor%>><FONT SIZE="1" FACE="<%=FontNameHead%>">
            <A target="ReferralSummary" HREF="../summary_A.sls?<%=Request.QueryString%>&NoLog=1&AND=<%=vAnd%>">
            <%=RS("UnknownApproach")%><A></FONT></TD>
            
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
    <TR><TD COLSPAN=10><HR ALIGN=CENTER COLOR="#000000" NOSHADE SIZE=1 WIDTH="100%"></TD></TR>

    <TR><TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B>Totals</B></TD>
        <TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(0)%></B></FONT></TD>
        <TD ALIGN=Left><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(1)%></B></FONT></TD>
        <!-- Approach Totals -->
        <TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(2)%></B></FONT></TD>
        <%If vTotals(1) = 0 Then%>
            <TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>            
        <%Else%>        
            <TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(2)/vTotals(1))*100,0)%>%</B></I></FONT></TD>        
        <%End If%>
        <TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(3)%></B></FONT></TD>
        <%If vTotals(1) = 0 Then%>
            <TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>            
        <%Else%>            
            <TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(3)/vTotals(1))*100,0)%>%</B></I></FONT></TD>        
        <%End If%>
        <TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(4)%></B></FONT></TD>
        <%If vTotals(1) = 0 Then%>
            <TD><I><FONT SIZE="1" FACE="<%=FontNameHead%>">0%</FONT></I></TD>            
        <%Else%>            
            <TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><I><%=FormatNumber((vTotals(4)/vTotals(1))*100,0)%>%</B></I></FONT></TD>        
        <%End If%>
        <TD><FONT SIZE="1" FACE="<%=FontNameHead%>"><B><%=vTotals(5)%></B></FONT></TD>
    </TR>

    </TABLE>
<%
'End If

Set RS = Nothing
Set Conn = Nothing
Set DataWarehouseConn = Nothing

End Function
%>

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

%>