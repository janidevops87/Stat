IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_ReferralDetail_Ftp')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralDetail_Ftp';
		DROP Procedure sps_rpt_ReferralDetail_Ftp;
	END
GO

PRINT 'Creating Procedure sps_rpt_ReferralDetail_Ftp';
GO
CREATE Procedure sps_rpt_ReferralDetail_Ftp
(
		@CallID					INT	= NULL,
		@OrganizationID			INT = NULL,
		@UserOrgID				INT = NULL,
		@WebReportGroupID		INT = NULL,
		@ReferralTypeID			INT = NULL,
		@CallDateTimeStart		DATETIME = NULL,
		@CallDateTimeEnd		DATETIME = NULL,
		@OrderBy				VARCHAR(MAX) = NULL
)
AS
/******************************************************************************
**	File: sps_rpt_ReferralDetail_Ftp.sql
**	Name: sps_rpt_ReferralDetail_Ftp
**	Desc: Selects Referral Report Data using the StatTrac Data Export Spec
**	Auth: Mike Berenson
**	Date: 6/15/2020
**	Called By: ReferralDetail_Ftp.rdl
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	6/15/2020		Mike Berenson			Initial Sproc Creation
**	12/03/2020		Mike Berenson			Updated parameters to streamline implementation in website
**	06/21/2021		Mike Berenson			Set order by to asc for CallDateTime, OrganizationName & ReferralDonorLastName
**	07/25/2021		Mike Berenson			Added TimeZoneOffset logic to output of ReferralDateTime
**	07/06/2021		Mike Berenson			Updated order by logic to default to CallDateTime ASC
**	08/17/2021		Mike Berenson			Updated order by logic to better handle mixed types
**	08/18/2021		Mike Berenson			Rolled back TimeZoneOffset logic added on 7/25/2021
**	08/19/2021		Mike Berenson			Applied Converted/Filtered logic from sps_rpt_ReferralDetail.sql where we assume
**												the start/end datetime (parameter) is in timezone of logged in user's organization
**	08/23/2021		Mike Berenson			Separated declaration from assignment for @TimeZoneOffset
**	08/24/2021		Mike Berenson			Load #sourceCodes with call to fn_SourceCodeList
*******************************************************************************/
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;
	DROP TABLE IF EXISTS #UnsortedResults;

	DECLARE	
		@AdjustedReferralStartDateTime	SMALLDATETIME	= DATEADD(D, -1, @CallDateTimeStart),
		@AdjustedReferralEndDateTime	SMALLDATETIME	= DATEADD(D, +1, @CallDateTimeEnd),
		@OrganizationTimeZone			VARCHAR(2)		= dbo.fn_GetOrganizationTimeZone (@UserOrgID),
		@TimeZoneOffset					INT				= 0;

	-- Determine the ActivityDate so we can use it to get the TimeZoneOffset
	DECLARE @ActivityDate AS DATETIME;
	IF @CallID IS NULL OR @CallID = 0
	BEGIN
		-- If we don't have a CallID, use the StartDate
		SET @ActivityDate = @CallDateTimeStart;
	END
	ELSE
	BEGIN
		-- If we have a CallID, use it's CallDateTime
		SELECT @ActivityDate = CallDateTime 
		FROM [Call]
		WHERE CallID = @CallID;	
	END

	-- Determine TimeZoneOffset
	SELECT @TimeZoneOffset = dbo.fn_TimeZoneDifference (@OrganizationTimeZone, @ActivityDate);

	-- Show Statline employees data for all orgs
	SELECT @UserOrgID = CASE WHEN @UserOrgID = 194 THEN NULL ELSE @UserOrgID END;

	-- Load #sourceCodes	
	SELECT SourceCodeID
	INTO #sourceCodes
	FROM dbo.fn_SourceCodeList(@WebReportGroupID, NULL);

	-- Load #ConvertedCalls with timezone adjusted times
	SELECT 
		c.CallID,
		c.CallNumber,
		DATEADD(HOUR, @TimeZoneOffset, c.CallDateTime) AS 'CallDateTime',
		c.SourceCodeID,
		c.StatEmployeeID
	INTO #ConvertedCalls
	FROM
		[Call] c
		INNER JOIN #sourceCodes sc ON sc.SourceCodeID = c.SourceCodeId
	WHERE
		(
			@CallID IS NULL	
			AND c.CallDateTime >= @AdjustedReferralStartDateTime
			AND c.CallDateTime <= @AdjustedReferralEndDateTime
		) 
		OR c.CallID = @CallID;

	-- Load #FilteredCalls	
	SELECT
		c.CallID, 
		c.CallNumber, 
		c.CallDateTime,
		sp.PersonFirst AS 'StatPersonFirstName',
		sp.PersonLast AS 'StatPersonLastName',
		c.SourceCodeID,
		sc.SourceCodeName,
		CONVERT(VARCHAR(14), c.CallDateTime, 1) + ' ' + CONVERT(VARCHAR(14), c.CallDateTime, 108) AS 'FTPCallDateTime'
	INTO #FilteredCalls
	FROM #ConvertedCalls c
		LEFT JOIN SourceCode sc ON sc.SourceCodeID = c.SourceCodeID 
		LEFT JOIN StatEmployee se ON se.StatEmployeeID = c.StatEmployeeID 
		LEFT JOIN Person sp ON sp.PersonID = se.PersonID 
		LEFT JOIN Person p ON p.PersonID = se.PersonID 
		LEFT JOIN PersonType pt ON pt.PersonTypeID = p.PersonTypeID
		LEFT JOIN #sourceCodes sct ON sct.SourceCodeID = c.SourceCodeID
	WHERE	
		(
			(
				@CallID IS NULL 
				AND (@CallDateTimeStart IS NULL OR c.CallDateTime >= @CallDateTimeStart)
				AND (@CallDateTimeEnd IS NULL OR c.CallDateTime <= @CallDateTimeEnd)
			)
			OR c.CallID = @CallID
		)
		AND (@UserOrgID IS NULL OR sc.SourceCodeID IS NOT NULL);

	SELECT 	
			-- Referral Data (fields 1-9)
			FORMAT(DATEADD(HOUR, @TimeZoneOffset, Referral.lastmodified), 'M/d/yyyy') + ' ' + FORMAT(DATEADD(HOUR, @TimeZoneOffset, Referral.lastmodified), 'HH:mm:ss') AS 'LastModified',
			Referral.ReferralID,  
			fc.CallNumber AS 'ReferralNumber',
			FORMAT(fc.CallDateTime, 'M/d/yyyy') + ' ' + FORMAT(fc.CallDateTime, 'HH:mm:ss') AS 'ReferralDateTime',
			fc.StatPersonFirstName + ' ' + fc.StatPersonLastName AS 'ReferralTakenBy',
			Referral.ReferralTypeID,
			ReferralTypeName AS 'ReferralType',
			'1' AS 'ReferralStatusID',
			'Complete' AS 'ReferralStatus',

			-- Caller Data (fields 10-16)
			'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone' ,
			ReferralCallerExtension AS 'CallerExtension',
			CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'CallerName',
			CallPersonType.PersonTypeName AS 'CallerTitle',
			Organization.ProviderNumber AS 'CallerOrganizationCode',
			Organization.OrganizationName AS 'CallerOrganization',
			CASE WHEN ReferralCallerSubLocationLevel IS NULL THEN SubLocationName ELSE SubLocationName + ' ' + ReferralCallerSubLocationLevel END AS 'CallerOrganizationUnit',

			-- Patient Data (fields 17-35)
			ReferralDonorFirstName AS 'PatientFirstName',
			ReferralDonorLastName AS 'PatientLastName',
			ReferralDonorRecNumber AS 'PatientRecordNumber', 
			ReferralDonorAge AS 'PatientAge',
			ReferralDonorAgeUnit AS 'PatientAgeUnit',
			ReferralDonorRaceID AS 'PatientRaceID',
			RaceName AS 'PatientRace',			
			ReferralDonorGender AS 'PatientGender',
			CAST(CAST(REPLACE(ReferralDonorWeight,',','') AS NUMERIC)AS VARCHAR) AS 'PatientWeight',
			ReferralDonorCauseOfDeathID AS 'PatientCauseOfDeathID',
			CauseOfDeathName AS 'PatientCauseOfDeath',			
			CAST(REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '')AS VARCHAR(255)) AS 'PatientStandardMRO',
			'0' AS 'Unused1',
			CONVERT(CHAR(8),ReferralDonorAdmitDate,1) AS 'PatientAdmitDate',
			ReferralDonorAdmitTime AS 'PatientAdmitTime',
			ReferralDonorOnVentilator AS 'PatientOnVentilator',
			'0' AS 'Unused2',
			CONVERT(CHAR(8),ReferralDonorDeathDate,1) AS 'PatientDeathDate',
			ReferralDonorDeathTime AS 'PatientDeathTime',

			-- Overall Approach Data (fields 36-40)
			Referral.ReferralApproachTypeId AS 'ApproachTypeID',
			ApproachTypeName AS 'ApproachType',
			ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachedBy',
			CASE WHEN ReferralNOKID IS NOT NULL THEN LEFT(REPLACE(REPLACE(NOK.NOKFirstName + ' ' + NOK.NOKLastName,CHAR(10), CHAR(32)), CHAR(13), ''),50) ELSE ReferralApproachNOK END AS 'ApproachNOK',
			CASE WHEN ReferralNOKID IS NOT NULL THEN NOK.NOKApproachRelation ELSE ReferralApproachRelation END AS 'ApproachNOKRelation',

			-- Appropriateness Data - Option Specific (fields 41-46)
			ReferralOrganAppropriateID AS 'AppropriateOrganID',
			ReferralBoneAppropriateID AS 'AppropriateBoneID',
			ReferralTissueAppropriateID AS 'AppropriateSoftTissueID',
			ReferralSkinAppropriateID AS 'AppropriateSkinID',
			ReferralValvesAppropriateID AS 'AppropriateValvesID',
			ReferralEyesTransAppropriateID AS 'AppropriateEyesID',

			-- Approach Data - Option Specific (fields 47-52)
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralOrganApproachID END AS 'ApproachedOrganID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralBoneApproachID END AS 'ApproachedBoneID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralTissueApproachID END AS 'ApproachedSoftTissueID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralSkinApproachID END AS 'ApproachedSkinID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralValvesApproachID END AS 'ApproachedValvesID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralEyesTransApproachID END AS 'ApproachedEyesID',
			
			-- Consent Data - Option Specific (fields 53-58)
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralOrganConsentID END AS 'ConsentedOrganID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralBoneConsentID END AS 'ConsentedBoneID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralTissueConsentID END AS 'ConsentedSoftTissueID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralSkinConsentID END AS 'ConsentedSkinID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralValvesConsentID END AS 'ConsentedValvesID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralEyesTransConsentID END AS 'ConsentedEyesID',

			-- Recovery Data - Option Specific (fields 59-64)			
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralOrganConversionID END AS 'RecoveredOrganID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralBoneConversionID END AS 'RecoveredBoneID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralTissueConversionID END AS 'RecoveredSoftTissueID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralSkinConversionID END AS 'RecoveredSkinID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralValvesConversionID END AS 'RecoveredValvesID',
			CASE WHEN dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 THEN -1 ELSE ReferralEyesTransConversionID END AS 'RecoveredEyesID',
			
			-- Disposition Summary Data - (fields 65-71)
			ReferralOrganDispositionID AS 'OrganDispositionID',
			ReferralAllTissueDispositionID AS 'AllTissueDispositionID',
			ReferralEyesDispositionID AS 'EyeDispositionID',
			ReferralBoneDispositionID AS 'BoneDispositionID',
			ReferralTissueDispositionID AS 'SoftTissueDispositionID',
			ReferralSkinDispositionID AS 'SkinDispositionID',
			ReferralValvesDispositionID AS 'ValvesDispositionID',		
						
			-- Additional Misc. Data (fields 72-73)
			ReferralGeneralConsent AS 'GeneralConsent',
			ReferralExtubated,

			-- Extended Referral Data (fields 74-77)
			CAST(DATEPART(m, ReferralDOB) AS VARCHAR) + '/' + CAST(DATEPART(d, ReferralDOB) AS VARCHAR) + '/' + CAST(DATEPART(yyyy, ReferralDOB) AS VARCHAR) AS 'DOB',
			ReferralDonorSSN AS 'DonorSSN',
			CASE ReferralCoronersCASE WHEN -1 THEN 0 WHEN 0 THEN -1 END AS 'CoronersCase',
			CTY.CountyName AS 'CoronerCounty',

			-- Other Field Data (fields 78-82)
			ReferralEyesRschAppropriateID AS 'AppropriateOtherID',
			ReferralEyesRschApproachID AS 'AppoachedOtherID',
			ReferralEyesRschConsentID AS 'ConsentedOtherID',
			ReferralEyesRschConversionID AS 'RecoveredOtherID',
			ReferralRschDispositionID AS 'OtherDispositionID',

			-- Custom Data Fields (fields 83-98)
			REPLACE(REPLACE(CallCustomField.CallCustomField1, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_1',
			REPLACE(REPLACE(CallCustomField.CallCustomField2, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_2',
			REPLACE(REPLACE(CallCustomField.CallCustomField3, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_3',
			REPLACE(REPLACE(CallCustomField.CallCustomField4, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_4',
			REPLACE(REPLACE(CallCustomField.CallCustomField5, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_5',
			REPLACE(REPLACE(CallCustomField.CallCustomField6, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_6',
			REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_7',
			REPLACE(REPLACE(CallCustomField.CallCustomField8, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_8',
			REPLACE(REPLACE(CallCustomField.CallCustomField9, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_9',
			REPLACE(REPLACE(CallCustomField.CallCustomField10, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_10',
			REPLACE(REPLACE(CallCustomField.CallCustomField11, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_11',
			REPLACE(REPLACE(CallCustomField.CallCustomField12, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_12',
			REPLACE(REPLACE(CallCustomField.CallCustomField13, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_13',
			REPLACE(REPLACE(CallCustomField.CallCustomField14, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_14',
			REPLACE(REPLACE(CallCustomField.CallCustomField15, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_15',
			REPLACE(REPLACE(CallCustomField.CallCustomField16, CHAR(10), CHAR(32)), CHAR(13), '') AS 'customField_16',

			-- Custom Data Labels (fields 99-114)
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS 'ServiceLevelCustomFieldLabel_1',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS 'ServiceLevelCustomFieldLabel_2',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS 'ServiceLevelCustomFieldLabel_3',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS 'ServiceLevelCustomFieldLabel_4',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS 'ServiceLevelCustomFieldLabel_5',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS 'ServiceLevelCustomFieldLabel_6',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS 'ServiceLevelCustomFieldLabel_7',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS 'ServiceLevelCustomFieldLabel_8',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS 'ServiceLevelCustomFieldLabel_9',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS 'ServiceLevelCustomFieldLabel_10',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS 'ServiceLevelCustomFieldLabel_11',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS 'ServiceLevelCustomFieldLabel_12',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS 'ServiceLevelCustomFieldLabel_13',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS 'ServiceLevelCustomFieldLabel_14',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS 'ServiceLevelCustomFieldLabel_15',
			ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS 'ServiceLevelCustomFieldLabel_16',

			-- Extended Referral Data 2004 (fields 115-127)
			CASE WHEN LEN(Referral.ReferralCoronerOrganization) > 0 THEN CoronerST.StateAbbrv ELSE NULL END AS 'CoronerState',
			Referral.ReferralCoronerOrganization AS 'CoronerOrganization',
			Referral.ReferralCoronerName AS 'CoronerName',
			Referral.ReferralCoronerPhone AS 'CoronerPhone',
			REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS 'CoronerNote',
			Referral.ReferralNOKPhone AS 'ApproachNOKPhone',
			CASE WHEN ReferralNOKID IS NOT NULL THEN LEFT(REPLACE(REPLACE(Referral.ReferralNOKAddress + ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, CHAR(10), CHAR(32)), CHAR(13), ''), 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS 'ApproachNOKAddress',
			RegistryStatus.RegistryStatus AS 'RegistryStatusID',
			CASE RegistryStatus.RegistryStatus WHEN 1 THEN 'Found on the State Registry' WHEN 2 THEN 'Found on the Web Registry' WHEN 3 THEN 'Not on the Registry' WHEN 4 THEN 'Manually Found' WHEN 5 THEN 'Not Checked' END AS 'RegistryStatus',
			Case Referral.ReferralDonorHeartBeat WHEN 1 Then 'Y' ELSE 'N' END AS 'PatientHasHeartbeat',
			CASE Referral.ReferralDOA WHEN -1 Then 'Y' ELSE 'N' END AS 'DOA',
			AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS 'AttendingPhysician',
			PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS 'PronouncingPhysician',

			-- Extended Referral Family Services Data (subset - using fields 128-148)
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

			-- Order By Fields
			fc.CallID,
			fc.CallDateTime

		INTO #UnsortedResults
		FROM #FilteredCalls fc
			LEFT JOIN Referral ON Referral.CallID = fc.CallID
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
			LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID 
			LEFT JOIN CallCriteria ON CallCriteria.CallID = Referral.CallID 
			LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CallCriteria.ServiceLevelID 
			LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = fc.SourceCodeID 
			LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
			LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID 
			LEFT JOIN Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD 
			LEFT JOIN Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD 
			LEFT JOIN Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCoronerOrgID 
			LEFT JOIN State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID 
			LEFT JOIN FSCase on FSCase.CallID = Referral.CallID 
			LEFT JOIN NOK on Referral.ReferralNOKID = NOK.NOKID 
			LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID 
			LEFT JOIN COUNTY CTY ON CTY.CountyID = CoronerOrg.CountyID  
		WHERE
			(@CallID IS NULL 
				AND (@WebReportGroupID IS NULL OR @WebReportGroupID = 0 OR WebReportGroupOrg.WebReportGroupID = @WebReportGroupID)
				AND (@ReferralTypeID IS NULL OR Referral.ReferralTypeID = @ReferralTypeID)
				AND (@OrganizationID IS NULL OR @OrganizationID = 0 OR Referral.ReferralCallerOrganizationID = @OrganizationID))
			OR (@CallID IS NOT NULL
				AND (@UserOrgID IS NULL
					OR WebReportGroup.OrgHierarchyParentID = @UserOrgID));

	SELECT *
	FROM (SELECT DISTINCT *, 
				CONVERT(VARCHAR(19), CallDateTime, 20)	AS 'CallDateTimeString',
				CONVERT(VARCHAR(10), ReferralTypeID)	AS 'ReferralTypeIdString',
				CONVERT(VARCHAR(10), ApproachTypeID)	AS 'ReferralApproachTypeIdString'
			FROM #UnsortedResults) AS t
	ORDER BY 
		CASE	
			WHEN @OrderBy = 'CallDateTime' THEN t.CallDateTimeString
			WHEN @OrderBy = 'OrganizationName' THEN t.CallerOrganization
			WHEN @OrderBy = 'ReferralDonorLastName' THEN t.PatientLastName
			WHEN @OrderBy = 'ReferralTypeID' THEN t.ReferralTypeIdString
			WHEN @OrderBy = 'ReferralApproachTypeId' THEN t.ReferralApproachTypeIdString				
			ELSE t.CallDateTimeString
		END ASC;

	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;
	DROP TABLE IF EXISTS #UnsortedResults;
END	
GO

GRANT EXEC ON sps_rpt_ReferralDetail_Ftp TO PUBLIC;
GO