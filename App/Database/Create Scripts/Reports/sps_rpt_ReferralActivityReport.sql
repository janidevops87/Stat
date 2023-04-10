IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralActivityReport')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralActivityReport';
		DROP  PROCEDURE  sps_rpt_ReferralActivityReport;
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralActivityReport';
GO


CREATE Procedure sps_rpt_ReferralActivityReport
(
	@CallID					INT				= NULL,
	@DateType				INT = 1,					-- 2 = CardiacDateTime (Referral.ReferralDonorDeathDate), 1 = ReferralDateTime(Call.CallDateTime)
	@StartDateTime			SMALLDATETIME	= NULL,
	@EndDateTime			SMALLDATETIME	= NULL,
	@PatientFirstName		VARCHAR(40)		= NULL,
	@PatientLastName		VARCHAR(40)		= NULL,
	@MedicalRecordNumber	VARCHAR(30)		= NULL,
	@ReferralType			INT				= NULL,		
	@ReportGroupID			INT				= NULL,
	@OrganizationID			INT				= NULL,
	@SourceCodeName			VARCHAR(10)		= NULL,
	@CoordinatorID			INT				= NULL,
	@LowerAgeLimit			INT				= NULL,
	@UpperAgeLimit			INT				= NULL,
	@Gender					VARCHAR(1)		= NULL,
	@UserOrgID				INT				= NULL,
	@UserID					INT				= NULL,
	@DisplayMT				INT				= NULL
)
AS
/******************************************************************************
**		File: sps_rpt_ReferralActivityReport.sql
**		Name: sps_rpt_ReferralActivityReport
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 08/27/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      08/30/2007		ccarroll			Initial release
**		11/15/2007		ccarroll			Added FN for ConvertDateTime
**		06/2008 		jth					fix cardiac/referral date selection, create groupby field, 
**											remove unneeded columns,fixed join to get alert group
**		09/30/2008		ccarroll			Added selection for Archive data
**      04/2009         jth                 changed BasedOnDT to BasedOnDT1 to handle sorting in report
**      04/2009         jth                 fixed handling of null age limits
**		04/04/2012		ccarroll			HS 31129 Duplicate referrals: Added Alert.AlertTypeID = 1 to JOIN
**		06/26/2020		James Gerberich		Refactored and eliminated the calling sproc. VS 69296
**		01/26/2021		Mike Berenson		Created a new version from sps_rpt_ReferralActivity_Select.sql
**		01/26/2021		Mike Berenson		Refactored with @DateType logic
**		01/28/2021		Mike Berenson		Added default sorting with calculated field: BasedOnDT1
**		02/10/2021		Mike Berenson		Added ReferralDOB, ReferralDonorAge & ReferralDonorAgeUnit to #FilteredReferrals
*******************************************************************************/

BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON;
	----------------------------------------------------------------

	/* Allow wildcard search using asterisk [*]  */
	IF @PatientFirstName IS NOT Null
		BEGIN
			SET @PatientFirstName = REPLACE(@PatientFirstName,'*','%');
		END
	IF @PatientLastName IS NOT Null
		BEGIN
			SET @PatientLastName = REPLACE(@PatientLastName,'*','%');
		END
	IF @MedicalRecordNumber IS NOT Null
		BEGIN
			SET @MedicalRecordNumber = REPLACE(@MedicalRecordNumber,'*','%');
		END
	----------------------------------------------------------------

	DECLARE
		@CARDIACDATETIME				INT = 2,
		@REFERRALDATETIME				INT = 1,
		@AdjustedCardiacStartDateTime	SMALLDATETIME = DATEADD(D, -1, @StartDateTime),
		@AdjustedCardiacEndDateTime		SMALLDATETIME = DATEADD(D, +1, @EndDateTime),
		@AdjustedReferralStartDateTime	SMALLDATETIME = DATEADD(HH, -4, @StartDateTime),
		@AdjustedReferralEndDateTime	SMALLDATETIME = DATEADD(HH, 4, @EndDateTime),
		@ServiceLevelDefault			VARCHAR(10) = (SELECT dbo.fn_ServiceLevelDefault(NULL));

	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #FilteredReferrals;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;
	----------------------------------------------------------------

	-- If a Call ID is provided ignore all other parameters
	IF(@CallID IS NOT NULL AND @CallID <> 0)
	BEGIN SELECT
		@StartDateTime			= NULL,
		@EndDateTime			= NULL,
		@SourceCodeName			= NULL,
		@CoordinatorID			= NULL,
		@LowerAgeLimit			= NULL,
		@UpperAgeLimit			= NULL,
		@PatientFirstName		= NULL,
		@PatientLastName		= NULL,
		@MedicalRecordNumber	= NULL,
		@ReferralType			= NULL,
		@OrganizationID			= NULL,
		@Gender					= NULL
	END;
	----------------------------------------------------------------

	-- Get list of needed Source Codes 
	SELECT SourceCodeID
	INTO #SourceCodes
	FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName);
	--------------------------------

	CREATE TABLE #ConvertedCalls (
		CallID						INT,
		CallDateTime				SMALLDATETIME	NULL,
		ReferralDonorDeathDateTime	SMALLDATETIME	NULL,
		SourceCodeID				INT,
		DonorAge					INT				NULL
	);
	
	-- Load #ConvertedCalls with Converted DateTimes
	IF @DateType = @CARDIACDATETIME 
	BEGIN
		
		-- Load #FilteredReferrals with referrals filtered by ReferralDonorDeathDate
		SELECT
			CallID,
			ReferralDonorDeathDate,
			ReferralDonorDeathTime, 
			ReferralDOB,
			ReferralDonorAge,
			ReferralDonorAgeUnit		
		INTO #FilteredReferrals
		FROM
			Referral
		WHERE
			(
				@CallID IS NULL	
				AND ReferralDonorDeathDate >= @AdjustedCardiacStartDateTime
				AND ReferralDonorDeathDate <= @AdjustedCardiacEndDateTime
			) 
			OR CallID = @CallID;

		-- Load #ConvertedCalls with calls filtered by SourceCode
		INSERT INTO #ConvertedCalls
		SELECT 
			r.CallID,
			NULL 'CallDateTime',	
			CASE WHEN r.ReferralDonorDeathDate IS NULL THEN '01/01/00'
			ELSE
			CONVERT(DATETIME,ISNULL(CONVERT(VARCHAR, r.ReferralDonorDeathDate, 101), '01/01/00') + ' ' 
			+ CASE 
				WHEN ISNULL(r.ReferralDonorDeathTime, '') NOT LIKE '[0-9][0-9]:[0-9][0-9] [A-Z][A-Z]'
				THEN '00:00' 
				ELSE ISNULL(SUBSTRING(r.ReferralDonorDeathTime, 1, 5), '00:00')
				END) 
			END 'ReferralDonorDeathDateTime',
			sc.SourceCodeID,
			dbo.fn_rpt_DonorAgeYear(r.ReferralDOB, r.ReferralDonorDeathDate, r.ReferralDonorAge, r.ReferralDonorAgeUnit) AS 'DonorAge'
		FROM
			#FilteredReferrals r
			INNER JOIN [Call] c ON c.CallID = r.CallID
			INNER JOIN #SourceCodes sc ON sc.SourceCodeID = c.SourceCodeId

	END
	ELSE IF @DateType = @REFERRALDATETIME 
	BEGIN
		-- Filter calls by Call.CallDateTime
		INSERT INTO #ConvertedCalls
		SELECT 
			r.CallID,
			dbo.fn_rpt_ConvertDateTime(r.ReferralCallerOrganizationID, c.CallDateTime, @DisplayMT) AS 'CallDateTime',	
			NULL AS 'ReferralDonorDeathDateTime',
			sc.SourceCodeID,
			dbo.fn_rpt_DonorAgeYear(r.ReferralDOB, r.ReferralDonorDeathDate, r.ReferralDonorAge, r.ReferralDonorAgeUnit) AS 'DonorAge'
		FROM
			Referral r
			INNER JOIN [Call] c ON c.CallID = r.CallID
			INNER JOIN #SourceCodes sc ON sc.SourceCodeID = c.SourceCodeId
		WHERE
			(
				@CallID IS NULL	
				AND c.CallDateTime >= @AdjustedReferralStartDateTime
				AND c.CallDateTime <= @AdjustedReferralEndDateTime
			) 
			OR c.CallID = @CallID;
	END
	
	----------------------------------------------------------------
			
	-- Filter Converted Calls
	SELECT 
		cc.CallID, 
		cc.CallDateTime,
		cc.SourceCodeID
	INTO #FilteredCalls 
	FROM #ConvertedCalls cc
		JOIN Referral r ON r.CallID = cc.CallID
		JOIN WebReportGroupOrg wrgo ON wrgo.OrganizationID = r.ReferralCallerOrganizationID
	WHERE
		(
			(
				@CallID IS NULL
				AND	(
						(
							@DateType = @REFERRALDATETIME
							AND cc.CallDateTime >= @StartDateTime
							AND cc.CallDateTime <= @EndDateTime
						)
						OR	
						(
							@DateType = @CARDIACDATETIME
							AND cc.ReferralDonorDeathDateTime >= @StartDateTime
							AND cc.ReferralDonorDeathDateTime <= @EndDateTime
						)
					)
			)
			OR cc.CallID = @CallID
		)			
		
		AND		(@OrganizationID IS NULL OR r.ReferralCallerOrganizationID = @OrganizationID)
		AND		(@PatientLastName IS NULL OR PATINDEX(@PatientLastName, r.ReferralDonorLastName) > 0)
		AND		(@PatientFirstName IS NULL OR PATINDEX(@PatientFirstName, r.ReferralDonorFirstName) > 0)
		AND		(@MedicalRecordNumber IS NULL OR PATINDEX(@MedicalRecordNumber, r.ReferralDonorRecNumber) > 0)
		AND		(@Gender IS NULL OR r.ReferralDonorGender = @Gender)
		AND		(@ReferralType IS NULL OR @ReferralType = 0 OR r.ReferralTypeID = @ReferralType)
		AND		(@LowerAgeLimit IS NULL OR cc.DonorAge >= @LowerAgeLimit)
		AND		(@UpperAgeLimit IS NULL OR cc.DonorAge <= @UpperAgeLimit)
		AND		wrgo.WebReportGroupID = @ReportGroupID;

	----------------------------------------------------------------

	-- Get expanded info and final filters
	SELECT  DISTINCT
		fc.CallID,
		ReferralType.ReferralTypeName AS 'ReferralType',
		Alert.AlertGroupName AS 'AlertGroup',
		Alert.AlertID,
		CASE
			WHEN (@DateType = @CARDIACDATETIME) 
			THEN CONVERT(datetime,IsNULL(CONVERT(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + SUBSTRING(IsNULL(ReferralDonorDeathTime, '00:00 '),1,5))
			ELSE fc.CallDateTime
		END AS 'BasedOnDT1',
		CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'ReferralPerson',
		Organization.OrganizationName AS 'ReferralFacility',
		SubLocation.SubLocationName AS 'HospitalUnit',
		Referral.ReferralCallerSubLocationLevel AS 'Floor',
		CASE WHEN (@ReportGroupID = 37) 
			 THEN Alert.AlertGroupName
			 ELSE Organization.OrganizationName
		END AS GroupBy,
		/* Patient Information */
		IsNULL(Referral.ReferralDonorLastName, '') + ', ' + IsNULL(Referral.ReferralDonorFirstName, '') + ' ' + IsNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
		Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) + ' / ' + Referral.ReferralDonorGender + ' / ' + IsNULL(UPPER(SUBSTRING(race.RaceName,1,2)),'') AS 'A/S/R',
		Referral.ReferralDonorRecNumber AS 'MedicalRecordNumber',

		/* Disposition */
			/* Custom Mapping
			1. USE exec sps_DynamicDonorCategoryByOrg2 to find custom mapping lables for client report.

			Note: If client's service level is turned off, default values are set by the 
			function: dbo.fn_ServiceLevelDefault (Service Level Default). The default text may be modified in the 
			future by changing the return value in the function. All reports using this function will 
			receive the new default value. Passing the function either a blank ('') or NULL value will cause
			the default value to be returned. If the UserOrg = 194 all data will be displaied */

			/* Organ @UserOrgId = 194 OR */
			AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachOrgan, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentOrgan, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryOrgan,
		
			/* Bone*/
			AppropBone.AppropriateReportName AS AppropriateBone,
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachBone, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentBone, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryBone,

			/* Tissue*/
			AppropTissue.AppropriateReportName AS AppropriateTissue,
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachTissue, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentTissue, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryTissue, 

			/* Skin*/
			AppropSkin.AppropriateReportName AS AppropriateSkin,
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachSkin, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentSkin, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE @ServiceLevelDefault END AS RecoverySkin, 

			/* Valves*/
			AppropValve.AppropriateReportName AS AppropriateValve,
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachValve, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentValve, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryValve, 

			/* Eyes*/
			AppropEyes.AppropriateReportName AS AppropriateEyes,
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachEyes, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentEyes, 
			CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryEyes, 

			/* Other*/
			AppropRsch.AppropriateReportName AS AppropriateOther,
			ApproaRsch.ApproachReportName AS ApproachOther,
			ConsentRsch.ConsentReportName AS ConsentOther,
			RecoveryRsch.ConversionReportName AS RecoveryOther,

			/* RS Search parameters */
			Referral.ReferralDonorLastName AS 'PatientLastName',
			Referral.ReferralDonorFirstName AS 'PatientFirstName',

			/* RS GroupBy ReferralType ID */
			Referral.ReferralTypeID,

			/* ReferralType Counts */
			CASE WHEN Referral.ReferralTypeID = 1 THEN 1 ELSE 0 END AS 'CountOrganTissueEye',
			CASE WHEN Referral.ReferralTypeID = 2 THEN 1 ELSE 0 END AS 'CountTissueEye',
			CASE WHEN Referral.ReferralTypeID = 3 THEN 1 ELSE 0 END AS 'CountEyesOnly',
			CASE WHEN Referral.ReferralTypeID = 4 THEN 1 ELSE 0 END AS 'CountRuleOut'
	FROM
		#FilteredCalls fc
		INNER JOIN Referral ON Referral.CallID = fc.CallID
		INNER JOIN AlertOrganization ON Referral.ReferralCallerOrganizationID = AlertOrganization.OrganizationID
		INNER JOIN AlertSourceCode ON fc.SourceCodeID = AlertSourceCode.SourceCodeID
		INNER JOIN Alert ON AlertOrganization.AlertID = Alert.AlertID  AND AlertSourceCode.AlertID = Alert.AlertID AND Alert.AlertTypeID = 1

		LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID
		LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID
		LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID
		LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID
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
		LEFT JOIN CallCriteria CC ON CC.CallID = fc.CallID
		LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID
		LEFT JOIN LogEvent ON LogEvent.CallID = fc.CallID
		LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	
	WHERE
		(
			@CoordinatorID IS NULL
		OR	@CoordinatorID = 0
		OR	LogEvent.StatEmployeeID = @CoordinatorID
		)
	ORDER BY 
		BasedOnDT1;

	----------------------------------------------------------------

	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #FilteredReferrals;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;
	DROP TABLE IF EXISTS #Calls;

END
GO
