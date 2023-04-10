<% Option Explicit %>


<%
' ccarroll 03/23/2006 - Added fields per StatTrac 8.0 Design Specification document
' 4.6.4 -	182 DOB_ILB
'		183 DonorSpecificCOD
'		184 DonorBrainDeathDate 
'		185 DonorBrainDeathTime
'		186 PronouncingMDPhone
'		187 AttendingMDPhone

'Declare variables
Dim ErrorReturn
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim vOrgList
Dim pvUserOrgID
Dim pvOrgID
Dim pvReportGroupID
Dim pvReferralTypeID
Dim pvCallID
Dim pvOrderBy
Dim pvOptions
Dim pvNoName
Dim vReportGroupName
Dim vReportTitle
Dim vShowGroup1
Dim Identify
Dim Org
Dim Children
Dim Referral
Dim vTZ
Dim i
Dim RHead(3)
Dim y
Dim x
Dim ResultArray
Dim TypeName
Dim RefDataArray
Dim Section2
Dim Section4
Dim vNoRecords
Dim CountCheck

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData
Dim FontNameHeadLog
Dim FontSizeHeadLog
Dim FontSizeDataLog
Dim FontNameDataLog
Dim ErrorCatch
Dim vRecord
'07/15/2004 BJK added functionality to name the file in the format 'RYYMMDDhhmm.TXT
' The change uses the following three variables
Dim FileName 'store the text of the file name
Dim FileNameDate ' stores the date the FileName is based on.
Dim FileNameTime ' stores the time the FileName is based on.

'Declare format vaiables
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "2"
FontNameHeadLog = "Arial"
FontSizeHeadLog = "1.5"
FontNameDataLog = "Times New Roman"
FontSizeDataLog = "1.5"


'07/15/2004 BJK SET THE date and time variables.
FileNameDate = FormatDateTime(Now(), 2)
FileNameTime = FormatDateTime(Now(), 4)

' Set the file name based on the date and time variables
FileName = ""
FileName = FileName & "R"
FileName = FileName & DatePart("yyyy",FileNameDate)  ' Use date part to get year
FileName = FileName & Right("0" & DatePart("m", FileNameDate), 2)  'Use date part to get month, force leading zero
FileName = FileName & Right("0" & DatePart("d", FileNameDate), 2)  'Use date part to get date, force leading zero

FileName = FileName & LEFT(FileNameTime,2) 'DatePart("h",FileNameDate)  'use left of time to get hour
FileName = FileName & RIGHT(FileNameTime,2)'DatePart("n",FileNameDate)  ' use right of time to get minute
FileName = FileName & ".txt"

Response.AddHeader "Content-Disposition", "attachment; filename=" & FileName
Response.ContentType = "application/unknown"
Response.Buffer = True

%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/VerifyRefType.vbs"-->
<!--#include virtual="/loginstatline/includes/FTPQueryReferralDetail_Extended_2006.sls"-->
<%

'Execute the main page generating routine

'Print " Detail_1 " & DataSourceName
'Get the query variables
Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
pvUserOrgID = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
pvOrgID = FormatNumber(Request.QueryString("OrgID"),0,,0,0)
pvReportGroupID = FormatNumber(Request.QueryString("ReportGroupID"),0,,0,0)
pvReferralTypeID = FormatNumber(Request.QueryString("ReferralType"),0,,0,0)
pvCallID = FormatNumber(Request.QueryString("CallID"),0,,0,0)
pvOrderBy = Request.QueryString("OrderBy")
pvOptions = Request.QueryString("Options")



If AuthorizeMain Then



	'Create a connection object
	Set Conn = server.CreateObject("ADODB.Connection")
	Server.ScriptTimeout = 270
	Conn.CommandTimeout = 90
	Conn.Open DataSourceName, DBUSER, DBPWD


	'Call the referral type verification routine
	If VerifyReferralTypeAccess(True) Then



		If ExecuteMain Then
		%>

			<%TypeName = ""
			If vNoRecords Then
				'print an empty string

				Response.Clear

			Else


				'CLEAR ANY CONTENT
				Response.Clear

				'LastModified
				'ReferralID
				'ReferralNumber
				'ReferralDateTime
				'ReferralTakenBy
				'ReferralTypeID
				'ReferralType
				'ReferralStatusID
				'ReferralStatus
				'CallerPhone
				'CallerExtension
				'CallerName
				'CallerTitle
				'CallerOrganizationCode
				'CallerOrganization
				'CallerOrganizationUnit
				'PatientFirstName
				'PatientLastName
				'PatientRecordNumber
				'PatientAge
				'PatientAgeUnit
				'PatientRaceID
				'PatientRace
				'PatientGender
				'PatientWeight
				'PatientCauseOfDeathID
				'PatientCauseOfDeath
				'PatientStandardMRO
				'Unused
				'PatientAdmitDate
				'PatientAdmitTime
				'PatientOnVentilator
				'Unused
				'PatientDeathDate
				'PatientDeathTime
				'ApproachTypeID
				'ApproachType
				'ApproachBy
				'ApproachNOK
				'ApproachNOKRelation
				'AppropriateOrganID
				'AppropriateBoneID
				'AppropriateSoftTissueID
				'AppropriateSkinID
				'AppropriateValvesID
				'AppropriateEyesID
				'ApproachedOrganID
				'ApproachedBoneID
				'ApproachedSoftTissueID
				'ApproachedSkinID
				'ApproachedValvesID
				'ApproachedEyesID
				'ConsentedOrganID
				'ConsentedBoneID
				'ConsentedSoftTissueID
				'ConsentedSkinID
				'ConsentedValvesID
				'ConsentedEyesID
				'RecoveredOrganID
				'RecoveredBoneID
				'RecoveredSoftTissueID
				'RecoveredSkinID
				'RecoveredValvesID
				'RecoveredEyesID
				'OrganDispositionID
				'AllTissueDispositionID
				'EyeDispositionID
				'BoneDispositionID
				'SoftTissueDispositionID
				'SkinDispositionID
				'ValvesDispositionID
				'GeneralConsent
				'ReferralExtubated
				'DOB
				'DonorSSN
				'Coroners Case
				'Coroner County
				'AppropriateOtherID
				'AppoachedOtherID
				'ConsentedOtherID
				'RecoveredOtherID
				'OtherDispositionID
				'customField_1
				'customField_2
				'customField_3
				'customField_4
				'customField_5
				'customField_6
				'customField_7
				'customField_8
				'customField_9
				'customField_10
				'customField_11
				'customField_12
				'customField_13
				'customField_14
				'customField_15
				'customField_16
				'ServiceLevelCustomFieldLabel_1
				'ServiceLevelCustomFieldLabel_2
				'ServiceLevelCustomFieldLabel_3
				'ServiceLevelCustomFieldLabel_4
				'ServiceLevelCustomFieldLabel_5
				'ServiceLevelCustomFieldLabel_6
				'ServiceLevelCustomFieldLabel_7
				'ServiceLevelCustomFieldLabel_8
				'ServiceLevelCustomFieldLabel_9
				'ServiceLevelCustomFieldLabel_10
				'ServiceLevelCustomFieldLabel_11
				'ServiceLevelCustomFieldLabel_12
				'ServiceLevelCustomFieldLabel_13
				'ServiceLevelCustomFieldLabel_9
				'ServiceLevelCustomFieldLabel_10
				'ServiceLevelCustomFieldLabel_11
				'ServiceLevelCustomFieldLabel_12
				'ServiceLevelCustomFieldLabel_13
				'ServiceLevelCustomFieldLabel_14
				'ServiceLevelCustomFieldLabel_15
				'ServiceLevelCustomFieldLabel_16
				'CoronerState
				'CoronerOrganization
				'CoronerName
				'CoronerPhone
				'CoronerNote
				'ApproachNOKPhone
				'ApproachNOKAddress
				'RegistryStatusID
				'RegistryStatus
				'PatientHasHeartbeat
				'DOA
				'AttendingPhysician
				'PronouncingPhysician
				

				For i = 0 to Ubound(ResultArray, 2)

					'vRecord = ""
					'for x = 0 to Ubound(ResultArray,1)
					'vRecord = vRecord & resultarray(x, i)& chr(9) '118 LastModified
					'Next
					'Response.Write(vRecord)

					vRecord = ""
					vRecord = vRecord & resultarray(122, i) & chr(9) '122 LastModified
					vRecord = vRecord & resultarray(0, i)& chr(9) '0 ReferralID
					vRecord = vRecord & resultarray(2, i)& chr(9) '2 CallNumber
					vRecord = vRecord & resultarray(168, i)& chr(9) '168 ftpCalldatetime

					'vRecord = vRecord & resultarray(4, i)& " " '4 CallDate
					'vRecord = vRecord & resultarray(5, i)& chr(9) '5 CallTime
					'vRecord = vRecord & resultarray(3, i) & chr(9)  '3 CallDateTime

					vRecord = vRecord & resultarray(6, i) & " " '6 StatPersonFirstName
					vRecord = vRecord & resultarray(7, i)& chr(9) '7 StatPersonLastName
					vRecord = vRecord & resultarray(11, i)& chr(9) '11 ReferralTypeID
					vRecord = vRecord & resultarray(12, i)& chr(9) '12 ReferralTypeName
					vRecord = vRecord & "1" & chr(9) ' ReferralStatusID
					vRecord = vRecord & "Complete" & chr(9) ' ReferralStatus
					vRecord = vRecord & resultarray(21, i)& chr(9) '21 Phone
					vRecord = vRecord & resultarray(22, i)& chr(9) '22 ReferralCallerExtension
					vRecord = vRecord & resultarray(16, i)& " " '16 CallPersonFirst
					vRecord = vRecord & resultarray(17, i)& chr(9) '17 CallerPersonLast
					vRecord = vRecord & resultarray(18, i)& chr(9) '18 CallerPersonTitle
					vRecord = vRecord & resultarray(123, i)& chr(9) '123 OrganizationUserCode
					vRecord = vRecord & resultarray(15, i)& chr(9) '15 OrganizationName
					vRecord = vRecord & resultarray(19, i)& " " '19 SubLocationName
					vRecord = vRecord & resultarray(20, i)& chr(9) '20 ReferralCallerSubLocationLevel
					vRecord = vRecord & resultarray(14, i)& chr(9) '14 ReferralDonorFirstName
					vRecord = vRecord & resultarray(13, i)& chr(9) '13 ReferralDonorLastName
					vRecord = vRecord & resultarray(167, i)& chr(9) '167 ReferralDonorRecNumber
					vRecord = vRecord & resultarray(24, i)& chr(9) '24 ReferralDonorAge
					vRecord = vRecord & resultarray(25, i)& chr(9) '25 ReferralDonorAgeUnit
					vRecord = vRecord & resultarray(124, i)& chr(9) '124 ReferralDonorRaceID
					vRecord = vRecord & resultarray(34, i)& chr(9) '34 RaceName
					vRecord = vRecord & resultarray(26, i)& chr(9) '26 ReferralDonorGender
					vRecord = vRecord & resultarray(27, i)& chr(9) '27 ReferralDonorWeight
					vRecord = vRecord & resultarray(125, i)& chr(9) '125 ReferralDonorCauseOfDeathID
					vRecord = vRecord & resultarray(35, i)& chr(9) '35 CauseOfDeathName
					vRecord = vRecord & resultarray(166, i)& chr(9) '166 ReferralNotesCase
					vRecord = vRecord & 0 & chr(9) ' Unused
					vRecord = vRecord & resultarray(29, i)& chr(9) '29 ReferralDonorAdmitDate
					vRecord = vRecord & resultarray(30, i)& chr(9) '30 ReferralDonorAdmitTime
					vRecord = vRecord & resultarray(28, i)& chr(9) '28 ReferralDonorOnVentilator
					vRecord = vRecord & 0 & chr(9) ' Unused
					vRecord = vRecord & resultarray(31, i)& chr(9) '31 ReferralDonorDeathDate
					vRecord = vRecord & resultarray(32, i)& chr(9) '32 ReferralDonorDeathTime
					vRecord = vRecord & resultarray(89, i)& chr(9) '89 ReferralApproachTypeId
					vRecord = vRecord & resultarray(36, i)& chr(9) '36 ApproachTypeName
					vRecord = vRecord & resultarray(37, i)& " " '37 ApproachPersonFirst
					vRecord = vRecord & resultarray(38, i)& chr(9) '38 ApproachPersonLast
					vRecord = vRecord & resultarray(39, i)& chr(9) '39 ReferralApproachNOK
					vRecord = vRecord & resultarray(40, i)& chr(9) '40 ReferralApproachRelation
					vRecord = vRecord & resultarray(126, i)& chr(9) '126 ReferralOrganAppropriateID
					vRecord = vRecord & resultarray(127, i)& chr(9) '127 ReferralBoneAppropriateID
					vRecord = vRecord & resultarray(128, i)& chr(9) '128 ReferralTissueAppropriateID
					vRecord = vRecord & resultarray(129, i)& chr(9) '129 ReferralSkinAppropriateID
					vRecord = vRecord & resultarray(130, i)& chr(9) '130 ReferralValvesAppropriateID
					vRecord = vRecord & resultarray(131, i)& chr(9) '131 ReferralEyesTransAppropriateID
					vRecord = vRecord & resultarray(132, i)& chr(9) '132 ReferralOrganApproachID
					vRecord = vRecord & resultarray(133, i)& chr(9) '133 ReferralBoneApproachID
					vRecord = vRecord & resultarray(134, i)& chr(9) '134 ReferralTissueApproachID
					vRecord = vRecord & resultarray(135, i)& chr(9) '135 ReferralSkinApproachID
					vRecord = vRecord & resultarray(136, i)& chr(9) '136 ReferralValvesApproachID
					vRecord = vRecord & resultarray(137, i)& chr(9) '137 ReferralEyesTransApproachID
					vRecord = vRecord & resultarray(138, i)& chr(9) '138 ReferralOrganConsentID
					vRecord = vRecord & resultarray(139, i)& chr(9) '139 ReferralBoneConsentID
					vRecord = vRecord & resultarray(140, i)& chr(9) '140 ReferralTissueConsentID
					vRecord = vRecord & resultarray(141, i)& chr(9) '141 ReferralSkinConsentID
					vRecord = vRecord & resultarray(142, i)& chr(9) '142 ReferralValvesConsentID
					vRecord = vRecord & resultarray(143, i)& chr(9) '143 ReferralEyesTransConsentID
					vRecord = vRecord & resultarray(144, i)& chr(9) '144 ReferralOrganConversionID
					vRecord = vRecord & resultarray(145, i)& chr(9) '145 ReferralBoneConversionID
					vRecord = vRecord & resultarray(146, i)& chr(9) '146 ReferralTissueConversionID
					vRecord = vRecord & resultarray(147, i)& chr(9) '147 ReferralSkinConversionID
					vRecord = vRecord & resultarray(148, i)& chr(9) '148 ReferralValvesConversionID
					vRecord = vRecord & resultarray(149, i)& chr(9) '149 ReferralEyesTransConversionID
					vRecord = vRecord & resultarray(150, i)& chr(9) '150 ReferralOrganDispositionID
					vRecord = vRecord & resultarray(151, i)& chr(9) '151 ReferralAllTissueDispositionID
					vRecord = vRecord & resultarray(152, i)& chr(9) '152 ReferralEyesDispositionID
					vRecord = vRecord & resultarray(153, i)& chr(9) '153 ReferralBoneDispositionID
					vRecord = vRecord & resultarray(154, i)& chr(9) '154 ReferralTissueDispositionID
					vRecord = vRecord & resultarray(155, i)& chr(9) '155 ReferralSkinDispositionID
					vRecord = vRecord & resultarray(156, i)& chr(9) '156 ReferralValvesDispositionID
					vRecord = vRecord & resultarray(80, i)& chr(9) '80 ReferralGeneralConsent
					vRecord = vRecord & resultarray(84, i)& chr(9) '84 ReferralExtubated
					vRecord = vRecord & resultarray(162, i) & chr(9)'162 ReferralDOB
					vRecord = vRecord & resultarray(163, i)& chr(9) '163 ReferralDonorSSN
					vRecord = vRecord & resultarray(164, i)& chr(9) '164 CoronoersCase
					vRecord = vRecord & resultarray(165, i)& chr(9) '165 CoronerCounty
					vRecord = vRecord & resultarray(157, i)& chr(9) '157 ReferralEyesRschAppropriateID
					vRecord = vRecord & resultarray(158, i)& chr(9) '158 ReferralEyesRschApproachID
					vRecord = vRecord & resultarray(159, i)& chr(9) '159 ReferralEyesRschConsentID
					vRecord = vRecord & resultarray(160, i)& chr(9) '160 ReferralEyesRschConversionID
					vRecord = vRecord & resultarray(161, i)& chr(9) '161 ReferralRschDispositionID
					vRecord = vRecord & resultarray(90, i)& chr(9) '90 customField_1
					vRecord = vRecord & resultarray(91, i)& chr(9) '91 customField_2
					vRecord = vRecord & resultarray(92, i)& chr(9) '92 customField_3
					vRecord = vRecord & resultarray(93, i)& chr(9) '93 customField_4
					vRecord = vRecord & resultarray(94, i)& chr(9) '94 customField_5
					vRecord = vRecord & resultarray(95, i)& chr(9) '95 customField_6
					vRecord = vRecord & resultarray(96, i)& chr(9) '96 customField_7
					vRecord = vRecord & resultarray(97, i)& chr(9) '97 customField_8
					vRecord = vRecord & resultarray(98, i)& chr(9) '98 customField_9
					vRecord = vRecord & resultarray(99, i)& chr(9) '99 customField_10
					vRecord = vRecord & resultarray(100, i)& chr(9) '100 customField_11
					vRecord = vRecord & resultarray(101, i)& chr(9) '101 customField_12
					vRecord = vRecord & resultarray(102, i)& chr(9) '102 customField_13
					vRecord = vRecord & resultarray(103, i)& chr(9) '103 customField_14
					vRecord = vRecord & resultarray(104, i)& chr(9) '104 customField_15
					vRecord = vRecord & resultarray(105, i)& chr(9) '105 customField_16
					vRecord = vRecord & resultarray(106, i)& chr(9) '106 ServiceLevelCustomFieldLabel_1
					vRecord = vRecord & resultarray(107, i)& chr(9) '107 ServiceLevelCustomFieldLabel_2
					vRecord = vRecord & resultarray(108, i)& chr(9) '108 ServiceLevelCustomFieldLabel_3
					vRecord = vRecord & resultarray(109, i)& chr(9) '109 ServiceLevelCustomFieldLabel_4
					vRecord = vRecord & resultarray(110, i)& chr(9) '110 ServiceLevelCustomFieldLabel_5
					vRecord = vRecord & resultarray(111, i)& chr(9) '111 ServiceLevelCustomFieldLabel_6
					vRecord = vRecord & resultarray(112, i)& chr(9) '112 ServiceLevelCustomFieldLabel_7
					vRecord = vRecord & resultarray(113, i)& chr(9) '113 ServiceLevelCustomFieldLabel_8
					vRecord = vRecord & resultarray(114, i)& chr(9) '114 ServiceLevelCustomFieldLabel_9
					vRecord = vRecord & resultarray(115, i)& chr(9) '115 ServiceLevelCustomFieldLabel_10
					vRecord = vRecord & resultarray(116, i)& chr(9) '116 ServiceLevelCustomFieldLabel_11
					vRecord = vRecord & resultarray(117, i)& chr(9) '117 ServiceLevelCustomFieldLabel_12
					vRecord = vRecord & resultarray(118, i)& chr(9) '118 ServiceLevelCustomFieldLabel_13
					vRecord = vRecord & resultarray(119, i)& chr(9) '119 ServiceLevelCustomFieldLabel_14
					vRecord = vRecord & resultarray(120, i)& chr(9) '120 ServiceLevelCustomFieldLabel_15
					vRecord = vRecord & resultarray(121, i)& chr(9)'121 ServiceLevelCustomFieldLabel_16
					
						
					'Extended Referral 2004 2/8/2005 CAC
					vRecord = vRecord & resultarray(169, i)& chr(9) '169 CoronerState
					vRecord = vRecord & resultarray(170, i)& chr(9) '170 CoronerOrganization
					vRecord = vRecord & resultarray(171, i)& chr(9) '171 CoronerName
					vRecord = vRecord & resultarray(172, i)& chr(9) '172 CoronerPhone
					vRecord = vRecord & resultarray(173, i)& chr(9) '173 CoronerNote
					vRecord = vRecord & resultarray(174, i)& chr(9) '174 ApproachNOKPhone
					vRecord = vRecord & resultarray(175, i)& chr(9) '175 ApproachNOKAddress
					vRecord = vRecord & resultarray(176, i)& chr(9) '176 RegistryStatusID
					vRecord = vRecord & resultarray(177, i)& chr(9) '177 RegistryStatus
					vRecord = vRecord & resultarray(178, i)& chr(9) '178 PatientHasHeartbeat
					vRecord = vRecord & resultarray(179, i)& chr(9) '179 DOA
					vRecord = vRecord & resultarray(180, i)& chr(9) '180 AttendingPhysician
					vRecord = vRecord & resultarray(181, i)& chr(9) '181 PronouncingPhysician
					
					'4.6.4 -ccarroll 03/23/2006 - Added fields per StatTrac 8.0 Design Specification document
					vRecord = vRecord & resultarray(182, i)& chr(9) '182 DOB_ILB
					vRecord = vRecord & resultarray(183, i)& chr(9) '183 DonorSpecificCOD
					vRecord = vRecord & resultarray(184, i)& chr(9) '184 DonorBrainDeathDate
					vRecord = vRecord & resultarray(185, i)& chr(9) '185 DonorBrainDeathTime
					vRecord = vRecord & resultarray(186, i)& chr(9) '186 PronouncingMDPhone
					vRecord = vRecord & resultarray(187, i)& chr(9) '187 AttendingMDPhone
					vRecord = vRecord & resultarray(188, i)& chr(13) & chr(10)'188 ReferralTypeName
					
					Response.Write(vRecord)

					Response.flush
					'FOR forLoop = 0 to UBound(ResultArray,1)
					'Response.Write(forLoop & " " & ResultArray(forLoop,i) & "<br>")
					'Next


					'<!-- Format and display each section -->
					'<!--#include virtual="/loginstatline/reports/referral/DetailSection1_1.sls"-->
					'<!--#include virtual="/loginstatline/reports/referral/DetailSection2_1.sls"-->
					'<!--#include virtual="/loginstatline/reports/referral/DetailSection3_1.sls"-->
					'<!--#include virtual="/loginstatline/reports/referral/DetailSection4_1.sls"-->


					%>



				<%Next
			End If

			Set Referral = Nothing

		End If



	End If

End If

Set Conn = Nothing

%>


<%
Function ExecuteMain()

	'Parse the option settings
	If pvOptions = "" Then
		pvOptions = 0
	End If

	pvNoName = Mid(pvOptions, 1, 1)


	'Set Order By
	If pvOrderBy = "" Or pvOrderBy = "0" Then
		pvOrderBy = "CallDateTime"
		vShowGroup1 = True
	Else
		If Left(pvOrderBy, 23) = "Referral.ReferralTypeID" Then
			vShowGroup1 = True
		Else
			vShowGroup1 = False
		End If
	End If

	If Right(pvOrderBy,1) = "," Then
		pvOrderBy = Mid(pvOrderBy, 1, Len(pvOrderBy) - 1)
	End If

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
			vErrorMsg = vErrorMsg & "Error:     (100, GetOrganization, Detail.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function
		End If

		Set RS = Nothing

	End If


	If pvCallID = 0 Then

		'This is a multiple referral request
		If pvReportGroupID <> 0 AND pvOrgID = 0 Then

			'If a report group has been selected, get the report group name
			'and set the report title to the name of the report group
			vQuery = "sps_ReportGroupName " & pvReportGroupID & " "
			Set RS = Conn.Execute(vQuery)

			If RS.EOF = True Then
				vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
				vErrorMsg = vErrorMsg & "The selected report group is no longer valid. Please select another group.<BR> <BR>"
				vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
				vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance. </B> <BR> <BR> <BR>"
				vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
				vErrorMsg = vErrorMsg & "Error:     (100, GetReportGroupName, Activity.sls) <BR> <BR>"
				vErrorMsg = vErrorMsg & "</FONT></FONT>"
				Response.Write(vErrorMsg)
				Response.Write(vErrorMsg)
				ExecuteMain = False
				Exit Function
			Else
				vReportTitle = RS("WebReportGroupName")
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
				vErrorMsg = vErrorMsg & "Error:     (100, GetOrganizationName, Detail.sls) <BR> <BR>"
				vErrorMsg = vErrorMsg & "</FONT></FONT>"
				Response.Write(vErrorMsg)
				ExecuteMain = False
				Exit Function
			Else
				vReportTitle = RS("OrganizationName")
			End If

			Set RS = Nothing

		ElseIf pvOrgID = 0 AND pvReportGroupID = 0 Then

			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "Either a report group or an organization must be selected. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (-1, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function

		Else

			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "Unexpected Error. <BR> "
			vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
			vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (-1, Unexpected, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)
			ExecuteMain = False
			Exit Function

		End If

	End If

	vQuery = "sps_OrganizationTimeZone " & pvUserOrgID & " "
	Set RS = Conn.Execute(vQuery)
	vTZ = RS("OrganizationTimeZone")
	Set RS = Nothing

	SET ErrorCatch =  server.CreateObject("ADODB.Error")
	'Response.Write formatDateTime(Now(),vblongtime)
	vQuery = GetDetailList()
	'Response.Write vQuery
	If isnull(GetDetailList) Then
		Set RS = Nothing
		ExecuteMain = True
		vNoRecords = True
		Exit Function

	End if

	'Response.Write vQuery

	Set RS = Conn.Execute(vQuery)
	'Response.Write formatDateTime(Now(),vblongtime)
	vNoRecords = False


	If ErrorCatch.Number <> 0 Then
		vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
		vErrorMsg = vErrorMsg & "There has been a database error. <BR>"
		vErrorMsg = vErrorMsg & "Please click refresh to try your request again. <BR> <BR>"
		vErrorMsg = vErrorMsg & "If the problem continues, <BR>"
		vErrorMsg = vErrorMsg & "please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
		vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
		vErrorMsg = vErrorMsg & "Error:     (" & ErrorReturn & ", Referral.GetCallList, Activity.sls) <BR> <BR>"
		vErrorMsg = vErrorMsg & "</FONT></FONT>"
		Response.Write(vErrorMsg)
		ExecuteMain = False
		Exit Function
	Else
		If RS.EOF Then
			vNoRecords = True
		Else
			ResultArray = RS.GetRows
		End if
	End If

	Set RS = Nothing

	ExecuteMain = True

End Function



Sub FixQueryString(pvIn, pvOut)

	Dim j

	pvOut = ""

	For j=1 TO Len(pvIn)

		If Mid(pvIn,j,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,j,1)
		End If

	Next

End Sub

'This sub is used by DetailSection3 to format note fields
Sub OutputMemo(memo)

	IF IsNull(memo) or memo = "" Then

		Exit Sub

	End If
	Dim mx

	For mx=1 to Len(memo)

		If Asc(Mid(memo, mx, 1)) = 13 Then
			Response.Write("<BR>")
		Else
			Response.Write(Mid(memo,mx,1))
		End If
	Next
End Sub%>
