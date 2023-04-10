lvQueryString = lvQueryString & "<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<%

Function GetDetailList()

     'pvReportGroupID     int          = null,
     'pvStartDate         datetime     = null,
     'pvEndDate           datetime     = null,
     'pvOrgID             int          = null,
     'pvTZ                 varchar(2)   = null,
     'pvReferralTypeID    int          = null,
     'pvOrderBy           varchar(60)  = null,
     'pvUserOrgID	  int	       = null,
     'pvCallID            int          = null



	DIM lvQueryString
	DIM lvReferralTypeStart
	DIM lvReferralTypeEnd
	DIM lvTZ
	DIM lvSourceCodeID
	DIM lvSCIList
	DIM lvAccessOrgans
	DIM lvAccessBone
	DIM lvAccessTissue
	DIM lvAccessSkin
	DIM lvAccessValves
	DIM lvAccessEyes
	DIM lvAccessResearch
	DIM lvConn
	DIM lvRS
	DIM lvStartDate, lvEndDate

    Set lvConn = GetConnection(DBUSER, DBPWD,DataSourceName )

     'Adjust start and end times for time zone
    IF pvCallID = 0 Then

		lvTZ = ZoneDifference(pvStartDate, vTZ)

		lvStartDate = DateAdd("h", -lvTZ, pvStartDate)
		lvEndDate = DateAdd("h", -lvTZ, pvEndDate)

	Else
		lvQueryString = "SELECT CallDateTime FROM CALL WHERE CallID = " & pvCALLID
		SET lvRS = lvConn.Execute(lvQueryString)

		If lvRS.EOF Then
			DataSourceName = ARCHIVEDSN
			Set lvConn = GetConnection(DBUSER, DBPWD,DataSourceName )
			SET lvRS = lvConn.Execute(lvQueryString)
		End If
		lvTZ = ZoneDifference(lvRS("CallDateTime"), vTZ)


		SET lvRS = NOTHING
		'lvStartDAte = DateAdd("h", -lvTZ, pvStartDate)
	END IF

     ' build sourcecode list

		IF pvUserOrgID <> 194 Then

			lvSCIList = ""

			lvQueryString = "SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode JOIN WebReportGroup ON WebReportGroup.WeBReportGroupID = WebReportGroupSourceCode.WebReportGroupID WHERE WebReportGroupMaster = 1 AND OrgHierarchyParentID =  " & pvUserOrgID
			'Print lvQueryString
			SET lvRS = lvConn.Execute(lvQueryString)

			WHILE NOT lvRS.EOF

				'SourceCodeID
				lvSCIList = lvSCIList &  RTRIM(lvRS("SourceCodeID"))

				lvRS.MoveNext

				IF NOT lvRS.EOF Then
					lvSCIList = lvSCIList & ", "
				END IF
			WEND

			SET lvRS = NOTHING
		END IF

		'set option access variables.
		IF pvUserOrgID <> 194 Then
			lvQueryString = "SELECT DISTINCT   AccessOrgans, AccessBone, AccessTissue, AccessSkin, AccessValves, AccessEyes, AccessResearch FROM WebReportGroupSourceCode "

			IF pvCallID > 0 Then
				lvQueryString = lvQueryString & "JOIN CALL ON Call.SourceCodeID = WebReportGroupSourceCode.SourceCodeID JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID WHERE CALLID = " & pvCallid & " AND WebReportGroup.OrgHierarchyParentID = " & pvUserOrgID
			ELSE
				lvQueryString = lvQueryString & "WHERE WebReportGroupID = " & pvReportGroupID
				'Response.Write lvQueryString
			END IF
			'Print lvQueryString
			'Response.Write lvQueryString
			'Response.Write (pvUserOrgID & " | " & pvOrganizationID & " | " & pvReportGroupID)

			SET lvRS = lvConn.Execute(lvQueryString)

			IF NOT lvRS.EOF Then

				lvAccessOrgans = lvRS("AccessOrgans")
				lvAccessBone = lvRS("AccessBone")
				lvAccessTissue = lvRS("AccessTissue")
				lvAccessSkin = lvRS("AccessSkin")
				lvAccessValves = lvRS("AccessValves")
				lvAccessEyes = lvRS("AccessEyes")
				lvAccessResearch = lvRS("AccessResearch")

			ELSE
				response.write("<font color=red>Please verify that this Report Group has a Source Code assigned to it.</font>")
				GetDetailList = NULL
				Exit Function
			END IF

			SET lvRS = NOTHING
		ELSE
				lvAccessOrgans = 1
				lvAccessBone = 1
				lvAccessTissue = 1
				lvAccessSkin = 1
				lvAccessValves = 1
				lvAccessEyes = 1
				lvAccessResearch = 1

		END IF

	   'BUILD query to pull referall detail data
	   lvQueryString = ""
	   lvQueryString = "SELECT DISTINCT Referral.ReferralID, Call.CallID, CallNumber, DATEADD(hour, "
	   lvQueryString = lvQueryString & lvTZ
	   lvQueryString = lvQueryString & " , CallDateTime) AS CallDateTime, CONVERT(char(8), DATEADD(hour, "
	   lvQueryString = lvQueryString & lvTZ
	   lvQueryString = lvQueryString & " , CallDateTime), 1) AS CallDate, CONVERT(char(5), DATEADD(hour, "
	   lvQueryString = lvQueryString & lvTZ
	   lvQueryString = lvQueryString & " , CallDateTime), 8) AS CallTime, StatPerson.PersonFirst AS StatPersonFirstName, StatPerson.PersonLast AS StatPersonLastName, ReferralDonorGender + ' ' + ReferralDonorAge + ' ' + ReferralDonorAgeUnit as 'GenderAgeAndUnit', "
	   lvQueryString = lvQueryString & "Call.SourceCodeID, SourceCodeName, Referral.ReferralTypeID, ReferralTypeName, "
	   lvQueryString = lvQueryString & "ReferralDonorLastName, ReferralDonorFirstName, Organization.OrganizationName, "
	   lvQueryString = lvQueryString & "CallerPerson.PersonFirst AS 'CallPersonFirst', CallerPerson.PersonLast AS 'CallerPersonLast', CallPersonType.PersonTypeName AS 'CallerPersonTitle', "

	   lvQueryString = lvQueryString & "SubLocationName, ReferralCallerSubLocationLevel, '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber as 'Phone' , ReferralCallerExtension, "

	   lvQueryString = lvQueryString & "Case when ReferralDonorSSN is not null THEN ReferralDonorRecNumber + ' - ' + ReferralDonorSSN  ELSE ReferralDonorRecNumber  END AS ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorGender, "

	   'ccarroll 12/12/2006 - added conversion to DonorWeight for compatibility. Will not show decimal weight (StatTrac 8.0 Iteration2)
	   lvQueryString = lvQueryString & "CAST(CAST(ReferralDonorWeight as numeric)as varchar) AS 'ReferralDonorWeight', "
	   lvQueryString = lvQueryString & "ReferralDonorOnVentilator, convert(char(8),ReferralDonorAdmitDate,1) as 'ReferralDonorAdmitDate', ReferralDonorAdmitTime, convert(char(8),ReferralDonorDeathDate,1) as 'ReferralDonorDeathDate', ReferralDonorDeathTime, "

	   'ccarroll 08/18/2006 - Added 255 limit to ReferralNotesCase
	   lvQueryString = lvQueryString & "LEFT(REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), ''),255) AS ReferralNotesCase, RaceName, CauseOfDeathName, ApproachTypeName, ApproachPerson.PersonFirst AS ApproachPersonFirst, ApproachPerson.PersonLast AS ApproachPersonLast, "
	   lvQueryString = lvQueryString & "ReferralApproachNOK, ReferralApproachRelation, ReferralNOKPhone, REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralNOKAddress, ReferralCoronerName, ReferralCoronerOrganization, "
	   lvQueryString = lvQueryString & "ReferralCoronerPhone, REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralCoronerNote, Attending.PersonFirst AS AttendingFirst, Attending.PersonLast AS AttendingLast, "
	   lvQueryString = lvQueryString & "Pronouncing.PersonFirst AS PronouncingFirst, Pronouncing.PersonLast AS PronouncingLast, "

	   IF pvUserOrgID = 194 Then
		lvQueryString = lvQueryString & "AppropOrgan.AppropriateReportName AS AppropriateOrgan, ApproaOrgan.ApproachReportName AS ApproachOrgan, ConsentOrgan.ConsentReportName AS ConsentOrgan, RecoveryOrgan.ConversionReportName AS RecoveryOrgan, "
		lvQueryString = lvQueryString & "AppropBone.AppropriateReportName AS AppropriateBone, ApproaBone.ApproachReportName AS ApproachBone, ConsentBone.ConsentReportName AS ConsentBone, RecoveryBone.ConversionReportName AS RecoveryBone, "
		lvQueryString = lvQueryString & "AppropTissue.AppropriateReportName AS AppropriateTissue, ApproaTissue.ApproachReportName AS ApproachTissue, ConsentTissue.ConsentReportName AS ConsentTissue, RecoveryTissue.ConversionReportName AS RecoveryTissue,"
		lvQueryString = lvQueryString & "AppropSkin.AppropriateReportName AS AppropriateSkin, ApproaSkin.ApproachReportName AS ApproachSkin, ConsentSkin.ConsentReportName AS ConsentSkin, RecoverySkin.ConversionReportName AS RecoverySkin, "
		lvQueryString = lvQueryString & "AppropValve.AppropriateReportName AS AppropriateValves, ApproaValve.ApproachReportName AS ApproachValves, ConsentValve.ConsentReportName AS ConsentValve, RecoveryValve.ConversionReportName AS RecoveryValve, "
		lvQueryString = lvQueryString & "AppropEyes.AppropriateReportName AS AppropriateEyes, ApproaEyes.ApproachReportName AS ApproachEyes, ConsentEyes.ConsentReportName AS ConsentEyes, RecoveryEyes.ConversionReportName AS RecoveryEyes, "

	   ELSE
	        'ccarroll 10/06/2006 - Added granularity check for ServiceLevel of Referral by adding
	        'CASE statments - StatTrac 8.0, Iteration 2 release

		' CHECK FOR ORGAN ACCESS
	     IF lvAccessOrgans = 1 Then
	        lvQueryString = lvQueryString & "AppropOrgan.AppropriateReportName AS AppropriateOrgan, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE '' END AS ApproachOrgan, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE '' END AS ConsentOrgan, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE '' END AS RecoveryOrgan, "

	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateOrgan, '' AS ApproachOrgan, '' AS ConsentOrgan , '' AS RecoveryOrgan, "
	     END IF

	     	'CHECK FOR BONE ACCESS
	     IF lvAccessBone = 1 Then
	        lvQueryString = lvQueryString & "AppropBone.AppropriateReportName AS AppropriateBone, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE '' END AS ApproachBone, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE '' END AS ConsentBone, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE '' END AS RecoveryBone, "

	     ELSE
	        lvQueryString = lvQueryString & " '' AS AppropriateBone, '' AS ApproachBone, '' AS ConsentBone, '' AS RecoveryBone, "
	     END IF
	     	'CHECK FOR TISSUE ACCESS
	     IF lvAccessTissue = 1 Then
	        lvQueryString = lvQueryString & "AppropTissue.AppropriateReportName AS AppropriateTissue, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE '' END AS ApproachTissue, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE '' END AS ConsentTissue, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE '' END AS RecoveryTissue,	"

	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateTissue, '' AS ApproachTissue, '' AS ConsentTissue, '' AS RecoveryTissue,"
	     END IF

	     	'CHECK FOR SKIN ACCESS
	     IF lvAccessSkin = 1 Then
	        lvQueryString = lvQueryString & "AppropSkin.AppropriateReportName AS AppropriateSkin, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE '' END AS ApproachSkin, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE '' END AS ConsentSkin, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE '' END AS RecoverySkin, "

	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateSkin, '' AS ApproachSkin, '' AS ConsentSkin, '' AS RecoverySkin, "
	     END IF

	     	'CHECK FOR VALVES ACCESS
	     IF lvAccessValves = 1 Then
	        lvQueryString = lvQueryString & "AppropValve.AppropriateReportName AS AppropriateValves, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE '' END AS ApproachValves, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE '' END AS ConsentValve, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE '' END AS RecoveryValve, "

	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateValves, '' AS ApproachValves, '' AS ConsentValve, '' AS RecoveryValve, "
	     END IF

	     	'CHECK FOR EYES ACCESS
	     IF lvAccessEyes = 1 Then
	        lvQueryString = lvQueryString & "AppropEyes.AppropriateReportName AS AppropriateEyes, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE '' END AS ApproachEyes, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE '' END AS ConsentEyes, "
	        lvQueryString = lvQueryString & "CASE WHEN ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE '' END AS RecoveryEyes, "

	     ELSE
	        lvQueryString = lvQueryString & "'' AS AppropriateEyes, '' AS ApproachEyes, '' AS ConsentEyes, '' AS RecoveryEyes, "
	     END IF
	   End IF 'End IF for start of check for disposition access

		lvQueryString = lvQueryString & "'' as 'blankfield','' as 'blankfield','' as 'blankfield','' as 'blankfield', "

	   lvQueryString = lvQueryString & "ReferralCallerOrganizationID AS OrganizationID, ReferralGeneralConsent, ReferralApproachTime, ReferralConsentTime, ReferralSecondaryHistory, "
	   lvQueryString = lvQueryString & "ReferralExtubated, "
	   'Add Other category to select
	   IF pvUserOrgID = 194 Then
		lvQueryString = lvQueryString & "AppropRsch.AppropriateReportName AS AppropriateOther, ApproaRsch.ApproachReportName AS ApproachOther, ConsentRsch.ConsentReportName AS ConsentOther, RecoveryRsch.ConversionReportName AS RecoveryOther, "

	   Else
		' CHECK FOR ORGAN ACCESS
	    IF lvAccessResearch = 1 Then
			lvQueryString = lvQueryString & "AppropRsch.AppropriateReportName AS AppropriateOther, ApproaRsch.ApproachReportName AS ApproachOther, ConsentRsch.ConsentReportName AS ConsentOther, RecoveryRsch.ConversionReportName AS RecoveryOther, "
	     Else
			lvQueryString = lvQueryString & "'' AS AppropriateOther, '' AS ApproachOther, '' AS ConsentOther, '' AS RecoveryOther, "
	     End If
	   End If

	'Added lines for custom fields
	lvQueryString = lvQueryString & "Referral.ReferralApproachTypeId, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField1 as customField_1, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField2 as customField_2, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField3 as customField_3, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField4 as customField_4, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField5 as customField_5, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField6 as customField_6, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField7 as customField_7, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField8 as customField_8, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField9 as customField_9, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField10 as customField_10, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField11 as customField_11, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField12 as customField_12, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField13 as customField_13, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField14 as customField_14, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField15 as customField_15, "
	lvQueryString = lvQueryString & "CallCustomField.CallCustomField16 as customField_16, "
	'Added lines for custom field labels
	'lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomTextAlert AS ServiceLevelCustomTextAlert, "
	'lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomListAlert AS ServiceLevelCustomListAlert, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, "
	lvQueryString = lvQueryString & "ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16, "
	lvQueryString = lvQueryString & "CONVERT (varchar(14), DATEADD(hour, "
	lvQueryString = lvQueryString & lvTZ
	lvQueryString = lvQueryString & ", Referral.lastmodified), 1) + ' ' + CONVERT (varchar(14), DATEADD(hour, "
	lvQueryString = lvQueryString & lvTZ
	lvQueryString = lvQueryString & ", Referral.lastmodified), 108) as 'ftplastmodified', "
	lvQueryString = lvQueryString & "Organization.OrganizationUserCode, ReferralDonorRaceID, ReferralDonorCauseOfDeathID,  "
	lvQueryString = lvQueryString & "ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID,  "
	lvQueryString = lvQueryString & "ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID,  "
	lvQueryString = lvQueryString & "ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID,  "
	lvQueryString = lvQueryString & "ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID,  "
	lvQueryString = lvQueryString & "ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID,  "
	lvQueryString = lvQueryString & "ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID,  "
	lvQueryString = lvQueryString & "ReferralOrganConversionID, ReferralBoneConversionID, ReferralTissueConversionID,  "
	lvQueryString = lvQueryString & "ReferralSkinConversionID, ReferralValvesConversionID, ReferralEyesTransConversionID,  "
	lvQueryString = lvQueryString & "ReferralOrganDispositionID, ReferralAllTissueDispositionID, ReferralEyesDispositionID,  "
	lvQueryString = lvQueryString & "ReferralBoneDispositionID, ReferralTissueDispositionID, ReferralSkinDispositionID,  "
	lvQueryString = lvQueryString & "ReferralValvesDispositionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID,  "
	lvQueryString = lvQueryString & "ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralRschDispositionID,  "
	'10/24/04 CAB - Changed below string to format date from SQL as mm/dd/yyyy.
	lvQueryString = lvQueryString & "Cast(DATEPART(m, ReferralDOB) AS Varchar) + '/' + Cast(DATEPART(d, ReferralDOB) AS Varchar) + '/' + Cast(DATEPART(yyyy, ReferralDOB) AS Varchar), "
	lvQueryString = lvQueryString & "ReferralDonorSSN, CASE ReferralCoronersCase WHEN -1 Then 0 WHEN 0 Then -1 END AS 'CoronoersCase', "
	lvQueryString = lvQueryString & "CTY.CountyName AS 'CoronerCounty', REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', "
	lvQueryString = lvQueryString & "ReferralDonorRecNumber, "
   	lvQueryString = lvQueryString & "CONVERT (varchar(14), DATEADD(hour, "
   	lvQueryString = lvQueryString & lvTZ
   	lvQueryString = lvQueryString & ", CallDateTime), 1) + ' ' + CONVERT (varchar(14), DATEADD(hour, "
   	lvQueryString = lvQueryString & lvTZ
	lvQueryString = lvQueryString & ", CallDateTime), 108) as 'FTPCallDateTime', "

	'Add Extended Referral Data 2004 File Fields 115-127 02/09/2005 CAC
	lvQueryString = lvQueryString & "CASE WHEN Len(Referral.ReferralCoronerOrganization) > 0 THEN CoronerST.StateAbbrv ELSE NULL END as CoronerState,  "
    lvQueryString = lvQueryString & "Referral.ReferralCoronerOrganization AS CoronerOrganization, "
    lvQueryString = lvQueryString & "Referral.ReferralCoronerName AS CoronerName, "
    lvQueryString = lvQueryString & "Referral.ReferralCoronerPhone AS CoronerPhone, "
    lvQueryString = lvQueryString & "REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS CoronerNote, "
    lvQueryString = lvQueryString & "Referral.ReferralNOKPhone AS NOKPhone, "
    lvQueryString = lvQueryString & "REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') AS NOKAddress, "
	lvQueryString = lvQueryString & "RegistryStatus.RegistryStatus as RegistryStatusID, "
    lvQueryString = lvQueryString & "CASE RegistryStatus.RegistryStatus "
	lvQueryString = lvQueryString & "WHEN 1 THEN 'Found on the State Registry' "
	lvQueryString = lvQueryString & "WHEN 2 THEN 'Found on the Web Registry' "
	'Swapped incorrect description values for RegistryStatusTypes 3 and 4.  5/6/05 - SAP
	lvQueryString = lvQueryString & "WHEN 3 THEN 'Not on the Registry' "
	lvQueryString = lvQueryString & "WHEN 4 THEN 'Manually Found' "
	lvQueryString = lvQueryString & "WHEN 5 THEN 'Not Checked' "
	lvQueryString = lvQueryString & "END AS RegistryStatus, "
    lvQueryString = lvQueryString & "Case Referral.ReferralDonorHeartBeat WHEN 1 Then 'Y' ELSE 'N' END AS PatientHasHeartbeat, "
    lvQueryString = lvQueryString & "CASE Referral.ReferralDOA WHEN -1 Then 'Y' ELSE 'N' END AS DOA, "
    lvQueryString = lvQueryString & "AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS AttendingPhysician, "
    lvQueryString = lvQueryString & "PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS PronouncingPhysician,  "

   	'FSCase table for Extended FS Fields 128-159 02/11/2005 CAC
	lvQueryString = lvQueryString & "FSCaseId, FSCaseCreateUserId, FSCaseCreateDateTime, FSCaseOpenUserId, FSCaseOpenDateTime, "
	lvQueryString = lvQueryString & "FSCaseSysEventsUserId, FSCaseSysEventsDateTime, FSCaseSecCompUserId, FSCaseSecCompDateTime, "
	lvQueryString = lvQueryString & "FSCaseApproachUserId, FSCaseApproachDateTime, FSCaseFinalUserId, FSCaseFinalDateTime, FSCaseUpdate, "
	lvQueryString = lvQueryString & "FSCaseUserId, FSCaseBillSecondaryUserID, FSCaseBillDateTime, FSCaseBillApproachUserID, "
	lvQueryString = lvQueryString & "FSCaseBillApproachDateTime, FSCaseBillMedSocUserID, FSCaseBillMedSocDateTime, "
	lvQueryString = lvQueryString & "SecondaryManualBillPersonId, SecondaryUpdatedFlag, FSCaseTotalTime, FSCaseSeconds, "
	lvQueryString = lvQueryString & "FSCaseBillFamUnavailUserId, FSCaseBillFamUnavailDateTime, FSCaseBillCryoFormUserId, "
	lvQueryString = lvQueryString & "FSCaseBillCryoFormDateTime, FSCaseBillApproachCount, FSCaseBillMedSocCount, FSCaseBillCryoFormCount, "

    'Secondary table for Extended FS Fields 160-305 02/09/2005 CAC
    lvQueryString = lvQueryString & "SecondaryWhoAreWe, SecondaryNOKaware, SecondaryFamilyConsent, "
	lvQueryString = lvQueryString & "SecondaryFamilyInterested, SecondaryNOKatHospital, SecondaryEstTimeSinceLeft, "
	lvQueryString = lvQueryString & "SecondaryTimeLeftInMT, SecondaryNOKNextDest, SecondaryNOKETA, "
	lvQueryString = lvQueryString & "SecondaryPatientMiddleName, SecondaryPatientHeightFeet, SecondaryPatientHeightInches, "
	lvQueryString = lvQueryString & "SecondaryPatientBMICalc, SecondaryPatientTOD1, SecondaryPatientTOD2, SecondaryPatientDeathType1, "
	lvQueryString = lvQueryString & "SecondaryPatientDeathType2, SecondaryTriageHX, REPLACE(REPLACE(SecondaryCircumstanceOfDeath, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCircumstanceOfDeath, "
	lvQueryString = lvQueryString & "REPLACE(REPLACE(SecondaryMedicalHistory, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryMedicalHistory, SecondaryAdmissionDiagnosis, SecondaryCOD, "
	lvQueryString = lvQueryString & "SecondaryCODSignatory, SecondaryCODTime, SecondaryCODSignedBy, SecondaryPatientVent, "
	lvQueryString = lvQueryString & "SecondaryIntubationDate, SecondaryIntubationTime, SecondaryBrainDeathDate, "
	lvQueryString = lvQueryString & "SecondaryBrainDeathTime, SecondaryDNRDate, SecondaryERORDeath, "
	lvQueryString = lvQueryString & "SecondaryEMSArrivalToPatientDate, SecondaryEMSArrivalToPatientTime, "
	lvQueryString = lvQueryString & "SecondaryEMSArrivalToHospitalDate, SecondaryEMSArrivalToHospitalTime, "
	lvQueryString = lvQueryString & "SecondaryPatientTerminal, SecondaryDeathWitnessed, SecondaryDeathWitnessedBy, "
	lvQueryString = lvQueryString & "SecondaryLSADate, SecondaryLSATime, SecondaryLSABy, SecondaryACLSProvided, "
	lvQueryString = lvQueryString & "SecondaryACLSProvidedTime, SecondaryGestationalAge, SecondaryParentName1, "
	lvQueryString = lvQueryString & "SecondaryParentName2, SecondaryBirthCBO, SecondaryActiveInfection, "
	lvQueryString = lvQueryString & "SecondaryActiveInfectionType, SecondaryFluidsGiven, SecondaryBloodLoss, "
	lvQueryString = lvQueryString & "SecondarySignOfInfection, SecondaryMedication, SecondaryAntibiotic, "
	lvQueryString = lvQueryString & "SecondaryPCPName, SecondaryPCPPhone, SecondaryMDAttending, "
	lvQueryString = lvQueryString & "SecondaryMDAttendingPhone, REPLACE(REPLACE(SecondaryPhysicalAppearance, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryPhysicalAppearance, SecondaryInternalBloodLossCC, "
	lvQueryString = lvQueryString & "SecondaryExternalBloodLossCC, SecondaryBloodProducts, SecondaryColloidsInfused, "
	lvQueryString = lvQueryString & "SecondaryCrystalloids, SecondaryPreTransfusionSampleRequired, SecondaryPreTransfusionSampleAvailable, "
	lvQueryString = lvQueryString & "SecondaryPreTransfusionSampleDrawnDate, SecondaryPreTransfusionSampleDrawnTime, "
	lvQueryString = lvQueryString & "SecondaryPreTransfusionSampleQuantity, SecondaryPreTransfusionSampleHeldAt, "
	lvQueryString = lvQueryString & "SecondaryPreTransfusionSampleHeldDate, SecondaryPreTransfusionSampleHeldTime, "
	lvQueryString = lvQueryString & "SecondaryPreTransfusionSampleHeldTechnician, SecondaryPostMordemSampleTestSuitable, "
	lvQueryString = lvQueryString & "SecondaryPostMordemSampleLocation, SecondaryPostMordemSampleContact, "
	lvQueryString = lvQueryString & "SecondaryPostMordemSampleCollectionDate, SecondaryPostMordemSampleCollectionTime, "
	lvQueryString = lvQueryString & "REPLACE(REPLACE(SecondarySputumCharacteristics, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondarySputumCharacteristics, SecondaryNOKAltPhone, SecondaryNOKLegal, "
	lvQueryString = lvQueryString & "SecondaryNOKAltContact, SecondaryNOKAltContactPhone, SecondaryNOKPostMortemAuthorization, "
	lvQueryString = lvQueryString & "SecondaryNOKPostMortemAuthorizationReminder, SecondaryCoronerCaseNumber, SecondaryCoronerCounty, "
	lvQueryString = lvQueryString & "SecondaryCoronerReleased, REPLACE(REPLACE(SecondaryCoronerReleasedStipulations, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCoronerReleasedStipulations, SecondaryAutopsy, "
	lvQueryString = lvQueryString & "SecondaryAutopsyDate, SecondaryAutopsyTime, SecondaryAutopsyLocation, SecondaryAutopsyBloodRequested, "
	lvQueryString = lvQueryString & "SecondaryAutopsyCopyRequested, SecondaryFuneralHomeSelected, SecondaryFuneralHomeName, "
	lvQueryString = lvQueryString & "SecondaryFuneralHomePhone, SecondaryFuneralHomeAddress, SecondaryFuneralHomeContact, "
	lvQueryString = lvQueryString & "SecondaryFuneralHomeNotified, SecondaryFuneralHomeMorgueCooled, SecondaryHoldOnBody, "
	lvQueryString = lvQueryString & "SecondaryHoldOnBodyTag, SecondaryBodyRefrigerationDate, SecondaryBodyRefrigerationTime, "
	lvQueryString = lvQueryString & "SecondaryBodyLocation, SecondaryBodyMedicalChartLocation, SecondaryBodyIDTagLocation, "
	lvQueryString = lvQueryString & "SecondaryBodyCoolingMethod, SecondaryUNOSNumber, SecondaryClientNumber, SecondaryCryolifeNumber, "
	lvQueryString = lvQueryString & "SecondaryMTFNumber, SecondaryLifeNetNumber, REPLACE(REPLACE(SecondaryFreeText, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryFreeText, SecondaryHistorySubstanceAbuse, "
	lvQueryString = lvQueryString & "SecondarySubstanceAbuseDetail, SecondaryExtubationDate, SecondaryExtubationTime, SecondaryAutopsyReminderYN, "
	lvQueryString = lvQueryString & "SecondaryFHReminderYN, SecondaryBodyCareReminderYN, SecondaryWrapUpReminderYN, SecondaryNOKNotifiedBy, "
	lvQueryString = lvQueryString & "SecondaryNOKNotifiedDate, SecondaryNOKNotifiedTime, SecondaryNOKGender, SecondaryCODOther, "
	lvQueryString = lvQueryString & "SecondaryAutopsyLocationOther, SecondaryPatientHospitalPhone, SecondaryCoronerCase, "
	lvQueryString = lvQueryString & "SecondaryPatientABO, SecondaryPatientSuffix, SecondaryMDAttendingId, REPLACE(REPLACE(SecondaryAdditionalComments, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryAdditionalComments, "
	lvQueryString = lvQueryString & "SecondaryRhythm, REPLACE(REPLACE(SecondaryAdditionalMedications, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryAdditionalMedications, SecondaryBodyHoldPlaced, SecondaryBodyHoldPlacedWith, "
	lvQueryString = lvQueryString & "SecondaryBodyFutureContact, SecondaryBodyHoldPhone, SecondaryBodyHoldInstructionsGiven, "
	lvQueryString = lvQueryString & "SecondarySteroid, SecondaryBodyHoldPlacedTime, "

	'Secondary2 table for Extended FS Fields 306-413 02/09/2005 CAC
	lvQueryString = lvQueryString & "SecondaryAntibiotic1Name, SecondaryAntibiotic1Dose, SecondaryAntibiotic1StartDate, SecondaryAntibiotic1EndDate, "
	lvQueryString = lvQueryString & "SecondaryAntibiotic2Name, SecondaryAntibiotic2Dose, SecondaryAntibiotic2StartDate, SecondaryAntibiotic2EndDate, "
	lvQueryString = lvQueryString & "SecondaryAntibiotic3Name, SecondaryAntibiotic3Dose, SecondaryAntibiotic3StartDate, SecondaryAntibiotic3EndDate, "
	lvQueryString = lvQueryString & "SecondaryAntibiotic4Name, SecondaryAntibiotic4Dose, SecondaryAntibiotic4StartDate, SecondaryAntibiotic4EndDate, "
	lvQueryString = lvQueryString & "SecondaryAntibiotic5Name, SecondaryAntibiotic5Dose, SecondaryAntibiotic5StartDate, SecondaryAntibiotic5EndDate, "
	lvQueryString = lvQueryString & "SecondaryBloodProductsReceived1Type, SecondaryBloodProductsReceived1Units, SecondaryBloodProductsReceived1TypeCC, "
	lvQueryString = lvQueryString & "SecondaryBloodProductsReceived1TypeUnitGiven, SecondaryBloodProductsReceived2Type, SecondaryBloodProductsReceived2Units, "
	lvQueryString = lvQueryString & "SecondaryBloodProductsReceived2TypeCC, SecondaryBloodProductsReceived2TypeUnitGiven, SecondaryBloodProductsReceived3Type, "
	lvQueryString = lvQueryString & "SecondaryBloodProductsReceived3Units, SecondaryBloodProductsReceived3TypeCC, SecondaryBloodProductsReceived3TypeUnitGiven, "
	lvQueryString = lvQueryString & "SecondaryColloidsInfused1Type, SecondaryColloidsInfused1Units, SecondaryColloidsInfused1CC, SecondaryColloidsInfused1UnitGiven, "
	lvQueryString = lvQueryString & "SecondaryColloidsInfused2Type, SecondaryColloidsInfused2Units, SecondaryColloidsInfused2CC, SecondaryColloidsInfused2UnitGiven, "
	lvQueryString = lvQueryString & "SecondaryColloidsInfused3Type, SecondaryColloidsInfused3Units, SecondaryColloidsInfused3CC, SecondaryColloidsInfused3UnitGiven, "
	lvQueryString = lvQueryString & "SecondaryCrystalloids1Type, SecondaryCrystalloids1Units, SecondaryCrystalloids1CC, SecondaryCrystalloids1UnitGiven, "
	lvQueryString = lvQueryString & "SecondaryCrystalloids2Type, SecondaryCrystalloids2Units, SecondaryCrystalloids2CC, SecondaryCrystalloids2UnitGiven, "
	lvQueryString = lvQueryString & "SecondaryCrystalloids3Type, SecondaryCrystalloids3Units, SecondaryCrystalloids3CC, SecondaryCrystalloids3UnitGiven, "
	lvQueryString = lvQueryString & "SecondaryWBC1Date, SecondaryWBC1, SecondaryWBC1Bands, SecondaryWBC2Date, SecondaryWBC2, SecondaryWBC2Bands, "
	lvQueryString = lvQueryString & "SecondaryWBC3Date, SecondaryWBC3, SecondaryWBC3Bands, SecondaryLabTemp1, SecondaryLabTemp1Date, SecondaryLabTemp1Time, "
	lvQueryString = lvQueryString & "SecondaryLabTemp2, SecondaryLabTemp2Date, SecondaryLabTemp2Time, SecondaryLabTemp3, SecondaryLabTemp3Date, "
	lvQueryString = lvQueryString & "SecondaryLabTemp3Time, SecondaryCulture1Type, SecondaryCulture1Other, SecondaryCulture1DrawnDate, "
	lvQueryString = lvQueryString & "SecondaryCulture1Growth, SecondaryCulture2Type, SecondaryCulture2Other, SecondaryCulture2DrawnDate, "
	lvQueryString = lvQueryString & "SecondaryCulture2Growth, SecondaryCulture3Type, SecondaryCulture3Other, SecondaryCulture3DrawnDate, "
	lvQueryString = lvQueryString & "SecondaryCulture3Growth, SecondaryCXRAvailable, SecondaryCXR1Date, REPLACE(REPLACE(SecondaryCXR1Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR1Finding, SecondaryCXR2Date, "
	lvQueryString = lvQueryString & "REPLACE(REPLACE(SecondaryCXR2Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR2Finding, SecondaryCXR3Date, REPLACE(REPLACE(SecondaryCXR3Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR3Finding, SecondaryAntibiotic1NameOther, "
	lvQueryString = lvQueryString & "SecondaryAntibiotic2NameOther, SecondaryAntibiotic3NameOther, SecondaryAntibiotic4NameOther, "
	lvQueryString = lvQueryString & "SecondaryAntibiotic5NameOther, SecondaryBloodProductsReceived1TypeOther, SecondaryBloodProductsReceived2TypeOther, "
	lvQueryString = lvQueryString & "SecondaryBloodProductsReceived3TypeOther, SecondaryColloidsInfused1TypeOther, SecondaryColloidsInfused2TypeOther, "
	lvQueryString = lvQueryString & "SecondaryColloidsInfused3TypeOther, SecondaryCrystalloids1TypeOther, SecondaryCrystalloids2TypeOther, "
	lvQueryString = lvQueryString & "SecondaryCrystalloids3TypeOther, "

	'SecondaryApproach table for FS Fields 414-430 02/09/2005 CAC
	lvQueryString = lvQueryString & "SecondaryApproached, SecondaryApproachedBy, SecondaryApproachType, SecondaryApproachOutcome, SecondaryApproachReason, "
	lvQueryString = lvQueryString & "SecondaryConsented, SecondaryConsentBy, SecondaryConsentOutcome, SecondaryConsentResearch, SecondaryRecoveryLocation, "
	lvQueryString = lvQueryString & "SecondaryHospitalApproach, SecondaryHospitalApproachedBy, SecondaryHospitalOutcome, SecondaryConsentMedSocPaperwork, "
	lvQueryString = lvQueryString & "SecondaryConsentMedSocObtainedBy, SecondaryConsentFuneralPlans, SecondaryConsentFuneralPlansOther, "
	lvQueryString = lvQueryString & "SecondaryConsentLongSleeves "

	   'lvQueryString = lvQueryString & "FROM Call LEFT JOIN Referral ON Referral.CallID = Call.CallID "
	   lvQueryString = lvQueryString & "FROM Call JOIN Referral ON Referral.CallID = Call.CallID "
	   lvQueryString = lvQueryString & "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
	   lvQueryString = lvQueryString & "LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID "
	   lvQueryString = lvQueryString & "LEFT JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID "
	   lvQueryString = lvQueryString & "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID "
	   lvQueryString = lvQueryString & "LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD "
	   lvQueryString = lvQueryString & "LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD "
	   lvQueryString = lvQueryString & "LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID "
	   lvQueryString = lvQueryString & "LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID "
	   lvQueryString = lvQueryString & "LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID "
	   lvQueryString = lvQueryString & "LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID "
	   lvQueryString = lvQueryString & "LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID "
	   lvQueryString = lvQueryString & "LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID "

	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID "
	   lvQueryString = lvQueryString & "LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID "

	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID "
	   lvQueryString = lvQueryString & "LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID "

	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID "
	   lvQueryString = lvQueryString & "LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID "

	   lvQueryString = lvQueryString & "LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID "

	   'Added custom fields 00.0928 - ttw
	   lvQueryString = lvQueryString & "LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID "



	   '02/13/03 bjk need to change join statments based on when the referral exists
	   	' if the referral is pre Family Services Module (8/14/2002 ) use old join to obtain ServiceLevelID
	   'callid 2673141 8/13/02 07:57
	   	  'evaluate by callid if callid > 0
	   	   if pvCallid > 0 Then

			   If pvCallID < 2673141  Then
				   'Added Custom field labels 01.0518
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
				   lvQueryString = lvQueryString & "JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID "
				   lvQueryString = lvQueryString & "and ServiceLevelStatus = 0 "
				   lvQueryString = lvQueryString & "JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID "
				   lvQueryString = lvQueryString & "AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID "
				   lvQueryString = lvQueryString & "JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID "

		   ' if the referral is post Family Services Module (8/14/2002 ) use new join to CallCriteria to obtain ServiceLevel
			   Else
				   'Added Custom field labels 01.0518
				   '02/12/03 bjk modifed relation to ServiceLevel
				   lvQueryString = lvQueryString & "LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID "
				   lvQueryString = lvQueryString & "AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID "
			   End if
		   'evaluate by date if call id = 0
		   else 'lvStartDate < "8/13/02")
			   If cdate(lvStartDate) < cdate("8/13/02 07:57")  Then
				   'Added Custom field labels 01.0518
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
				   lvQueryString = lvQueryString & "JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID "
				   lvQueryString = lvQueryString & "and ServiceLevelStatus = 0 "
				   lvQueryString = lvQueryString & "JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID "
				   lvQueryString = lvQueryString & "AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID "
				   lvQueryString = lvQueryString & "JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID "

		   ' if the referral is post Family Services Module (8/14/2002 ) use new join to CallCriteria to obtain ServiceLevel
			   Else
				   'Added Custom field labels 01.0518
				   '02/12/03 bjk modifed relation to ServiceLevel
				   lvQueryString = lvQueryString & "LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID "
				   lvQueryString = lvQueryString & "AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID "
				   lvQueryString = lvQueryString & "LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID "


				   'Added Extended Referral Data 2004 File fields 115 to 127 02/09/2005
					lvQueryString = lvQueryString & "LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID "
					lvQueryString = lvQueryString & "LEFT JOIN Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD "
					lvQueryString = lvQueryString & "LEFT JOIN Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD "

				   'ccarroll 06/16/2008 JOIN was to ReferralCallerOrganizationID
				    lvQueryString = lvQueryString & "LEFT JOIN Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCoronerOrgID "

					'lvQueryString = lvQueryString & "LEFT JOIN Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCallerOrganizationID "
					lvQueryString = lvQueryString & "LEFT JOIN State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID "

					'FSCase table for Extended FS Fields 128-433 02/14/2005 CAC
					lvQueryString = lvQueryString & "LEFT JOIN Secondary on Secondary.CallID = Call.CallID "
					lvQueryString = lvQueryString & "LEFT JOIN Secondary2 on Secondary2.CallID = Call.CallID "
					lvQueryString = lvQueryString & "LEFT JOIN SecondaryApproach on SecondaryApproach.CallID = Call.CallID "
					'lvQueryString = lvQueryString & "LEFT JOIN SecondaryMedication on SecondaryMedication.CallID = Call.CallID "
					'lvQueryString = lvQueryString & "LEFT JOIN SecondaryMedicationOther on SecondaryMedicationOther.CallID = SecondaryMedication.CallID "
					lvQueryString = lvQueryString & "LEFT JOIN FSCase on FSCase.CallID = Call.CallID "

			   End if



		   End If

	   '02/08/03 bjk joins added to query to accomodate fields for FTP on Demanded
 	   'lvQueryString = lvQueryString & "LEFT JOIN Organization ME ON ME.OrganizationName = Referral.ReferralCoronerOrganization "
	   'lvQueryString = lvQueryString & "LEFT JOIN COUNTY CTY ON CTY.CountyID = ME.CountyID "


       'ccarroll 06/16/2008 changed query to resolve HS-8845 duplicate referrals. JOIN was to ME.CountyID
        lvQueryString = lvQueryString & "LEFT JOIN COUNTY CTY ON CTY.CountyID = CoronerOrg.CountyID "

	IF pvCallID > 0 Then
		lvQueryString = lvQueryString & "WHERE Call.CALLID = "
		lvQueryString = lvQueryString & pvCallID
		'lvQueryString = lvQueryString & " AND CallTypeID = 1 "
		IF pvUserOrgID <> 194 Then
		lvQueryString = lvQueryString & " AND CALL.SourceCodeID IN ( "
		lvQueryString = lvQueryString & lvSCIList
		'lvQueryString = lvQueryString & convert(char(25), lvpvReportGroupID)
		lvQueryString = lvQueryString & " ) "
		lvQueryString = lvQueryString & " AND WebReportGroup.OrgHierarchyParentID = "
		lvQueryString = lvQueryString & pvUserOrgID
		END IF
	ELSE
		lvQueryString = lvQueryString & "WHERE CallDateTime BETWEEN '"
		lvQueryString = lvQueryString & lvStartDate
		lvQueryString = lvQueryString & "' AND '"
		lvQueryString = lvQueryString & lvEndDate
		lvQueryString = lvQueryString & "' AND WebReportGroupOrg.WebReportGroupID = "
		lvQueryString = lvQueryString & pvReportGroupID
		IF pvUserOrgID <> 194 Then
		lvQueryString = lvQueryString & " AND CALL.SourceCodeID IN ( "
		lvQueryString = lvQueryString & lvSCIList
		'lvQueryString = lvQueryString & convert(char(25), lvpvReportGroupID)
		lvQueryString = lvQueryString & " ) "
		END IF
		IF pvReferralTypeID > 0 Then
		lvQueryString = lvQueryString & "AND Referral.ReferralTypeID = "
		lvQueryString = lvQueryString & pvReferralTypeID
		END IF
		IF PvOrgID <> 0 THEN
		        lvQueryString = lvQueryString & " AND Referral.ReferralCallerOrganizationID = "
		        lvQueryString = lvQueryString & PvOrgID
		END IF

		   lvQueryString = lvQueryString & " ORDER BY "
		   lvQueryString = lvQueryString & pvOrderBy
	END IF  ' end CallID Exists

	GetDetailList = lvQueryString

	SET lvRS = nothing
	SET lvConn = nothing

End Function



%>
