IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_ReferralOutcomeReport_Select')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_ReferralOutcomeReport_Select';
	DROP Procedure sps_rpt_ReferralOutcomeReport_Select;
END
GO

PRINT 'Creating Procedure sps_rpt_ReferralOutcomeReport_Select';
GO
CREATE Procedure [dbo].[sps_rpt_ReferralOutcomeReport_Select]
	@CallID						INT = NULL,
	@DateType					INT = 1,	-- 2 = CardiacDateTime (Referral.ReferralDonorDeathDate), 1 = ReferralDateTime(Call.CallDateTime)
	@StartDateTime				SMALLDATETIME = NULL,
	@EndDateTime				SMALLDATETIME = NULL,
	
	@PatientFirstName			VARCHAR(40) = NULL,
	@PatientLastName			VARCHAR(40) = NULL,
	@MedicalRecordNumber		VARCHAR(30) = NULL,
	@ReferralType				INT = NULL,		
	@CauseOfDeath				INT = NULL,

	@ReportGroupID				INT = NULL,
	@OrganizationID				INT = NULL,
	@SourceCodeName				VARCHAR(10) = NULL,
	@CoordinatorID				INT = NULL,
	@LowerAgeLimit				INT = NULL,
	@UpperAgeLimit				INT = NULL,
	@Gender						VARCHAR(1) = NULL,

	@UserOrgID					INT = NULL,
	@DisplayMT					INT = NULL

AS
/******************************************************************************
**		File: sps_rpt_ReferralOutcomeReport_Select.sql
**		Name: sps_rpt_ReferralOutcomeReport_Select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   sps_rpt_ReferralOutcomeReport
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: Mike Berenson
**		Date: 10/12/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      09/25/2007	ccarroll			Initial release
**      04/2009         jth             fixed handling of null age limits
**		04/19/2010	James Gerberich		Added @Race Parameter,
**		04/20/2010	James Gerberich		Added @ReferralCallerPersonID Parameter and field
**		12/02/2014	Bret Knoll			Broke out the udfs and cleanupd the where clause.
**		06/22/2020	Mike Berenson		Added to source control
**		06/22/2020	Mike Berenson		Formatted to meet coding standards
**		06/22/2020	Mike Berenson		Refactored for improved maintenance & performance
**		06/24/2020	Mike Berenson		Refactored - round 2
**		06/24/2020	Mike Berenson		Replaced query with call to fn_SourceCodeList
**		06/26/2020	Mike Berenson		Removed temp tables and used function calls instead
**		10/12/2020	Mike Berenson		Created new file (	ReferralOutcomeReport_Select.sql 
**													from	ReferralOutcome_Select.sql)
**		10/19/2020	Mike Berenson		Refactored for improved performance
**		01/05/2020	James Gerberich		Corrected DateType values
**		01/20/2021	Mike Berenson		Refactored - round 3 with where clauses moved to an 
**											earlier query and left join replaced with a where
**											exists clause
**		01/27/2021	Mike Berenson		Refactored DonorAge logic to avoid having a function 
**											in a where clause
**		01/28/2021	Mike Berenson		Fixed bad table aliases from last check-in
**		01/29/2021	James Gerberich		Added Timely calculation for link to Timely Referral report.
**		02/10/2021	Mike Berenson		Added ReferralDOB, ReferralDonorAge & ReferralDonorAgeUnit to #FilteredReferrals
**		02/19/2021	James Gerberich		Applied Report Group parameter to limit records. TFS 72897
**		05/13/2021	James Gerberich		Adjusted conversion for ReferralDonorDeathDateTime when the
**											DateType is Referral. TFS 73916
*******************************************************************************/
BEGIN

	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DECLARE
		@CARDIACDATETIME				INT = 2,
		@REFERRALDATETIME				INT = 1,
		@AdjustedCardiacStartDateTime	SMALLDATETIME = DATEADD(D, -1, @StartDateTime),
		@AdjustedCardiacEndDateTime		SMALLDATETIME = DATEADD(D, +1, @EndDateTime),
		@AdjustedReferralStartDateTime	SMALLDATETIME = DATEADD(HH, -4, @StartDateTime),
		@AdjustedReferralEndDateTime	SMALLDATETIME = DATEADD(HH, 4, @EndDateTime),
		@ServiceLevelDefault			VARCHAR(10)	= dbo.fn_ServiceLevelDefault(NULL),
		@StatLineOrgID					INT = 194;

	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #FilteredReferrals;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;

	-- Load #SourceCodes
	SELECT SourceCodeId 
	INTO #SourceCodes
	FROM dbo.fn_SourceCodeList (@ReportGroupID, @SourceCodeName);

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
			INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		WHERE
			WebReportGroupOrg.WebReportGroupID = @ReportGroupID
			AND	(
					(
						@CallID IS NULL	
						AND ReferralDonorDeathDate >= @AdjustedCardiacStartDateTime
						AND ReferralDonorDeathDate <= @AdjustedCardiacEndDateTime
					) 
					OR CallID = @CallID
				);

		-- Load #ConvertedCalls with calls filtered by SourceCode
		INSERT INTO #ConvertedCalls
		SELECT 
			r.CallID,
			[Call].CallDateTime 'CallDateTime',	
			CASE WHEN r.ReferralDonorDeathDate IS NULL THEN '01/01/00'
				ELSE
					CONVERT(DATETIME,ISNULL(CONVERT(VARCHAR, r.ReferralDonorDeathDate, 101), '01/01/00') + ' ' 
					+ CASE 
						WHEN ISNULL(r.ReferralDonorDeathTime, '') NOT LIKE '[0-9][0-9]:[0-9][0-9] [A-Z][A-Z]'
						THEN '00:00' 
						ELSE ISNULL(SUBSTRING(r.ReferralDonorDeathTime, 1, 5), '00:00')
					END)
			END 'ReferralDonorDeathDateTime',
			SC.SourceCodeID,
			dbo.fn_rpt_DonorAgeYear(r.ReferralDOB, r.ReferralDonorDeathDate, r.ReferralDonorAge, r.ReferralDonorAgeUnit) AS 'DonorAge'
		FROM
			#FilteredReferrals r
			INNER JOIN [Call] ON r.CallID = [Call].CallID
			INNER JOIN #SourceCodes SC ON Call.SourceCodeID = SC.SourceCodeId

	END
	ELSE IF @DateType = @REFERRALDATETIME 
	BEGIN
		-- Filter calls by Call.CallDateTime
		INSERT INTO #ConvertedCalls
		SELECT 
			r.CallID,
			dbo.fn_rpt_ConvertDateTime(r.ReferralCallerOrganizationID, c.CallDateTime, @DisplayMT) 'CallDateTime',	
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
			Referral r
			INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = r.ReferralCallerOrganizationID
			INNER JOIN [Call] c ON c.CallID = r.CallID
			INNER JOIN #SourceCodes sc ON sc.SourceCodeID = c.SourceCodeId
		WHERE
			WebReportGroupOrg.WebReportGroupID = @ReportGroupID
			AND	(
					(
						@CallID IS NULL	
						AND c.CallDateTime >= @AdjustedReferralStartDateTime
						AND c.CallDateTime <= @AdjustedReferralEndDateTime
					) 
					OR c.CallID = @CallID
				);
	END
			
	-- Filter Converted Calls
	SELECT 
		cc.CallID, 
		cc.CallDateTime,
		sc.SourceCodeID,
		sc.SourceCodeName,
		cc.ReferralDonorDeathDateTime
	INTO #FilteredCalls 
	FROM #ConvertedCalls cc
		JOIN SourceCode sc ON sc.SourceCodeID = cc.SourceCodeID
		JOIN Referral r ON r.CallID = cc.CallID
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
			
		/* Search - Organization */
		AND		(@OrganizationID IS NULL OR r.ReferralCallerOrganizationID = @OrganizationID)
		
		/* Search - Referral Type */
		AND		(@ReferralType IS NULL OR @ReferralType = 0 OR r.ReferralTypeID = @ReferralType)

		/* Search - CauseOfDeath */
		AND		(@CauseOfDeath IS NULL OR @CauseOfDeath = 0 OR r.ReferralDonorCauseOfDeathID = @CauseOfDeath)		
		
		/* Search - Lower/Upper Age Limit */
		AND		(@LowerAgeLimit IS NULL OR cc.DonorAge >= @LowerAgeLimit)
		AND		(@UpperAgeLimit IS NULL OR cc.DonorAge <= @UpperAgeLimit)

		/* Search - Gender */
		AND		(@Gender IS NULL OR PATINDEX(@Gender, r.ReferralDonorGender) > 0)
	
		/* Search (wildcards permitted) - PatientLastName */
		AND		(@PatientLastName IS NULL OR PATINDEX(@PatientLastName, r.ReferralDonorLastName) > 0)

		/* Search (wildcards permitted) - PatientFirstName */
		AND		(@PatientFirstName IS NULL OR PATINDEX(@PatientFirstName, r.ReferralDonorFirstName) > 0)

		/* Search (wildcards permitted) - Medical Record# */
		AND		(@MedicalRecordNumber IS NULL OR PATINDEX(@MedicalRecordNumber, r.ReferralDonorRecNumber) > 0);


	SELECT DISTINCT 
		fc.CallID,
		ReferralType.ReferralTypeName AS 'PreliminaryRefType',
		ReferralType.ReferralTypeID,
		CASE
			WHEN @DateType = @CARDIACDATETIME
			THEN fc.ReferralDonorDeathDateTime
			WHEN @DateType = @REFERRALDATETIME
			THEN fc.CallDateTime
		END  AS BasedOnDT,
		DATEDIFF(MINUTE, fc.ReferralDonorDeathDateTime, fc.CallDateTime) AS Timely,
		/* Caller Information */
	
		Organization.OrganizationName AS 'ReferralFacility',
		SubLocation.SubLocationName AS 'HospitalUnit',
		Referral.ReferralCallerSubLocationLevel AS 'Floor',
		CallerPerson.PersonID,
		CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'ReferralPerson',

		/* Initial Approach -  */
		CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT NULL
				THEN ISNULL(HospitalApproach.ApproachTypeName, ApproachType.ApproachTypeName) -- pull from Secondary
				ELSE ApproachType.ApproachTypeName     -- pull from Triage
		END AS 'InitialApproachType',

		/* Initial Approach Outcome - */
		CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT NULL and SecondaryApproach.SecondaryHospitalOutcome > 0
				THEN (CASE SecondaryApproach.SecondaryHospitalOutcome
						WHEN 1 THEN 'Yes-Written'
						WHEN 2 THEN 'Yes-Verbal'
						WHEN 3 THEN 'No'
					END)
				ELSE
					(CASE Referral.ReferralGeneralConsent
						WHEN 1 THEN 'Yes-Written'
						WHEN 2 THEN 'Yes-Verbal'
						WHEN 3 THEN 'No'
					END)
		END AS 'InitialConsent',
	
		/* Initial Approacher - */
		Referral.ReferralApproachedByPersonID,
	
		CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT NULL
				THEN ISNULL(HospitalApproachPerson.PersonFirst, ApproachPerson.PersonFirst) + ' ' + ISNULL(HospitalApproachPerson.PersonLast, ApproachPerson.PersonLast)
				ELSE ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast
		END AS 'InitialApproacher',

		/* Final Approach - Display values only if Secondary Servicelevel is turned ON */
		CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
				THEN InformedApproach.FSApproachTypeName
				ELSE '' 
		END AS 'FinalApproachType',

		CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
				THEN 
					(CASE SecondaryApproach.SecondaryApproachOutcome
						WHEN 1 THEN 'Yes-Verbal'
						WHEN 2 THEN 'Yes-Written'
						WHEN 3 THEN 'No'
						WHEN 4 THEN 'Undecided' 
						ELSE null 
						END)
				ELSE null
		END AS 'FinalApproachOutcome',
	
		CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
				THEN ISNULL(InformedApproachPerson.PersonFirst, NULL) + ' ' + ISNULL(InformedApproachPerson.PersonLast, NULL)
				ELSE NULL
		END AS 'FinalApproacher',

		/* Patient Information */
		--IsNULL(Referral.ReferralDonorLastName, '') + ', ' + IsNULL(Referral.ReferralDonorFirstName, '') + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
		CASE WHEN ServiceLevel.ServiceLevelLastName = -1 AND ServiceLevel.ServiceLevelFirstName = -1 THEN IsNULL(Referral.ReferralDonorLastName, '') + ', ' + IsNULL(Referral.ReferralDonorFirstName, '') + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') ELSE @ServiceLevelDefault END AS 'PatientName', 
		CASE WHEN ServiceLevel.ServiceLevelGender = -1 THEN Referral.ReferralDonorGender ELSE @ServiceLevelDefault END AS 'PatientGender', 
		CASE WHEN ServiceLevel.ServiceLevelAge = -1 THEN Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) ELSE @ServiceLevelDefault END AS 'PatientAge', 
		CASE WHEN ServiceLevel.ServiceLevelRace = -1 THEN race.RaceName ELSE @ServiceLevelDefault END AS 'PatientRace', 
		CASE WHEN ServiceLevel.ServiceLevelRecNum = -1 THEN Referral.ReferralDonorRecNumber ELSE @ServiceLevelDefault END AS 'MedicalRecordNumber', 
		ISNULL(RegistryStatusType.RegistryType, 'Not on Registry') AS RegistryStatus,
		CauseOfDeathName AS 'CauseOfDeath',
		--dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Referral.ReferralDonorDeathDate, @DisplayMT) 
		--LT.ReferralDonorDeathDateTime AS 'CardiacDeathDateTime',
		CASE WHEN ServiceLevel.ServiceLevelDeathDate = -1 THEN CASE WHEN ISNULL(Referral.ReferralDonorDeathDate, '') = '' THEN ' ' ELSE convert(char(10),Referral.ReferralDonorDeathDate,101) + ' '+ Referral.ReferralDonorDeathTime END ELSE @ServiceLevelDefault END AS 'CardiacDeathDateTime',
		Referral.ReferralDonorDeathDate,
		/* Disposition */
			/* Custom Mapping
			1. USE exec sps_DynamicDonorCategoryByOrg2 to find custom mapping lables for client report.
				ref: sub_DynamicDonorCategory.rdl

			Note: If client's service level is turned off, default values are set by the 
			function: dbo.fn_ServiceLevelDefault (Service Level Default). The default text may be modified in the 
			future by changing the return value in the function. All reports using this function will 
			receive the new default value. Passing the function either a blank ('') or NULL value will cause
			the default value to be returned. If the UserOrg = @StatLineOrganizationID all data will be displaied */

		/* Organ @UserOrgId = @StatLineOrgID OR */
		--AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelAppropriateOrgan = -1 THEN AppropOrgan.AppropriateReportName ELSE @ServiceLevelDefault END AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachOrgan, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentOrgan, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryOrgan,
		
		/* Bone*/
		--AppropBone.AppropriateReportName AS AppropriateBone,
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelAppropriateBone = -1 THEN AppropBone.AppropriateReportName ELSE @ServiceLevelDefault END AS AppropriateBone, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachBone, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentBone, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryBone,

		/* Tissue*/
		--AppropTissue.AppropriateReportName AS AppropriateTissue,
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelAppropriateTissue = -1 THEN AppropTissue.AppropriateReportName ELSE @ServiceLevelDefault END AS AppropriateTissue, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachTissue, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentTissue, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryTissue, 

		/* Skin*/
		--AppropSkin.AppropriateReportName AS AppropriateSkin,
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelAppropriateSkin = -1 THEN AppropSkin.AppropriateReportName ELSE @ServiceLevelDefault END AS AppropriateSkin, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachSkin, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentSkin, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE @ServiceLevelDefault END AS RecoverySkin, 

		/* Valves*/
		--AppropValve.AppropriateReportName AS AppropriateValve,
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelAppropriateValves = -1 THEN AppropValve.AppropriateReportName ELSE @ServiceLevelDefault END AS AppropriateValve, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachValve, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentValve, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryValve, 

		/* Eyes*/
		--AppropEyes.AppropriateReportName AS AppropriateEyes,
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelAppropriateEyes = -1 THEN AppropEyes.AppropriateReportName ELSE @ServiceLevelDefault END AS AppropriateEyes, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachEyes, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentEyes, 
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryEyes, 

		/* Other*/
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelAppropriateRsch = -1 THEN AppropRsch.AppropriateReportName ELSE @ServiceLevelDefault END AS AppropriateOther,
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelApproachRsch = -1 THEN ApproaRsch.ApproachReportName ELSE @ServiceLevelDefault END AS ApproachOther,
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelConsentRsch = -1 THEN ConsentRsch.ConsentReportName ELSE @ServiceLevelDefault END AS ConsentOther,
		CASE WHEN @UserOrgId = @StatLineOrgID OR ServiceLevel.ServiceLevelRecoveryRsch = -1 THEN RecoveryRsch.ConversionReportName ELSE @ServiceLevelDefault END AS RecoveryOther,

		/* RS Search parameters */
		Referral.ReferralDonorLastName AS 'PatientLastName',
		Referral.ReferralDonorFirstName AS 'PatientFirstName',
				
		/* RS sub-report paramaters for DynamicDonorCategory */
		Referral.ReferralCallerOrganizationID,
		fc.SourceCodeID,
		fc.SourceCodeName,
		ReferralGeneralConsent,
		ReferralApproachTypeID,
		ReferralOrganAppropriateID,
		ReferralOrganApproachID,
		ReferralOrganConsentID,
		ReferralOrganConversionID  ,
		ReferralBoneAppropriateID  ,
		ReferralBoneApproachID  ,
		ReferralBoneConsentID  ,
		ReferralBoneConversionID  ,
		ReferralTissueAppropriateID  ,
		ReferralTissueApproachID  ,
		ReferralTissueConsentID  ,
		ReferralTissueConversionID  ,
		ReferralSkinAppropriateID  ,
		ReferralSkinApproachID  ,
		ReferralSkinConsentID  ,
		ReferralSkinConversionID  ,
		ReferralEyesTransAppropriateID  ,
		ReferralEyesTransApproachID  ,
		ReferralEyesTransConsentID  ,
		ReferralEyesTransConversionID  ,
		ReferralEyesRschAppropriateID  ,
		ReferralEyesRschApproachID  ,
		ReferralEyesRschConsentID  ,
		ReferralEyesRschConversionID  ,
		ReferralValvesAppropriateID  ,
		ReferralValvesApproachID  ,
		ReferralValvesConsentID  ,
		ReferralValvesConversionID , 
		FSCaseBillSecondaryUserID ,
		FSCaseBillApproachUserID ,
		FSCaseBillMedSocUserID ,
		FSCaseBillFamUnavailUserID ,
		FSCaseBillCryoFormUserID ,
		FSCaseBillApproachCount ,
		FSCaseBillMedSocCount ,
		FSCaseBillCryoFormCount,
		RegistryStatus.RegistryStatus		

	FROM    #FilteredCalls fc
		JOIN Referral ON Referral.CallID = fc.CallID 
	
		LEFT JOIN CallCriteria CC ON CC.CallID = fc.CallID 
		LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 
		LEFT JOIN ServiceLevelSecondary ON ServiceLevelSecondary.ServiceLevelID = CC.ServiceLevelID
		LEFT JOIN FSCase ON FSCase.CallID = fc.CallID

		/* Hospital Approach */
		LEFT JOIN SecondaryApproach ON SecondaryApproach.CallID = fc.CallID
		LEFT JOIN ApproachType AS HospitalApproach ON HospitalApproach.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach
		LEFT JOIN Person AS HospitalApproachPerson ON HospitalApproachPerson.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy

		/* Informed Approach */
		LEFT JOIN FSApproachType AS InformedApproach ON InformedApproach.FSApproachTypeID = SecondaryApproach.SecondaryApproachType
		LEFT JOIN Person AS InformedApproachPerson ON InformedApproachPerson.PersonID = SecondaryApproach.SecondaryApproachedBy

		LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
		LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
		LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
		LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
		LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID
		LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID 
		LEFT JOIN RegistryStatus ON RegistryStatus.CallId = fc.CallId 
		LEFT JOIN RegistryStatusType ON RegistryStatus.RegistryStatus = RegistryStatusType.ID
		LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
		LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID 
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
		
	WHERE	
			
		/* Search - Coordinator */	
		(@CoordinatorID IS NULL OR EXISTS (SELECT 1 FROM LogEvent le WHERE le.CallID = fc.CallID));
		
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #FilteredReferrals;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;
END
GO

GRANT EXEC ON sps_rpt_ReferralOutcomeReport_Select TO PUBLIC;
GO