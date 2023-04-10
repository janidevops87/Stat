<% Option Explicit %>


<%
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
Dim forloop
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

Server.ScriptTimeout = 10000

%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/VerifyRefType.vbs"-->
<!--#include virtual="/loginstatline/includes/FTPQueryReferralDetail_FS_Extended_2004.sls"-->
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

'debugging
'response.write pvReportGroupID



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
				'****************Family Services Data Fields********************
				'************************CAC 2/17/2005**************************
				'*****FSCase Table Fields*************
				'FSCaseId, FSCaseCreateUserId, FSCaseCreateDateTime, FSCaseOpenUserId, FSCaseOpenDateTime, 
				'FSCaseSysEventsUserId, FSCaseSysEventsDateTime, FSCaseSecCompUserId, FSCaseSecCompDateTime, 
				'FSCaseApproachUserId, FSCaseApproachDateTime, FSCaseFinalUserId, FSCaseFinalDateTime, FSCaseUpdate, 
				'FSCaseUserId, FSCaseBillSecondaryUserID, FSCaseBillDateTime, FSCaseBillApproachUserID, 
				'FSCaseBillApproachDateTime, FSCaseBillMedSocUserID, FSCaseBillMedSocDateTime, 
				'SecondaryManualBillPersonId, SecondaryUpdatedFlag, FSCaseTotalTime, FSCaseSeconds,  
				'FSCaseBillFamUnavailUserId, FSCaseBillFamUnavailDateTime, FSCaseBillCryoFormUserId, 
				'FSCaseBillCryoFormDateTime, FSCaseBillApproachCount, FSCaseBillMedSocCount, FSCaseBillCryoFormCount 
				
				'*****Secondary Table Fields*************
				'SecondaryWhoAreWe, SecondaryNOKaware, SecondaryFamilyConsent, 
				'SecondaryFamilyInterested, SecondaryNOKatHospital, SecondaryEstTimeSinceLeft, 
				'SecondaryTimeLeftInMT, SecondaryNOKNextDest, SecondaryNOKETA, 
				'SecondaryPatientMiddleName, SecondaryPatientHeightFeet, SecondaryPatientHeightInches, 
				'SecondaryPatientBMICalc, SecondaryPatientTOD1, SecondaryPatientTOD2, SecondaryPatientDeathType1, 
				'SecondaryPatientDeathType2, SecondaryTriageHX, SecondaryCircumstanceOfDeath, 
				'SecondaryMedicalHistory, SecondaryAdmissionDiagnosis, SecondaryCOD, 
				'SecondaryCODSignatory, SecondaryCODTime, SecondaryCODSignedBy, SecondaryPatientVent, 
				'SecondaryIntubationDate, SecondaryIntubationTime, SecondaryBrainDeathDate, 
				'SecondaryBrainDeathTime, SecondaryDNRDate, SecondaryERORDeath, 
				'SecondaryEMSArrivalToPatientDate, SecondaryEMSArrivalToPatientTime, 
				'SecondaryEMSArrivalToHospitalDate, SecondaryEMSArrivalToHospitalTime, 
				'SecondaryPatientTerminal, SecondaryDeathWitnessed, SecondaryDeathWitnessedBy, 
				'SecondaryLSADate, SecondaryLSATime, SecondaryLSABy, SecondaryACLSProvided, 
				'SecondaryACLSProvidedTime, SecondaryGestationalAge, SecondaryParentName1, 
				'SecondaryParentName2, SecondaryBirthCBO, SecondaryActiveInfection, 
				'SecondaryActiveInfectionType, SecondaryFluidsGiven, SecondaryBloodLoss, 
				'SecondarySignOfInfection, SecondaryMedication, SecondaryAntibiotic, 
				'SecondaryPCPName, SecondaryPCPPhone, SecondaryMDAttending, 
				'SecondaryMDAttendingPhone, SecondaryPhysicalAppearance, SecondaryInternalBloodLossCC, 
				'SecondaryExternalBloodLossCC, SecondaryBloodProducts, SecondaryColloidsInfused, 
				'SecondaryCrystalloids, SecondaryPreTransfusionSampleRequired, SecondaryPreTransfusionSampleAvailable, 
				'SecondaryPreTransfusionSampleDrawnDate, SecondaryPreTransfusionSampleDrawnTime, 
				'SecondaryPreTransfusionSampleQuantity, SecondaryPreTransfusionSampleHeldAt, 
				'SecondaryPreTransfusionSampleHeldDate, SecondaryPreTransfusionSampleHeldTime, 
				'SecondaryPreTransfusionSampleHeldTechnician, SecondaryPostMordemSampleTestSuitable, 
				'SecondaryPostMordemSampleLocation, SecondaryPostMordemSampleContact, 
				'SecondaryPostMordemSampleCollectionDate, SecondaryPostMordemSampleCollectionTime, 
				'SecondarySputumCharacteristics, SecondaryNOKAltPhone, SecondaryNOKLegal, 
				'SecondaryNOKAltContact, SecondaryNOKAltContactPhone, SecondaryNOKPostMortemAuthorization, 
				'SecondaryNOKPostMortemAuthorizationReminder, SecondaryCoronerCaseNumber, SecondaryCoronerCounty, 
				'SecondaryCoronerReleased, SecondaryCoronerReleasedStipulations, SecondaryAutopsy, 
				'SecondaryAutopsyDate, SecondaryAutopsyTime, SecondaryAutopsyLocation, SecondaryAutopsyBloodRequested, 
				'SecondaryAutopsyCopyRequested, SecondaryFuneralHomeSelected, SecondaryFuneralHomeName, 
				'SecondaryFuneralHomePhone, SecondaryFuneralHomeAddress, SecondaryFuneralHomeContact, 
				'SecondaryFuneralHomeNotified, SecondaryFuneralHomeMorgueCooled, SecondaryHoldOnBody, 
				'SecondaryHoldOnBodyTag, SecondaryBodyRefrigerationDate, SecondaryBodyRefrigerationTime, 
				'SecondaryBodyLocation, SecondaryBodyMedicalChartLocation, SecondaryBodyIDTagLocation, 
				'SecondaryBodyCoolingMethod, SecondaryUNOSNumber, SecondaryClientNumber, SecondaryCryolifeNumber, 
				'SecondaryMTFNumber, SecondaryLifeNetNumber, SecondaryFreeText, SecondaryHistorySubstanceAbuse, 
				'SecondarySubstanceAbuseDetail, SecondaryExtubationDate, SecondaryExtubationTime, SecondaryAutopsyReminderYN, 
				'SecondaryFHReminderYN, SecondaryBodyCareReminderYN, SecondaryWrapUpReminderYN, SecondaryNOKNotifiedBy, 
				'SecondaryNOKNotifiedDate, SecondaryNOKNotifiedTime, SecondaryNOKGender, SecondaryCODOther, 
				'SecondaryAutopsyLocationOther, SecondaryPatientHospitalPhone, SecondaryCoronerCase, 
				'SecondaryPatientABO, SecondaryPatientSuffix, SecondaryMDAttendingId, SecondaryAdditionalComments, 
				'SecondaryRhythm, SecondaryAdditionalMedications, SecondaryBodyHoldPlaced, SecondaryBodyHoldPlacedWith, 
				'SecondaryBodyFutureContact, SecondaryBodyHoldPhone, SecondaryBodyHoldInstructionsGiven, 
				'SecondarySteroid, SecondaryBodyHoldPlacedTime
				
				'*****Secondary2 Table Fields*************
				'SecondaryAntibiotic1Name, SecondaryAntibiotic1Dose, SecondaryAntibiotic1StartDate, SecondaryAntibiotic1EndDate, 
				'SecondaryAntibiotic2Name, SecondaryAntibiotic2Dose, SecondaryAntibiotic2StartDate, SecondaryAntibiotic2EndDate, 
				'SecondaryAntibiotic3Name, SecondaryAntibiotic3Dose, SecondaryAntibiotic3StartDate, SecondaryAntibiotic3EndDate, 
				'SecondaryAntibiotic4Name, SecondaryAntibiotic4Dose, SecondaryAntibiotic4StartDate, SecondaryAntibiotic4EndDate, 
				'SecondaryAntibiotic5Name, SecondaryAntibiotic5Dose, SecondaryAntibiotic5StartDate, SecondaryAntibiotic5EndDate, 
				'SecondaryBloodProductsReceived1Type, SecondaryBloodProductsReceived1Units, SecondaryBloodProductsReceived1TypeCC,  
				'SecondaryBloodProductsReceived1TypeUnitGiven, SecondaryBloodProductsReceived2Type, SecondaryBloodProductsReceived2Units, 
				'SecondaryBloodProductsReceived2TypeCC, SecondaryBloodProductsReceived2TypeUnitGiven, SecondaryBloodProductsReceived3Type, 
				'SecondaryBloodProductsReceived3Units, SecondaryBloodProductsReceived3TypeCC, SecondaryBloodProductsReceived3TypeUnitGiven, 
				'SecondaryColloidsInfused1Type, SecondaryColloidsInfused1Units, SecondaryColloidsInfused1CC, SecondaryColloidsInfused1UnitGiven, 
				'SecondaryColloidsInfused2Type, SecondaryColloidsInfused2Units, SecondaryColloidsInfused2CC, SecondaryColloidsInfused2UnitGiven, 
				'SecondaryColloidsInfused3Type, SecondaryColloidsInfused3Units, SecondaryColloidsInfused3CC, SecondaryColloidsInfused3UnitGiven, 
				'SecondaryCrystalloids1Type, SecondaryCrystalloids1Units, SecondaryCrystalloids1CC, SecondaryCrystalloids1UnitGiven, 
				'SecondaryCrystalloids2Type, SecondaryCrystalloids2Units, SecondaryCrystalloids2CC, SecondaryCrystalloids2UnitGiven, 
				'SecondaryCrystalloids3Type, SecondaryCrystalloids3Units, SecondaryCrystalloids3CC, SecondaryCrystalloids3UnitGiven, 	
				'SecondaryWBC1Date, SecondaryWBC1, SecondaryWBC1Bands, SecondaryWBC2Date, SecondaryWBC2, SecondaryWBC2Bands, 
				'SecondaryWBC3Date, SecondaryWBC3, SecondaryWBC3Bands, SecondaryLabTemp1, SecondaryLabTemp1Date, SecondaryLabTemp1Time, 
				'SecondaryLabTemp2, SecondaryLabTemp2Date, SecondaryLabTemp2Time, SecondaryLabTemp3, SecondaryLabTemp3Date, 
				'SecondaryLabTemp3Time, SecondaryCulture1Type, SecondaryCulture1Other, SecondaryCulture1DrawnDate, 
				'SecondaryCulture1Growth, SecondaryCulture2Type, SecondaryCulture2Other, SecondaryCulture2DrawnDate,  
				'SecondaryCulture2Growth, SecondaryCulture3Type, SecondaryCulture3Other, SecondaryCulture3DrawnDate, 
				'SecondaryCulture3Growth, SecondaryCXRAvailable, SecondaryCXR1Date, SecondaryCXR1Finding, SecondaryCXR2Date, 
				'SecondaryCXR2Finding, SecondaryCXR3Date, SecondaryCXR3Finding, SecondaryAntibiotic1NameOther, 
				'SecondaryAntibiotic2NameOther, SecondaryAntibiotic3NameOther, SecondaryAntibiotic4NameOther, 
				'SecondaryAntibiotic5NameOther, SecondaryBloodProductsReceived1TypeOther, SecondaryBloodProductsReceived2TypeOther, 
				'SecondaryBloodProductsReceived3TypeOther, SecondaryColloidsInfused1TypeOther, SecondaryColloidsInfused2TypeOther, 
				'SecondaryColloidsInfused3TypeOther, SecondaryCrystalloids1TypeOther, SecondaryCrystalloids2TypeOther, 
				'SecondaryCrystalloids3TypeOther 
				
				'*****SecondaryApproach Table Fields*************
				'SecondaryApproached, SecondaryApproachedBy, SecondaryApproachType, SecondaryApproachOutcome, SecondaryApproachReason, 
				'SecondaryConsented, SecondaryConsentBy, SecondaryConsentOutcome, SecondaryConsentResearch, SecondaryRecoveryLocation, 
				'SecondaryHospitalApproach, SecondaryHospitalApproachedBy, SecondaryHospitalOutcome, SecondaryConsentMedSocPaperwork, 
				'SecondaryConsentMedSocObtainedBy, SecondaryConsentFuneralPlans, SecondaryConsentFuneralPlansOther, 
				'SecondaryConsentLongSleeves 
				

					For i = 0 to Ubound(ResultArray, 2)

					'debugging
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
					
						
					'Extended Referral 2004 Fields 115- 127 of spec. 2/8/2005 CAC
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

					'FSCase table for Extended FS Fields 128-159 of spec. 02/11/2005 CAC
					vRecord = vRecord & resultarray(182, i)& chr(9) '182 FSCaseId
					vRecord = vRecord & resultarray(183, i)& chr(9) '183 FSCaseCreateUserId
					vRecord = vRecord & resultarray(184, i)& chr(9) '184 FSCaseCreateDateTime
					vRecord = vRecord & resultarray(185, i)& chr(9) '185 FSCaseOpenUserId
					vRecord = vRecord & resultarray(186, i)& chr(9) '186 FSCaseOpenDateTime
					vRecord = vRecord & resultarray(187, i)& chr(9) '187 FSCaseSysEventsUserID
					vRecord = vRecord & resultarray(188, i)& chr(9) '188 FSCaseSysEventsDateTime
					vRecord = vRecord & resultarray(189, i)& chr(9) '189 FSCaseSecCompUserId
					vRecord = vRecord & resultarray(190, i)& chr(9) '136 FSCaseSecCompDateTime
					vRecord = vRecord & resultarray(191, i)& chr(9) '137 FSCaseApproachUserId
					vRecord = vRecord & resultarray(192, i)& chr(9) '138 FSCaseApproachDateTime
					vRecord = vRecord & resultarray(193, i)& chr(9) '139 FSCaseFinalUserId					
					vRecord = vRecord & resultarray(194, i)& chr(9) '140 FSCaseFinalDateTime
					vRecord = vRecord & resultarray(195, i)& chr(9) '140 FSCaseUpdate
					vRecord = vRecord & resultarray(196, i)& chr(9) '141 FSCaseUserId
					vRecord = vRecord & resultarray(197, i)& chr(9) '142 FSCaseBillSecondaryUserID
					vRecord = vRecord & resultarray(198, i)& chr(9) '143 FSCaseBillDateTime
					vRecord = vRecord & resultarray(199, i)& chr(9) '144 FSCaseBillApproachUserID
					vRecord = vRecord & resultarray(200, i)& chr(9) '145 FSCaseBillApproachDateTime
					vRecord = vRecord & resultarray(201, i)& chr(9) '146 FSCaseBillMedSocUserID
					vRecord = vRecord & resultarray(202, i)& chr(9) '147 FSCaseBillMedSocDateTime
					vRecord = vRecord & resultarray(203, i)& chr(9) '147 SecondaryManualBillPersonId					
					vRecord = vRecord & resultarray(204, i)& chr(9) '148 SecondaryUpdatedFlag
					vRecord = vRecord & resultarray(205, i)& chr(9) '149 FSCaseTotalTime
					vRecord = vRecord & resultarray(206, i)& chr(9) '150 FSCaseSeconds					
					vRecord = vRecord & resultarray(207, i)& chr(9) '151 FSCaseBillFamUnavailUserId
					vRecord = vRecord & resultarray(208, i)& chr(9) '152 FSCaseBillFamUnavailDateTime
					vRecord = vRecord & resultarray(209, i)& chr(9) '153 FSCaseBillCryoFormUserId
					vRecord = vRecord & resultarray(210, i)& chr(9) '154 FSCaseBillCryoFormDateTime
					vRecord = vRecord & resultarray(211, i)& chr(9) '155 FSCaseBillApproachCount
					vRecord = vRecord & resultarray(212, i)& chr(9) '156 FSCaseBillMedSocCount
					vRecord = vRecord & resultarray(213, i)& chr(9) '80 FSCaseBillCryoFormCount
					
					'Secondary table for Extended FS Fields 160-305 02/09/2005 CAC
					vRecord = vRecord & resultarray(214, i)& chr(9) '150 SecondaryWhoAreWe				
					vRecord = vRecord & resultarray(215, i)& chr(9) '151 SecondaryNOKaware
					vRecord = vRecord & resultarray(216, i)& chr(9) '152 SecondaryFamilyConsent
					vRecord = vRecord & resultarray(217, i)& chr(9) '153 SecondaryFamilyInterestedd
					vRecord = vRecord & resultarray(218, i)& chr(9) '154 SecondaryNOKatHospital
					vRecord = vRecord & resultarray(219, i)& chr(9) '155 SecondaryEstTimeSinceLeft
					vRecord = vRecord & resultarray(220, i)& chr(9) '156 SecondaryTimeLeftInMT
					vRecord = vRecord & resultarray(221, i)& chr(9) '80 SecondaryNOKNextDest					
					vRecord = vRecord & resultarray(222, i)& chr(9) '150 SecondaryNOKETA					
					vRecord = vRecord & resultarray(223, i)& chr(9) '151 SecondaryPatientMiddleName
					vRecord = vRecord & resultarray(224, i)& chr(9) '152 SecondaryPatientHeightFeet
					vRecord = vRecord & resultarray(225, i)& chr(9) '153 SecondaryPatientHeightInches
					vRecord = vRecord & resultarray(226, i)& chr(9) '154 SecondaryPatientBMICalc
					vRecord = vRecord & resultarray(227, i)& chr(9) '155 SecondaryPatientTOD1
					vRecord = vRecord & resultarray(228, i)& chr(9) '156 SecondaryPatientTOD2
					vRecord = vRecord & resultarray(229, i)& chr(9) '80 SecondaryPatientDeathType1					
					vRecord = vRecord & resultarray(230, i)& chr(9) '150 SecondaryPatientDeathType2				
					vRecord = vRecord & resultarray(231, i)& chr(9) '151 SecondaryTriageHX
					vRecord = vRecord & resultarray(232, i)& chr(9) '152 SecondaryCircumstanceOfDeath
					vRecord = vRecord & resultarray(233, i)& chr(9) '153 SecondaryAdmissionDiagnosis
					vRecord = vRecord & resultarray(234, i)& chr(9) '154 SecondaryCOD
					vRecord = vRecord & resultarray(235, i)& chr(9) '155 SecondaryCODSignatory
					vRecord = vRecord & resultarray(236, i)& chr(9) '156 SecondaryCODTime
					vRecord = vRecord & resultarray(237, i)& chr(9) '80 SecondaryCODSignedBy					
					vRecord = vRecord & resultarray(238, i)& chr(9) '150 SecondaryPatientVent				
					vRecord = vRecord & resultarray(239, i)& chr(9) '151 SecondaryIntubationDate
					vRecord = vRecord & resultarray(240, i)& chr(9) '152 SecondaryIntubationTime
					vRecord = vRecord & resultarray(241, i)& chr(9) '153 SecondaryBrainDeathDate					
					vRecord = vRecord & resultarray(242, i)& chr(9) '154 SecondaryBrainDeathTime
					vRecord = vRecord & resultarray(243, i)& chr(9) '155 SecondaryDNRDate
					vRecord = vRecord & resultarray(244, i)& chr(9) '156 SecondaryERORDeath
					vRecord = vRecord & resultarray(245, i)& chr(9) '80 SecondaryEMSArrivalToPatientDate					
					vRecord = vRecord & resultarray(246, i)& chr(9) '150 SecondaryEMSArrivalToPatientTime									
					vRecord = vRecord & resultarray(247, i)& chr(9) '151 SecondaryEMSArrivalToHospitalDate					
					vRecord = vRecord & resultarray(248, i)& chr(9) '152 SecondaryEMSArrivalToHospitalTime					
					vRecord = vRecord & resultarray(249, i)& chr(9) '153 SecondaryPatientTerminal					
					vRecord = vRecord & resultarray(250, i)& chr(9) '154 SecondaryDeathWitnessed					
					vRecord = vRecord & resultarray(251, i)& chr(9) '155 SecondaryDeathWitnessedBy
					vRecord = vRecord & resultarray(252, i)& chr(9) '156 SecondaryLSADate
					vRecord = vRecord & resultarray(253, i)& chr(9) '80 SecondaryLSATime					
					vRecord = vRecord & resultarray(254, i)& chr(9) '150 SecondaryLSABy				
					vRecord = vRecord & resultarray(255, i)& chr(9) '151 SecondaryACLSProvided					
					vRecord = vRecord & resultarray(256, i)& chr(9) '152 SecondaryACLSProvidedTime					
					vRecord = vRecord & resultarray(257, i)& chr(9) '153 SecondaryGestationalAge					
					vRecord = vRecord & resultarray(258, i)& chr(9) '154 SecondaryParentName1
					vRecord = vRecord & resultarray(259, i)& chr(9) '155 SecondaryParentName2
					vRecord = vRecord & resultarray(260, i)& chr(9) '156 SecondaryBirthCBO
					vRecord = vRecord & resultarray(261, i)& chr(9) '80 SecondaryActiveInfection					
					vRecord = vRecord & resultarray(262, i)& chr(9) '150 SecondaryActiveInfectionType				
					vRecord = vRecord & resultarray(263, i)& chr(9) '151 SecondaryFluidsGiven
					vRecord = vRecord & resultarray(264, i)& chr(9) '152 SecondaryBloodLoss					
					vRecord = vRecord & resultarray(265, i)& chr(9) '153 SecondarySignOfInfection
					vRecord = vRecord & resultarray(266, i)& chr(9) '154 SecondaryMedication
					vRecord = vRecord & resultarray(267, i)& chr(9) '155 SecondaryAntibiotic
					vRecord = vRecord & resultarray(268, i)& chr(9) '156 SecondaryPCPName
					vRecord = vRecord & resultarray(269, i)& chr(9) '80 SecondaryPCPPhone					
					vRecord = vRecord & resultarray(270, i)& chr(9) '150 SecondaryMDAttending				
					vRecord = vRecord & resultarray(271, i)& chr(9) '151 SecondaryMDAttendingPhone
					vRecord = vRecord & resultarray(272, i)& chr(9) '152 SecondaryPhysicalAppearance					
					vRecord = vRecord & resultarray(273, i)& chr(9) '153 SecondaryInternalBloodLossCC
					vRecord = vRecord & resultarray(274, i)& chr(9) '154 SecondaryExternalBloodLossCC
					vRecord = vRecord & resultarray(275, i)& chr(9) '155 SecondaryBloodProducts
					vRecord = vRecord & resultarray(276, i)& chr(9) '156 SecondaryColloidsInfused
					vRecord = vRecord & resultarray(277, i)& chr(9) '80 SecondaryCrystalloids					
					vRecord = vRecord & resultarray(278, i)& chr(9) '150 SecondaryPreTransfusionSampleRequired				
					vRecord = vRecord & resultarray(279, i)& chr(9) '151 SecondaryPreTransfusionSampleAvailable
					vRecord = vRecord & resultarray(280, i)& chr(9) '152 SecondaryPreTransfusionSampleDrawnDate
					vRecord = vRecord & resultarray(281, i)& chr(9) '153 SecondaryPreTransfusionSampleDrawnTime
					vRecord = vRecord & resultarray(282, i)& chr(9) '154 SecondaryPreTransfusionSampleQuantity
					vRecord = vRecord & resultarray(283, i)& chr(9) '155 SecondaryPreTransfusionSampleHeldAt
					vRecord = vRecord & resultarray(284, i)& chr(9) '156 SecondaryPreTransfusionSampleHeldDate
					vRecord = vRecord & resultarray(285, i)& chr(9) '80 SecondaryPreTransfusionSampleHeldTime					
					vRecord = vRecord & resultarray(286, i)& chr(9) '150 SecondaryPreTransfusionSampleHeldTechnician				
					vRecord = vRecord & resultarray(287, i)& chr(9) '151 SecondaryPostMordemSampleTestSuitable
					vRecord = vRecord & resultarray(288, i)& chr(9) '152 SecondaryPostMordemSampleLocation
					vRecord = vRecord & resultarray(289, i)& chr(9) '153 SecondaryPostMordemSampleContact
					vRecord = vRecord & resultarray(290, i)& chr(9) '154 SecondaryPostMordemSampleCollectionDate
					vRecord = vRecord & resultarray(291, i)& chr(9) '155 SecondaryPostMordemSampleCollectionTime					
					vRecord = vRecord & resultarray(292, i)& chr(9) '156 SecondarySputumCharacteristics
					vRecord = vRecord & resultarray(293, i)& chr(9) '80 SecondaryNOKAltPhone					
					vRecord = vRecord & resultarray(294, i)& chr(9) '150 SecondaryNOKLegal				
					vRecord = vRecord & resultarray(295, i)& chr(9) '151 SecondaryNOKAltContact
					vRecord = vRecord & resultarray(296, i)& chr(9) '152 SecondaryNOKAltContactPhone
					vRecord = vRecord & resultarray(297, i)& chr(9) '153 SecondaryNOKPostMortemAuthorization					
					vRecord = vRecord & resultarray(298, i)& chr(9) '154 SecondaryNOKPostMortemAuthorizationReminder
					vRecord = vRecord & resultarray(299, i)& chr(9) '155 SecondaryCoronerCaseNumber
					vRecord = vRecord & resultarray(300, i)& chr(9) '156 SecondaryCoronerCounty
					vRecord = vRecord & resultarray(301, i)& chr(9) '80 SecondaryCoronerReleased					
					vRecord = vRecord & resultarray(302, i)& chr(9) '150 SecondaryCoronerReleasedStipulations				
					vRecord = vRecord & resultarray(303, i)& chr(9) '151 SecondaryAutopsy
					vRecord = vRecord & resultarray(304, i)& chr(9) '152 SecondaryAutopsyDate
					vRecord = vRecord & resultarray(305, i)& chr(9) '153 SecondaryAutopsyTime
					vRecord = vRecord & resultarray(306, i)& chr(9) '154 SecondaryAutopsyLocation
					vRecord = vRecord & resultarray(307, i)& chr(9) '155 SecondaryAutopsyBloodRequested					
					vRecord = vRecord & resultarray(308, i)& chr(9) '150 SecondaryAutopsyCopyRequested				
					vRecord = vRecord & resultarray(309, i)& chr(9) '151 SecondaryFuneralHomeSelected
					vRecord = vRecord & resultarray(310, i)& chr(9) '152 SecondaryFuneralHomeName
					vRecord = vRecord & resultarray(311, i)& chr(9) '153 SecondaryFuneralHomePhone
					vRecord = vRecord & resultarray(312, i)& chr(9) '154 SecondaryFuneralHomeAddress
					vRecord = vRecord & resultarray(313, i)& chr(9) '155 SecondaryFuneralHomeContact					
					vRecord = vRecord & resultarray(314, i)& chr(9) '150 SecondaryFuneralHomeNotified				
					vRecord = vRecord & resultarray(315, i)& chr(9) '151 SecondaryFuneralHomeMorgueCooled
					vRecord = vRecord & resultarray(316, i)& chr(9) '152 SecondaryHoldOnBody
					vRecord = vRecord & resultarray(317, i)& chr(9) '153 SecondaryHoldOnBodyTag
					vRecord = vRecord & resultarray(318, i)& chr(9) '154 SecondaryBodyRefrigerationDate
					vRecord = vRecord & resultarray(319, i)& chr(9) '155 SecondaryBodyRefrigerationTime					
					vRecord = vRecord & resultarray(320, i)& chr(9) '150 SecondaryBodyLocation				
					vRecord = vRecord & resultarray(321, i)& chr(9) '151 SecondaryBodyMedicalChartLocation
					vRecord = vRecord & resultarray(322, i)& chr(9) '152 SecondaryBodyIDTagLocation
					vRecord = vRecord & resultarray(323, i)& chr(9) '153 SecondaryBodyCoolingMethod
					vRecord = vRecord & resultarray(324, i)& chr(9) '154 SecondaryUNOSNumber					
					vRecord = vRecord & resultarray(325, i)& chr(9) '154 SecondaryClientNumber
					vRecord = vRecord & resultarray(326, i)& chr(9) '155 SecondaryCryolifeNumber	
					vRecord = vRecord & resultarray(327, i)& chr(9) '150 SecondaryMTFNumber				
					vRecord = vRecord & resultarray(328, i)& chr(9) '151 SecondaryLifeNetNumber
					vRecord = vRecord & resultarray(329, i)& chr(9) '152 SecondaryFreeText
					vRecord = vRecord & resultarray(330, i)& chr(9) '153 SecondaryHistorySubstanceAbuse
					vRecord = vRecord & resultarray(331, i)& chr(9) '154 SecondarySubstanceAbuseDetail					
					vRecord = vRecord & resultarray(332, i)& chr(9) '154 SecondaryExtubationDate
					vRecord = vRecord & resultarray(333, i)& chr(9) '155 SecondaryExtubationTime					
					vRecord = vRecord & resultarray(334, i)& chr(9) '150 SecondaryAutopsyReminderYN				
					vRecord = vRecord & resultarray(335, i)& chr(9) '151 SecondaryFHReminderYN
					vRecord = vRecord & resultarray(336, i)& chr(9) '152 SecondaryBodyCareReminderYN
					vRecord = vRecord & resultarray(337, i)& chr(9) '153 SecondaryWrapUpReminderYN
					vRecord = vRecord & resultarray(338, i)& chr(9) '154 SecondaryNOKNotifiedBy					
					vRecord = vRecord & resultarray(339, i)& chr(9) '154 SecondaryNOKNotifiedDate
					vRecord = vRecord & resultarray(340, i)& chr(9) '155 SecondaryNOKNotifiedTime					
					vRecord = vRecord & resultarray(341, i)& chr(9) '150 SecondaryNOKGender				
					vRecord = vRecord & resultarray(342, i)& chr(9) '151 SecondaryCODOther
					vRecord = vRecord & resultarray(343, i)& chr(9) '152 SecondaryAutopsyLocationOther
					vRecord = vRecord & resultarray(344, i)& chr(9) '153 SecondaryPatientHospitalPhone
					vRecord = vRecord & resultarray(345, i)& chr(9) '154 SecondaryCoronerCase					
					vRecord = vRecord & resultarray(346, i)& chr(9) '154 SecondaryPatientABO
					vRecord = vRecord & resultarray(347, i)& chr(9) '155 SecondaryPatientSuffix					
					vRecord = vRecord & resultarray(348, i)& chr(9) '150 SecondaryMDAttendingId				
					vRecord = vRecord & resultarray(349, i)& chr(9) '151 SecondaryAdditionalComments
					vRecord = vRecord & resultarray(350, i)& chr(9) '152 SecondaryRhythm
					vRecord = vRecord & resultarray(351, i)& chr(9) '152 SecondaryAdditionalMedications
					vRecord = vRecord & resultarray(352, i)& chr(9) '153 SecondaryBodyHoldPlaced
					vRecord = vRecord & resultarray(353, i)& chr(9) '154 SecondaryBodyHoldPlacedWith					
					vRecord = vRecord & resultarray(354, i)& chr(9) '154 SecondaryBodyFutureContact
					vRecord = vRecord & resultarray(355, i)& chr(9) '155 SecondaryBodyHoldPhone					
					vRecord = vRecord & resultarray(356, i)& chr(9) '154 SecondaryBodyHoldInstructionsGiven					
					vRecord = vRecord & resultarray(357, i)& chr(9) '154 SecondarySteroid
					vRecord = vRecord & resultarray(358, i)& chr(9) '155 SecondaryBodyHoldPlacedTime

					'Secondary2 table for Extended FS Fields 306-412 02/09/2005 CAC					
					vRecord = vRecord & resultarray(359, i)& chr(9) '153 SecondaryAntibiotic1Name
					vRecord = vRecord & resultarray(360, i)& chr(9) '154 SecondaryAntibiotic1Dose					
					vRecord = vRecord & resultarray(361, i)& chr(9) '154 SecondaryAntibiotic1StartDate
					vRecord = vRecord & resultarray(362, i)& chr(9) '155 SecondaryAntibiotic1EndDate					
					vRecord = vRecord & resultarray(363, i)& chr(9) '154 SecondaryAntibiotic2Name					
					vRecord = vRecord & resultarray(364, i)& chr(9) '154 SecondaryAntibiotic2Dose
					vRecord = vRecord & resultarray(365, i)& chr(9) '155 SecondaryAntibiotic2StartDate					
					vRecord = vRecord & resultarray(366, i)& chr(9) '153 SecondaryAntibiotic2EndDate
					vRecord = vRecord & resultarray(367, i)& chr(9) '154 SecondaryAntibiotic3Name					
					vRecord = vRecord & resultarray(368, i)& chr(9) '154 SecondaryAntibiotic3Dose
					vRecord = vRecord & resultarray(369, i)& chr(9) '155 SecondaryAntibiotic3StartDate					
					vRecord = vRecord & resultarray(370, i)& chr(9) '154 SecondaryAntibiotic3EndDate					
					vRecord = vRecord & resultarray(371, i)& chr(9) '154 SecondaryAntibiotic4Name
					vRecord = vRecord & resultarray(372, i)& chr(9) '155 SecondaryAntibiotic4Dose					
					vRecord = vRecord & resultarray(373, i)& chr(9) '153 SecondaryAntibiotic4StartDate
					vRecord = vRecord & resultarray(374, i)& chr(9) '154 SecondaryAntibiotic4EndDate					
					vRecord = vRecord & resultarray(375, i)& chr(9) '154 SecondaryAntibiotic5Name
					vRecord = vRecord & resultarray(376, i)& chr(9) '155 SecondaryAntibiotic5Dose					
					vRecord = vRecord & resultarray(377, i)& chr(9) '154 SecondaryAntibiotic5StartDate					
					vRecord = vRecord & resultarray(378, i)& chr(9) '154 SecondaryAntibiotic5EndDate		
					vRecord = vRecord & resultarray(379, i)& chr(9) '153 SecondaryBloodProductsReceived1Type
					vRecord = vRecord & resultarray(380, i)& chr(9) '154 SecondaryBloodProductsReceived1Units					
					vRecord = vRecord & resultarray(381, i)& chr(9) '154 SecondaryBloodProductsReceived1TypeCC
					vRecord = vRecord & resultarray(382, i)& chr(9) '155 SecondaryBloodProductsReceived1TypeUnitGiven	
					vRecord = vRecord & resultarray(383, i)& chr(9) '153 SecondaryBloodProductsReceived2Type					
					vRecord = vRecord & resultarray(384, i)& chr(9) '154 SecondaryBloodProductsReceived2Units					
					vRecord = vRecord & resultarray(385, i)& chr(9) '154 SecondaryBloodProductsReceived2TypeCC
					vRecord = vRecord & resultarray(386, i)& chr(9) '155 SecondaryBloodProductsReceived2TypeUnitGiven					
					vRecord = vRecord & resultarray(387, i)& chr(9) '153 SecondaryBloodProductsReceived3Type
					vRecord = vRecord & resultarray(388, i)& chr(9) '154 SecondaryBloodProductsReceived3Units					
					vRecord = vRecord & resultarray(389, i)& chr(9) '154 SecondaryBloodProductsReceived3TypeCC
					vRecord = vRecord & resultarray(390, i)& chr(9) '155 SecondaryBloodProductsReceived3TypeUnitGiven					
					vRecord = vRecord & resultarray(391, i)& chr(9) '154 SecondaryColloidsInfused1Type					
					vRecord = vRecord & resultarray(392, i)& chr(9) '154 SecondaryColloidsInfused1Units
					vRecord = vRecord & resultarray(393, i)& chr(9) '155 SecondaryColloidsInfused1CC					
					vRecord = vRecord & resultarray(394, i)& chr(9) '153 SecondaryColloidsInfused1UnitGiven
					vRecord = vRecord & resultarray(395, i)& chr(9) '154 SecondaryColloidsInfused2Type					
					vRecord = vRecord & resultarray(396, i)& chr(9) '154 SecondaryColloidsInfused2Units
					vRecord = vRecord & resultarray(397, i)& chr(9) '155 SecondaryColloidsInfused2CC					
					vRecord = vRecord & resultarray(398, i)& chr(9) '154 SecondaryColloidsInfused2UnitGiven					
					vRecord = vRecord & resultarray(399, i)& chr(9) '154 SecondaryColloidsInfused3Type
					vRecord = vRecord & resultarray(400, i)& chr(9) '155 SecondaryColloidsInfused3Units					
					vRecord = vRecord & resultarray(401, i)& chr(9) '153 SecondaryColloidsInfused3CC
					vRecord = vRecord & resultarray(402, i)& chr(9) '154 SecondaryColloidsInfused3UnitGiven					
					vRecord = vRecord & resultarray(403, i)& chr(9) '154 SecondaryCrystalloids1Type
					vRecord = vRecord & resultarray(404, i)& chr(9) '155 SecondaryCrystalloids1Units					
					vRecord = vRecord & resultarray(405, i)& chr(9) '154 SecondaryCrystalloids1CC					
					vRecord = vRecord & resultarray(406, i)& chr(9) '154 SecondaryCrystalloids1UnitGiven
					vRecord = vRecord & resultarray(407, i)& chr(9) '155 SecondaryCrystalloids2Type							
					vRecord = vRecord & resultarray(408, i)& chr(9) '153 SecondaryCrystalloids2Units
					vRecord = vRecord & resultarray(409, i)& chr(9) '154 SecondaryCrystalloids2CC					
					vRecord = vRecord & resultarray(410, i)& chr(9) '154 SecondaryCrystalloids2UnitGiven
					vRecord = vRecord & resultarray(411, i)& chr(9) '155 SecondaryCrystalloids3Type					
					vRecord = vRecord & resultarray(412, i)& chr(9) '154 SecondaryCrystalloids3Units					
					vRecord = vRecord & resultarray(413, i)& chr(9) '154 SecondaryCrystalloids3CC
					vRecord = vRecord & resultarray(414, i)& chr(9) '155 SecondaryCrystalloids3UnitGiven	
					vRecord = vRecord & resultarray(415, i)& chr(9) '153 SecondaryWBC1Date
					vRecord = vRecord & resultarray(416, i)& chr(9) '154 SecondaryWBC1					
					vRecord = vRecord & resultarray(417, i)& chr(9) '154 SecondaryWBC1Bands
					vRecord = vRecord & resultarray(418, i)& chr(9) '155 SecondaryWBC2Date					
					vRecord = vRecord & resultarray(419, i)& chr(9) '154 SecondaryWBC2					
					vRecord = vRecord & resultarray(420, i)& chr(9) '154 SecondaryWBC2Bands
					vRecord = vRecord & resultarray(421, i)& chr(9) '155 SecondaryWBC3Date					
					vRecord = vRecord & resultarray(422, i)& chr(9) '153 SecondaryWBC3
					vRecord = vRecord & resultarray(423, i)& chr(9) '154 SecondaryWBC3Bands					
					vRecord = vRecord & resultarray(424, i)& chr(9) '154 SecondaryLabTemp1
					vRecord = vRecord & resultarray(425, i)& chr(9) '155 SecondaryLabTemp1Date					
					vRecord = vRecord & resultarray(426, i)& chr(9) '154 SecondaryLabTemp1Time					
					vRecord = vRecord & resultarray(427, i)& chr(9) '154 SecondaryLabTemp2
					vRecord = vRecord & resultarray(428, i)& chr(9) '155 SecondaryLabTemp2Date					
					vRecord = vRecord & resultarray(429, i)& chr(9) '153 SecondaryLabTemp2Time
					vRecord = vRecord & resultarray(430, i)& chr(9) '154 SecondaryLabTemp3
					vRecord = vRecord & resultarray(431, i)& chr(9) '154 SecondaryLabTemp3Date					
					vRecord = vRecord & resultarray(432, i)& chr(9) '154 SecondaryLabTemp3Time
					vRecord = vRecord & resultarray(433, i)& chr(9) '155 SecondaryCulture1Type					
					vRecord = vRecord & resultarray(434, i)& chr(9) '154 SecondaryCulture1Other					
					vRecord = vRecord & resultarray(435, i)& chr(9) '154 SecondaryCulture1DrawnDate
					vRecord = vRecord & resultarray(436, i)& chr(9) '155 SecondaryCulture1Growth					
					vRecord = vRecord & resultarray(437, i)& chr(9) '153 SecondaryCulture2Type
					vRecord = vRecord & resultarray(438, i)& chr(9) '154 SecondaryCulture2Other					
					vRecord = vRecord & resultarray(439, i)& chr(9) '154 SecondaryCulture2DrawnDate
					vRecord = vRecord & resultarray(440, i)& chr(9) '155 SecondaryCulture2Growth					
					vRecord = vRecord & resultarray(441, i)& chr(9) '154 SecondaryCulture3Type					
					vRecord = vRecord & resultarray(442, i)& chr(9) '154 SecondaryCulture3Other
					vRecord = vRecord & resultarray(443, i)& chr(9) '155 SecondaryCulture3DrawnDate					
					vRecord = vRecord & resultarray(444, i)& chr(9) '154 SecondaryCulture3Growth
					vRecord = vRecord & resultarray(445, i)& chr(9) '155 SecondaryCXRAvailable					
					vRecord = vRecord & resultarray(446, i)& chr(9) '154 SecondaryCXR1Date					
					vRecord = vRecord & resultarray(447, i)& chr(9) '154 SecondaryCXR1Finding
					vRecord = vRecord & resultarray(448, i)& chr(9) '155 SecondaryCXR2Date							
					vRecord = vRecord & resultarray(449, i)& chr(9) '153 SecondaryCXR2Finding
					vRecord = vRecord & resultarray(450, i)& chr(9) '154 SecondaryCXR3Date					
					vRecord = vRecord & resultarray(451, i)& chr(9) '154 SecondaryCXR3Finding
					vRecord = vRecord & resultarray(452, i)& chr(9) '155 SecondaryAntibiotic1NameOther					
					vRecord = vRecord & resultarray(453, i)& chr(9) '154 SecondaryAntibiotic2NameOther					
					vRecord = vRecord & resultarray(454, i)& chr(9) '154 SecondaryAntibiotic3NameOther
					vRecord = vRecord & resultarray(455, i)& chr(9) '155 SecondaryAntibiotic4NameOther					
					vRecord = vRecord & resultarray(456, i)& chr(9) '154 SecondaryAntibiotic5NameOther
					vRecord = vRecord & resultarray(457, i)& chr(9) '155 SecondaryBloodProductsReceived1TypeOther					
					vRecord = vRecord & resultarray(458, i)& chr(9) '154 SecondaryBloodProductsReceived2TypeOther					
					vRecord = vRecord & resultarray(459, i)& chr(9) '154 SecondaryBloodProductsReceived3TypeOther
					vRecord = vRecord & resultarray(460, i)& chr(9) '155 SecondaryColloidsInfused1TypeOther
					vRecord = vRecord & resultarray(461, i)& chr(9) '155 SecondaryColloidsInfused2TypeOther							
					vRecord = vRecord & resultarray(462, i)& chr(9) '153 SecondaryColloidsInfused3TypeOther
					vRecord = vRecord & resultarray(463, i)& chr(9) '154 SecondaryCrystalloids1TypeOther					
					vRecord = vRecord & resultarray(464, i)& chr(9) '154 SecondaryCrystalloids2TypeOther
					vRecord = vRecord & resultarray(465, i)& chr(9) '155 SecondaryCrystalloids3TypeOther
									
					'SecondaryApproach table for FS Fields 413-430 02/09/2005 CAC
					vRecord = vRecord & resultarray(466, i)& chr(9) '155 SecondaryApproached					
					vRecord = vRecord & resultarray(467, i)& chr(9) '154 SecondaryApproachedBy					
					vRecord = vRecord & resultarray(468, i)& chr(9) '154 SecondaryApproachType
					vRecord = vRecord & resultarray(469, i)& chr(9) '155 SecondaryApproachOutcome					
					vRecord = vRecord & resultarray(470, i)& chr(9) '154 SecondaryApproachReason
					vRecord = vRecord & resultarray(471, i)& chr(9) '155 SecondaryConsented					
					vRecord = vRecord & resultarray(472, i)& chr(9) '154 SecondaryConsentBy					
					vRecord = vRecord & resultarray(473, i)& chr(9) '154 SecondaryConsentOutcome
					vRecord = vRecord & resultarray(474, i)& chr(9) '155 SecondaryConsentResearch							
					vRecord = vRecord & resultarray(475, i)& chr(9) '153 SecondaryRecoveryLocation
					vRecord = vRecord & resultarray(476, i)& chr(9) '154 SecondaryHospitalApproach					
					vRecord = vRecord & resultarray(477, i)& chr(9) '154 SecondaryHospitalApproachedBy
					vRecord = vRecord & resultarray(478, i)& chr(9) '155 SecondaryHospitalOutcome					
					vRecord = vRecord & resultarray(479, i)& chr(9) '155 SecondaryConsentMedSocPaperwork					
					vRecord = vRecord & resultarray(480, i)& chr(9) '154 SecondaryConsentMedSocObtainedBy										
					vRecord = vRecord & resultarray(481, i)& chr(9) '155 SecondaryConsentFuneralPlans					
					vRecord = vRecord & resultarray(482, i)& chr(9) '154 SecondaryConsentFuneralPlansOther				
					vRecord = vRecord & resultarray(483, i)& chr(9) '154 SecondaryConsentFuneralPlansOther				
						
					vRecord = vRecord & resultarray(484, i)& chr(13) & Chr(10) '154 SecondaryConsentLongSleeves
										 

					Response.Write(vRecord)

					'debugging
					'FOR forLoop = 0 to UBound(ResultArray,1)
						'Response.Write(forLoop & " " & ResultArray(forLoop,i) & "<br>")
					'Next

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
