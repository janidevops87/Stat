PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:2/4/2020 4:23:13 PM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST311Early2020BugFix\App\Database\Create Scripts\Transactional\Sprocs\SelectRefQueryStatEmployee.sql
-- C:\Statline\StatTrac\Development\CCRST311Early2020BugFix\App\Database\Create Scripts\Transactional\Sprocs\sps_rpt_ReferralDetail_Extended_2006_Select.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST311Early2020BugFix\App\Database\Create Scripts\Transactional\Sprocs\SelectRefQueryStatEmployee.sql'
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'SelectRefQueryStatEmployee')
	BEGIN
		PRINT 'Dropping Procedure SelectRefQueryStatEmployee';
		DROP Procedure SelectRefQueryStatEmployee;
	END
GO

PRINT 'Creating Procedure SelectRefQueryStatEmployee';
GO
CREATE Procedure SelectRefQueryStatEmployee
(
		@PersonID INT = NULL,
		@StatEmployeeID INT = NULL,
		@PersonFirst VARCHAR(50) = NULL,
		@PersonLast VARCHAR(50) = NULL
)
AS
/******************************************************************************
**	File: SelectRefQueryStatEmployee.sql
**	Name: SelectRefQueryStatEmployee
**	Desc: Selects Employee ID & name
**	Auth: Mike Berenson
**	Date: 10/14/2019
**	Called By: StatQuery.RefQueryStatEmployee
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/14/2019		Mike Berenson		Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT 
		se.StatEmployeeID,
		p.PersonFirst + ' ' + p.PersonLast
	FROM 
		StatEmployee se
		JOIN Person p ON p.PersonID = se.PersonID
	WHERE
		(@StatEmployeeID IS NULL OR se.StatEmployeeID = @StatEmployeeID)
		AND (@PersonID IS NULL OR p.PersonID = @PersonID)
		AND (@PersonFirst IS NULL OR p.PersonFirst = @PersonFirst)
		AND (@PersonLast IS NULL OR p.PersonLast = @PersonLast)
		AND p.Inactive = 0
	GROUP BY 
		se.StatEmployeeID,
		p.PersonFirst + ' ' + p.PersonLast
	ORDER BY 
		p.PersonFirst + ' ' + p.PersonLast;

GO

GRANT EXEC ON SelectRefQueryStatEmployee TO PUBLIC;
GO

GO
PRINT 'C:\Statline\StatTrac\Development\CCRST311Early2020BugFix\App\Database\Create Scripts\Transactional\Sprocs\sps_rpt_ReferralDetail_Extended_2006_Select.sql'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_ReferralDetail_Extended_2006_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralDetail_Extended_2006_Select.sql';
		PRINT GETDATE();
		DROP Procedure sps_rpt_ReferralDetail_Extended_2006_Select;
	END
GO

PRINT 'Creating Procedure sps_rpt_ReferralDetail_Extended_2006_Select';
PRINT GETDATE();
GO
CREATE Procedure sps_rpt_ReferralDetail_Extended_2006_Select
(
		@CallID					INT	= NULL,
		@OrganizationIDCaller	INT = NULL,
		@OrganizationIDParent	INT = NULL,
		@WebReportGroupID		INT = NULL,
		@ReferralTypeID			INT = NULL,
		@CallDateTimeStart		DATETIME = NULL,
		@CallDateTimeEnd		DATETIME = NULL,
		@SourceCodeIDList		VARCHAR(MAX) = NULL,
		@OrderBy				VARCHAR(MAX) = NULL
)
AS
/******************************************************************************
**	File: sps_rpt_ReferralDetail_Extended_2006_Select.sql
**	Name: sps_rpt_ReferralDetail_Extended_2006_Select
**	Desc: Selects Referral Report Data
**	Auth: Mike Berenson
**	Date: 1/6/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/6/2020		Mike Berenson			Initial Sproc Creation
**	1/15/2020		Mike Berenson			Added a second temp table for performance
**	1/24/2020		Mike Berenson			Added temp table for sourceCodes with Split
**	1/29/2020		Mike Berenson			Grouped order by case statements to segregate types
**	1/30/2020		Mike Berenson			Added missing fields so we don't change the fields 
**											or the order we're returning
**	2/4/2020		Mike Berenson			Matched output from before sp was created
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DROP TABLE IF EXISTS #extendedDetail2006_1; --sql2016 syntax
	DROP TABLE IF EXISTS #extendedDetail2006_2; 
	DROP TABLE IF EXISTS #sourceCodes;

	SELECT CAST(VALUE AS INT) AS VALUE
	INTO #sourceCodes
	FROM STRING_SPLIT(@SourceCodeIDList, ',');
		
	SELECT
		CallID, 
		CallNumber, 
		DATEADD(HOUR, 0 , CallDateTime) AS CallDateTime,
		CONVERT(CHAR(8), DATEADD(HOUR, 0 , CallDateTime), 1) AS CallDate,
		CONVERT(CHAR(5), DATEADD(HOUR, 0 , CallDateTime), 8) AS CallTime,
		StatPerson.PersonFirst AS StatPersonFirstName,
		StatPerson.PersonLast AS StatPersonLastName,
		Call.SourceCodeID,
		SourceCodeName,
		CONVERT (VARCHAR(14), DATEADD(HOUR, 0 , CallDateTime), 1) + ' ' + CONVERT (VARCHAR(14), DATEADD(HOUR, 0 , CallDateTime), 108) AS 'FTPCallDateTime'
	INTO #extendedDetail2006_1
	FROM Call
		LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
		LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
		LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID 
		LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID 
		LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID
	WHERE (@CallID IS NULL 
			AND (@CallDateTimeStart IS NULL OR CallDateTime >= @CallDateTimeStart)
			AND (@CallDateTimeEnd IS NULL OR CallDateTime <= @CallDateTimeEnd)
			AND (@OrganizationIDParent IS NULL OR (@OrganizationIDParent <> 194 AND Call.SourceCodeID IN (SELECT VALUE FROM #SourceCodes)))
			)
			OR (Call.CallID = @CallID
				AND (@OrganizationIDParent IS NULL OR
				((@OrganizationIDParent <> 194)
					AND Call.SourceCodeID IN (SELECT VALUE FROM #SourceCodes)
					)));

	--SELECT * FROM (SELECT DISTINCT * FROM #extendedDetail2006_1) AS t

	SELECT 
			Referral.ReferralID, 
			#extendedDetail2006_1.CallID, 
			#extendedDetail2006_1.CallNumber, 
			#extendedDetail2006_1.CallDateTime,
			#extendedDetail2006_1.CallDate,
			#extendedDetail2006_1.CallTime,
			#extendedDetail2006_1.StatPersonFirstName,
			#extendedDetail2006_1.StatPersonLastName,
			ReferralDonorGender + ' ' + ReferralDonorAge + ' ' + ReferralDonorAgeUnit AS 'GenderAgeAndUnit',
			#extendedDetail2006_1.SourceCodeID,
			#extendedDetail2006_1.SourceCodeName,
			Referral.ReferralTypeID,
			ReferralTypeName,
			ReferralDonorLastName,
			ReferralDonorFirstName,
			Organization.OrganizationName,
			CallerPerson.PersonFirst AS 'CallPersonFirst',
			CallerPerson.PersonLast AS 'CallerPersonLast',
			CallPersonType.PersonTypeName AS 'CallerPersonTitle',
			SubLocationName,
			ReferralCallerSubLocationLevel,
			'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'Phone' ,
			ReferralCallerExtension,
			CASE WHEN ReferralDonorSSN IS NOT NULL THEN ReferralDonorRecNumber + ' - ' + ReferralDonorSSN  ELSE ReferralDonorRecNumber  END AS ReferralDonorRecNumber,
			ReferralDonorAge,
			ReferralDonorAgeUnit,
			ReferralDonorGender,
			CAST(CAST(REPLACE(ReferralDonorWeight,',','') AS NUMERIC)AS VARCHAR) AS ReferralDonorWeight,
			ReferralDonorOnVentilator,
			CONVERT(CHAR(8),ReferralDonorAdmitDate,1) AS 'ReferralDonorAdmitDate',
			ReferralDonorAdmitTime,
			CONVERT(CHAR(8),ReferralDonorDeathDate,1) AS 'ReferralDonorDeathDate',
			ReferralDonorDeathTime,
			CAST(REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS VARCHAR(255)) AS ReferralNotesCase,
			RaceName,
			CauseOfDeathName,
			ApproachTypeName,
			ApproachPerson.PersonFirst AS ApproachPersonFirst,
			ApproachPerson.PersonLast AS ApproachPersonLast,
			CASE WHEN ReferralNOKID IS NOT NULL THEN LEFT(REPLACE(REPLACE(NOK.NOKFirstName + ' ' + NOK.NOKLastName,CHAR(10), CHAR(32)), CHAR(13), ''),50) ELSE ReferralApproachNOK END AS ReferralApproachNOK,
			CASE WHEN ReferralNOKID IS NOT NULL THEN NOK.NOKApproachRelation ELSE ReferralApproachRelation END AS ReferralApproachRelation,
			ReferralNOKPhone,
			CASE WHEN ReferralNOKID IS NOT NULL THEN LEFT(REPLACE(REPLACE(Referral.ReferralNOKAddress + ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, CHAR(10), CHAR(32)), CHAR(13), ''), 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS ReferralNOKAddress,
			ReferralCoronerName,
			ReferralCoronerOrganization,
			ReferralCoronerPhone,
			REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralCoronerNote,
			Attending.PersonFirst AS AttendingFirst,
			Attending.PersonLast AS AttendingLast,
			Pronouncing.PersonFirst AS PronouncingFirst,
			Pronouncing.PersonLast AS PronouncingLast,
			AppropOrgan.AppropriateReportName AS AppropriateOrgan,
			ApproaOrgan.ApproachReportName AS ApproachOrgan,
			ConsentOrgan.ConsentReportName AS ConsentOrgan,
			RecoveryOrgan.ConversionReportName AS RecoveryOrgan,
			AppropBone.AppropriateReportName AS AppropriateBone,
			ApproaBone.ApproachReportName AS ApproachBone,
			ConsentBone.ConsentReportName AS ConsentBone,
			RecoveryBone.ConversionReportName AS RecoveryBone,
			AppropTissue.AppropriateReportName AS AppropriateTissue,
			ApproaTissue.ApproachReportName AS ApproachTissue,
			ConsentTissue.ConsentReportName AS ConsentTissue,
			RecoveryTissue.ConversionReportName AS RecoveryTissue,
			AppropSkin.AppropriateReportName AS AppropriateSkin,
			ApproaSkin.ApproachReportName AS ApproachSkin,
			ConsentSkin.ConsentReportName AS ConsentSkin,
			RecoverySkin.ConversionReportName AS RecoverySkin,
			AppropValve.AppropriateReportName AS AppropriateValves,
			ApproaValve.ApproachReportName AS ApproachValves,
			ConsentValve.ConsentReportName AS ConsentValve,
			RecoveryValve.ConversionReportName AS RecoveryValve,
			AppropEyes.AppropriateReportName AS AppropriateEyes,
			ApproaEyes.ApproachReportName AS ApproachEyes,
			ConsentEyes.ConsentReportName AS ConsentEyes,
			RecoveryEyes.ConversionReportName AS RecoveryEyes,
			'' AS 'blankfiel1',
			'' AS 'blankfiel2',
			'' AS 'blankfiel3',
			'' AS 'blankfiel4',
			ReferralCallerOrganizationID AS OrganizationID,
			ReferralGeneralConsent,
			ReferralApproachTime,
			ReferralConsentTime,
			ReferralSecondaryHistory,
			ReferralExtubated,
			AppropRsch.AppropriateReportName AS AppropriateOther,
			ApproaRsch.ApproachReportName AS ApproachOther,
			ConsentRsch.ConsentReportName AS ConsentOther,
			RecoveryRsch.ConversionReportName AS RecoveryOther,
			Referral.ReferralApproachTypeId,
			REPLACE(REPLACE(CallCustomField.CallCustomField1, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_1,
			REPLACE(REPLACE(CallCustomField.CallCustomField2, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_2,
			REPLACE(REPLACE(CallCustomField.CallCustomField3, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_3,
			REPLACE(REPLACE(CallCustomField.CallCustomField4, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_4,
			REPLACE(REPLACE(CallCustomField.CallCustomField5, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_5,
			REPLACE(REPLACE(CallCustomField.CallCustomField6, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_6,
			REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_7,
			REPLACE(REPLACE(CallCustomField.CallCustomField8, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_8,
			REPLACE(REPLACE(CallCustomField.CallCustomField9, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_9,
			REPLACE(REPLACE(CallCustomField.CallCustomField10, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_10,
			REPLACE(REPLACE(CallCustomField.CallCustomField11, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_11,
			REPLACE(REPLACE(CallCustomField.CallCustomField12, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_12,
			REPLACE(REPLACE(CallCustomField.CallCustomField13, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_13,
			REPLACE(REPLACE(CallCustomField.CallCustomField14, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_14,
			REPLACE(REPLACE(CallCustomField.CallCustomField15, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_15,
			REPLACE(REPLACE(CallCustomField.CallCustomField16, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_16,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15,
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16,
			CONVERT(VARCHAR(14), DATEADD(HOUR, 0, Referral.lastmodified), 1) + ' ' + CONVERT (VARCHAR(14), DATEADD(HOUR, 0, Referral.lastmodified), 108) AS 'ftplastmodified',
			Organization.OrganizationUserCode,
			ReferralDonorRaceID,
			ReferralDonorCauseOfDeathID,
			ReferralOrganAppropriateID,
			ReferralBoneAppropriateID,
			ReferralTissueAppropriateID,
			ReferralSkinAppropriateID,
			ReferralValvesAppropriateID,
			ReferralEyesTransAppropriateID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralOrganApproachID END AS ReferralOrganapproachID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralBoneApproachID END AS ReferralBoneapproachID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralTissueApproachID END AS ReferralTissueapproachID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralSkinApproachID END AS ReferralSkinapproachID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralValvesApproachID END AS ReferralValvesapproachID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralEyesTransApproachID END AS ReferralEyesTransapproachID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralOrganConsentID END AS ReferralOrgaConsentID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralBoneConsentID END AS ReferralBoneConsentID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralTissueConsentID END AS ReferralTissueConsentID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralSkinConsentID END AS ReferralSkinConsentID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralValvesConsentID END AS ReferralValvesConsentID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralEyesTransConsentID END AS ReferralEyesTransConsentID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralOrganConversionID END AS ReferralOrganConversionID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralBoneConversionID END AS ReferralBoneConversionID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralTissueConversionID END AS ReferralTissueConversionID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralSkinConversionID END AS ReferralSkinConversionID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralValvesConversionID END AS ReferralValvesConversionID,
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralEyesTransConversionID END AS ReferralEyesTransConversionID,
			ReferralOrganDispositionID,
			ReferralAllTissueDispositionID,
			ReferralEyesDispositionID,
			ReferralBoneDispositionID,
			ReferralTissueDispositionID,
			ReferralSkinDispositionID,
			ReferralValvesDispositionID,
			ReferralEyesRschAppropriateID,
			ReferralEyesRschApproachID,
			ReferralEyesRschConsentID,
			ReferralEyesRschConversionID,
			ReferralRschDispositionID,
			CAST(DATEPART(m, ReferralDOB) AS VARCHAR) + '/' + CAST(DATEPART(d, ReferralDOB) AS VARCHAR) + '/' + CAST(DATEPART(yyyy, ReferralDOB) AS VARCHAR) AS 'ReferralDOB',
			ReferralDonorSSN,
			CASE ReferralCoronersCASE WHEN -1 THEN 0 WHEN 0 THEN -1 END AS 'CoronoersCase',
			CTY.CountyName AS 'CoronerCounty',
			CAST(REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '')AS VARCHAR(255)) AS 'ReferralNotesCase2',
			ReferralDonorRecNumber AS 'ReferralDonorRecNumber2', 
			#extendedDetail2006_1.FTPCallDateTime,
			CASE WHEN LEN(Referral.ReferralCoronerOrganization) > 0 THEN CoronerST.StateAbbrv ELSE NULL END AS CoronerState,
			Referral.ReferralCoronerOrganization AS CoronerOrganization,
			Referral.ReferralCoronerName AS CoronerName,
			Referral.ReferralCoronerPhone AS CoronerPhone,
			REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS CoronerNote,
			Referral.ReferralNOKPhone AS NOKPhone,
			CASE WHEN ReferralNOKID IS NOT NULL THEN LEFT(REPLACE(REPLACE(Referral.ReferralNOKAddress + ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, CHAR(10), CHAR(32)), CHAR(13), ''), 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS NOKAddress2,
			RegistryStatus.RegistryStatus AS RegistryStatusID,
			CASE RegistryStatus.RegistryStatus WHEN 1 THEN 'Found on the State Registry' WHEN 2 THEN 'Found on the Web Registry' WHEN 3 THEN 'Not on the Registry' WHEN 4 THEN 'Manually Found' WHEN 5 THEN 'Not Checked' END AS RegistryStatus,
			Case Referral.ReferralDonorHeartBeat WHEN 1 Then 'Y' ELSE 'N' END AS PatientHasHeartbeat,
			CASE Referral.ReferralDOA WHEN -1 Then 'Y' ELSE 'N' END AS DOA,
			AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS AttendingPhysician,
			PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS PronouncingPhysician,
			FSCaseId,
			FSCaseCreateUserId,
			FSCaseCreateDateTime,
			FSCaseOpenUserId,
			FSCaseOpenDateTime,
			FSCaseSysEventsUserId,
			FSCaseSysEventsDateTime,
			FSCaseSecCompUserId,
			FSCaseSecCompDateTime,
			FSCaseApproachUserId,
			FSCaseApproachDateTime,
			FSCaseFinalUserId,
			FSCaseFinalDateTime,
			FSCaseUpdate,
			FSCaseUserId,
			FSCaseBillSecondaryUserID,
			FSCaseBillDateTime,
			FSCaseBillApproachUserID,
			FSCaseBillApproachDateTime,
			FSCaseBillMedSocUserID,
			FSCaseBillMedSocDateTime,
			SecondaryManualBillPersonId,
			SecondaryUpdatedFlag,
			FSCaseTotalTime,
			FSCaseSeconds,
			FSCaseBillFamUnavailUserId,
			FSCaseBillFamUnavailDateTime,
			FSCaseBillCryoFormUserId,
			FSCaseBillCryoFormDateTime,
			FSCaseBillApproachCount,
			FSCaseBillMedSocCount,
			FSCaseBillCryoFormCount,
			SecondaryWhoAreWe,
			SecondaryNOKaware,
			SecondaryFamilyConsent,
			SecondaryFamilyInterested,
			SecondaryNOKatHospital,
			SecondaryEstTimeSinceLeft,
			SecondaryTimeLeftInMT,
			SecondaryNOKNextDest,
			SecondaryNOKETA,
			SecondaryPatientMiddleName,
			SecondaryPatientHeightFeet,
			SecondaryPatientHeightInches,
			SecondaryPatientBMICalc,
			SecondaryPatientTOD1,
			SecondaryPatientTOD2,
			SecondaryPatientDeathType1,
			SecondaryPatientDeathType2,
			SecondaryTriageHX,
			REPLACE(REPLACE(SecondaryCircumstanceOfDeath, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCircumstanceOfDeath,
			REPLACE(REPLACE(SecondaryMedicalHistory, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryMedicalHistory,
			SecondaryAdmissionDiagnosis,
			SecondaryCOD,
			SecondaryCODSignatory,
			SecondaryCODTime,
			SecondaryCODSignedBy,
			SecondaryPatientVent,
			SecondaryIntubationDate,
			SecondaryIntubationTime,
			SecondaryBrainDeathDate,
			SecondaryBrainDeathTime,
			SecondaryDNRDate,
			SecondaryERORDeath,
			SecondaryEMSArrivalToPatientDate,
			SecondaryEMSArrivalToPatientTime,
			SecondaryEMSArrivalToHospitalDate,
			SecondaryEMSArrivalToHospitalTime,
			SecondaryPatientTerminal,
			SecondaryDeathWitnessed,
			SecondaryDeathWitnessedBy,
			SecondaryLSADate,
			SecondaryLSATime,
			SecondaryLSABy,
			SecondaryACLSProvided,
			SecondaryACLSProvidedTime,
			SecondaryGestationalAge,
			SecondaryParentName1,
			SecondaryParentName2,
			SecondaryBirthCBO,
			SecondaryActiveInfection,
			SecondaryActiveInfectionType,
			SecondaryFluidsGiven,
			SecondaryBloodLoss,
			SecondarySignOfInfection,
			SecondaryMedication,
			SecondaryAntibiotic,
			SecondaryPCPName,
			SecondaryPCPPhone,
			SecondaryMDAttending,
			SecondaryMDAttendingPhone,
			REPLACE(REPLACE(SecondaryPhysicalAppearance, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryPhysicalAppearance,
			SecondaryInternalBloodLossCC,
			SecondaryExternalBloodLossCC,
			SecondaryBloodProducts,
			SecondaryColloidsInfused,
			SecondaryCrystalloids,
			SecondaryPreTransfusionSampleRequired,
			SecondaryPreTransfusionSampleAvailable,
			SecondaryPreTransfusionSampleDrawnDate,
			SecondaryPreTransfusionSampleDrawnTime,
			SecondaryPreTransfusionSampleQuantity,
			SecondaryPreTransfusionSampleHeldAt,
			SecondaryPreTransfusionSampleHeldDate,
			SecondaryPreTransfusionSampleHeldTime,
			SecondaryPreTransfusionSampleHeldTechnician,
			SecondaryPostMordemSampleTestSuitable,
			SecondaryPostMordemSampleLocation,
			SecondaryPostMordemSampleContact,
			SecondaryPostMordemSampleCollectionDate,
			SecondaryPostMordemSampleCollectionTime,
			REPLACE(REPLACE(SecondarySputumCharacteristics, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondarySputumCharacteristics,
			SecondaryNOKAltPhone,
			SecondaryNOKLegal,
			SecondaryNOKAltContact,
			SecondaryNOKAltContactPhone,
			SecondaryNOKPostMortemAuthorization,
			SecondaryNOKPostMortemAuthorizationReminder,
			SecondaryCoronerCaseNumber,
			SecondaryCoronerCounty,
			SecondaryCoronerReleased,
			REPLACE(REPLACE(SecondaryCoronerReleasedStipulations, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCoronerReleasedStipulations,
			SecondaryAutopsy,
			SecondaryAutopsyDate,
			SecondaryAutopsyTime,
			SecondaryAutopsyLocation,
			SecondaryAutopsyBloodRequested,
			SecondaryAutopsyCopyRequested,
			SecondaryFuneralHomeSelected,
			SecondaryFuneralHomeName,
			SecondaryFuneralHomePhone,
			SecondaryFuneralHomeAddress,
			SecondaryFuneralHomeContact,
			SecondaryFuneralHomeNotified,
			SecondaryFuneralHomeMorgueCooled,
			SecondaryHoldOnBody,
			SecondaryHoldOnBodyTag,
			SecondaryBodyRefrigerationDate,
			SecondaryBodyRefrigerationTime,
			SecondaryBodyLocation,
			SecondaryBodyMedicalChartLocation,
			SecondaryBodyIDTagLocation,
			SecondaryBodyCoolingMethod,
			SecondaryUNOSNumber,
			SecondaryClientNumber,
			SecondaryCryolifeNumber,
			SecondaryMTFNumber,
			SecondaryLifeNetNumber,
			REPLACE(REPLACE(SecondaryFreeText, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryFreeText,
			SecondaryHistorySubstanceAbuse,
			SecondarySubstanceAbuseDetail,
			SecondaryExtubationDate,
			SecondaryExtubationTime,
			SecondaryAutopsyReminderYN,
			SecondaryFHReminderYN,
			SecondaryBodyCareReminderYN,
			SecondaryWrapUpReminderYN,
			SecondaryNOKNotifiedBy,
			SecondaryNOKNotifiedDate,
			SecondaryNOKNotifiedTime,
			SecondaryNOKGender,
			SecondaryCODOther,
			SecondaryAutopsyLocationOther,
			SecondaryPatientHospitalPhone,
			SecondaryCoronerCase,
			SecondaryPatientABO,
			SecondaryPatientSuffix,
			SecondaryMDAttendingId,
			REPLACE(REPLACE(SecondaryAdditionalComments, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryAdditionalComments,
			SecondaryRhythm,
			REPLACE(REPLACE(SecondaryAdditionalMedications, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryAdditionalMedications,
			SecondaryBodyHoldPlaced,
			SecondaryBodyHoldPlacedWith,
			SecondaryBodyFutureContact,
			SecondaryBodyHoldPhone,
			SecondaryBodyHoldInstructionsGiven,
			SecondarySteroid,
			SecondaryBodyHoldPlacedTime,
			SecondaryAntibiotic1Name,
			SecondaryAntibiotic1Dose,
			SecondaryAntibiotic1StartDate,
			SecondaryAntibiotic1EndDate,
			SecondaryAntibiotic2Name,
			SecondaryAntibiotic2Dose,
			SecondaryAntibiotic2StartDate,
			SecondaryAntibiotic2EndDate,
			SecondaryAntibiotic3Name,
			SecondaryAntibiotic3Dose,
			SecondaryAntibiotic3StartDate,
			SecondaryAntibiotic3EndDate,
			SecondaryAntibiotic4Name,
			SecondaryAntibiotic4Dose,
			SecondaryAntibiotic4StartDate,
			SecondaryAntibiotic4EndDate,
			SecondaryAntibiotic5Name,
			SecondaryAntibiotic5Dose,
			SecondaryAntibiotic5StartDate,
			SecondaryAntibiotic5EndDate,
			SecondaryBloodProductsReceived1Type,
			SecondaryBloodProductsReceived1Units,
			SecondaryBloodProductsReceived1TypeCC,
			SecondaryBloodProductsReceived1TypeUnitGiven,
			SecondaryBloodProductsReceived2Type,
			SecondaryBloodProductsReceived2Units,
			SecondaryBloodProductsReceived2TypeCC,
			SecondaryBloodProductsReceived2TypeUnitGiven,
			SecondaryBloodProductsReceived3Type,
			SecondaryBloodProductsReceived3Units,
			SecondaryBloodProductsReceived3TypeCC,
			SecondaryBloodProductsReceived3TypeUnitGiven,
			SecondaryColloidsInfused1Type,
			SecondaryColloidsInfused1Units,
			SecondaryColloidsInfused1CC,
			SecondaryColloidsInfused1UnitGiven,
			SecondaryColloidsInfused2Type,
			SecondaryColloidsInfused2Units,
			SecondaryColloidsInfused2CC,
			SecondaryColloidsInfused2UnitGiven,
			SecondaryColloidsInfused3Type,
			SecondaryColloidsInfused3Units,
			SecondaryColloidsInfused3CC,
			SecondaryColloidsInfused3UnitGiven,
			SecondaryCrystalloids1Type,
			SecondaryCrystalloids1Units,
			SecondaryCrystalloids1CC,
			SecondaryCrystalloids1UnitGiven,
			SecondaryCrystalloids2Type,
			SecondaryCrystalloids2Units,
			SecondaryCrystalloids2CC,
			SecondaryCrystalloids2UnitGiven,
			SecondaryCrystalloids3Type,
			SecondaryCrystalloids3Units,
			SecondaryCrystalloids3CC,
			SecondaryCrystalloids3UnitGiven,
			SecondaryWBC1Date,
			SecondaryWBC1,
			SecondaryWBC1Bands,
			SecondaryWBC2Date,
			SecondaryWBC2,
			SecondaryWBC2Bands,
			SecondaryWBC3Date,
			SecondaryWBC3,
			SecondaryWBC3Bands,
			SecondaryLabTemp1,
			SecondaryLabTemp1Date,
			SecondaryLabTemp1Time,
			SecondaryLabTemp2,
			SecondaryLabTemp2Date,
			SecondaryLabTemp2Time,
			SecondaryLabTemp3,
			SecondaryLabTemp3Date,
			SecondaryLabTemp3Time,
			SecondaryCulture1Type,
			SecondaryCulture1Other,
			SecondaryCulture1DrawnDate,
			SecondaryCulture1Growth,
			SecondaryCulture2Type,
			SecondaryCulture2Other,
			SecondaryCulture2DrawnDate,
			SecondaryCulture2Growth,
			SecondaryCulture3Type,
			SecondaryCulture3Other,
			SecondaryCulture3DrawnDate,
			SecondaryCulture3Growth,
			SecondaryCXRAvailable,
			SecondaryCXR1Date,
			REPLACE(REPLACE(SecondaryCXR1Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR1Finding,
			SecondaryCXR2Date,
			REPLACE(REPLACE(SecondaryCXR2Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR2Finding,
			SecondaryCXR3Date,
			REPLACE(REPLACE(SecondaryCXR3Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR3Finding,
			SecondaryAntibiotic1NameOther,
			SecondaryAntibiotic2NameOther,
			SecondaryAntibiotic3NameOther,
			SecondaryAntibiotic4NameOther,
			SecondaryAntibiotic5NameOther,
			SecondaryBloodProductsReceived1TypeOther,
			SecondaryBloodProductsReceived2TypeOther,
			SecondaryBloodProductsReceived3TypeOther,
			SecondaryColloidsInfused1TypeOther,
			SecondaryColloidsInfused2TypeOther,
			SecondaryColloidsInfused3TypeOther,
			SecondaryCrystalloids1TypeOther,
			SecondaryCrystalloids2TypeOther,
			SecondaryCrystalloids3TypeOther,
			SecondaryApproached,
			SecondaryApproachedBy,
			SecondaryApproachType,
			SecondaryApproachOutcome,
			SecondaryApproachReason,
			SecondaryConsented,
			SecondaryConsentBy,
			SecondaryConsentOutcome,
			SecondaryConsentResearch,
			SecondaryRecoveryLocation,
			SecondaryHospitalApproach,
			SecondaryHospitalApproachedBy,
			SecondaryHospitalOutcome,
			SecondaryConsentMedSocPaperwork,
			SecondaryConsentMedSocObtainedBy,
			SecondaryConsentFuneralPlans,
			SecondaryConsentFuneralPlansOther,
			SecondaryConsentLongSleeves,
			Referral.LastModified,
			CASE Referral.ReferralDOB_ILB WHEN -1 THEN  1 ELSE 0 END AS ReferralDonor_ILB,
			Referral.ReferralDonorSpecificCOD,
			CONVERT(VARCHAR, Referral.ReferralDonorBrainDeathDate, 1) AS 'ReferralDonorBrainDeathDate',
			Referral.ReferralDonorBrainDeathTime,
			Referral.ReferralAttendingMDPhone,
			Referral.ReferralPronouncingMDPhone,
			Referral.CurrentReferralTypeID,
			Referral.ReferralNotesCase AS MedicalHistory,
			NOK.NOKFirstName,
			NOK.NOKLastName,
			NOK.NOKCity,
			ST.StateAbbrv AS NOKState,
			NOK.NOKZip,
			Referral.ReferralDonorNameMI ,
			'' AS CoronorsCase,
			REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralNOKAddress3,
			Referral.ReferralDonorWeight AS PatientWeight_Decimal,
			SecondaryTBINumber,
			CASE WHEN SecondaryTBIAssignmentNotNeeded = -1 THEN 0 ELSE -1 END AS 'SecondaryT',
			SecondaryTBIComment 
		INTO #extendedDetail2006_2
		FROM #extendedDetail2006_1
			LEFT JOIN Referral ON Referral.CallID = #extendedDetail2006_1.CallID
			LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
			LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
			LEFT JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID 
			LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
			LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID 
			LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD 
			LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD 
			LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID 
			LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
			LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID 
			LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
			LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID 
			LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID 
			LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
			LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID 
			LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID 
			LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID 
			LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
			LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID 
			LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID 
			LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID 
			LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
			LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID 
			LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID 
			LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
			LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID 
			LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID 
			LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID 
			LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID 
			LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID 
			LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID 
			LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID 
			LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID 
			LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID 
			LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID 
			LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID 
			LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
			LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
			LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
			LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
			LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
			LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID 
			LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID 
			LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID 
			LEFT JOIN CallCriteria ON CallCriteria.CallID = Referral.CallID 
			LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CallCriteria.ServiceLevelID 
			LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = #extendedDetail2006_1.SourceCodeID 
			LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
			LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID 
			LEFT JOIN Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD 
			LEFT JOIN Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD 
			LEFT JOIN Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCoronerOrgID 
			LEFT JOIN State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID 
			LEFT JOIN Secondary on Secondary.CallID = Referral.CallID 
			LEFT JOIN Secondary2 on Secondary2.CallID = Referral.CallID 
			LEFT JOIN SecondaryApproach on SecondaryApproach.CallID = Referral.CallID 
			LEFT JOIN FSCase on FSCase.CallID = Referral.CallID 
			LEFT JOIN NOK on Referral.ReferralNOKID = NOK.NOKID 
			LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID 
			LEFT JOIN COUNTY CTY ON CTY.CountyID = CoronerOrg.CountyID  
			LEFT JOIN SecondaryTBI ON Referral.CallID = SecondaryTBI.CallID 
		WHERE
			--AND (
				(@CallID IS NULL 
					AND (@WebReportGroupID IS NULL OR @WebReportGroupID = 0 OR WebReportGroupOrg.WebReportGroupID = @WebReportGroupID)
					AND (@ReferralTypeID IS NULL OR Referral.ReferralTypeID = @ReferralTypeID)
					AND (@OrganizationIDCaller IS NULL OR @OrganizationIDCaller = 0 OR Referral.ReferralCallerOrganizationID = @OrganizationIDCaller))
				OR (@CallID IS NOT NULL
					AND (@OrganizationIDParent IS NULL
						OR ((@OrganizationIDParent <> 194 AND WebReportGroup.OrgHierarchyParentID = @OrganizationIDParent))));
				--);

	DROP TABLE IF EXISTS #extendedDetail2006_1; --sql2016 syntax

	SELECT *
	FROM (SELECT DISTINCT * FROM #extendedDetail2006_2) AS t
	ORDER BY 
		CASE WHEN @OrderBy = 'CallDateTime' THEN t.CallDateTime
		END DESC,
		CASE WHEN @OrderBy = 'OrganizationName' THEN t.OrganizationName
			WHEN @OrderBy = 'ReferralDonorLastName' THEN t.ReferralDonorLastName
		END DESC,
		CASE WHEN @OrderBy = 'Referral.ReferralTypeID' THEN t.ReferralTypeID
			WHEN @OrderBy = 'Referral.ReferralApproachTypeId' THEN t.ReferralApproachTypeId
			ELSE t.CallID
		END DESC;

	DROP TABLE IF EXISTS #extendedDetail2006_1; --sql2016 syntax
	DROP TABLE IF EXISTS #extendedDetail2006_2;
	DROP TABLE IF EXISTS #sourceCodes;
	
GO

GRANT EXEC ON sps_rpt_ReferralDetail_Extended_2006_Select TO PUBLIC;
GO
GO
