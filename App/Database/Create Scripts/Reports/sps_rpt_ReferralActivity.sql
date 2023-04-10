IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralActivity')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralActivity';
		DROP  PROCEDURE  sps_rpt_ReferralActivity;
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralActivity';
GO


CREATE Procedure sps_rpt_ReferralActivity
(
	@CallID					int			= NULL,
	@ReferralStartDateTime	DateTime	= NULL,
	@ReferralEndDateTime	DateTime	= NULL,
	@CardiacStartDateTime	DateTime	= NULL,
	@CardiacEndDateTime		DateTime	= NULL,
	@PatientFirstName		varchar(40)	= NULL,
	@PatientLastName		varchar(40)	= NULL,
	@MedicalRecordNumber	varchar(30)	= NULL,
	@ReferralType			int			= NULL,		
	@ReportGroupID			int			= NULL,
	@OrganizationID			int			= NULL,
	@SourceCodeName			varchar(10)	= NULL,
	@CoordinatorID			int			= NULL,
	@LowerAgeLimit			int			= NULL,
	@UpperAgeLimit			int			= NULL,
	@Gender					varchar(1)	= NULL,
	@UserOrgID				int			= NULL,
	@UserID					int			= NULL,
	@DisplayMT				int			= NULL
)
AS
/******************************************************************************
**		File: sps_rpt_ReferralActivity_Select.sql
**		Name: sps_rpt_ReferralActivity_Select
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
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;
----------------------------------------------------------------

/* Allow wildcard search using asteric [*]  */
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

DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #ConvertedDate;
DROP TABLE IF EXISTS #Calls;
----------------------------------------------------------------

-- If a Call ID is provided ignore all other parameters
IF(@CallID IS NOT NULL AND @CallID <> 0)
BEGIN SELECT
	@ReferralStartDateTime	= NULL,
	@ReferralEndDateTime	= NULL,
	@CardiacStartDateTime	= NULL,
	@CardiacEndDateTime		= NULL,
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

-- Get the default value for NULL Service Levels
DECLARE
	@ServiceLevelDefault	varchar(10) = (SELECT dbo.fn_ServiceLevelDefault(NULL));
----------------------------------------------------------------

-- Get list of needed Source Codes 
SELECT SourceCodeID
INTO #SourceCodes
FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName);
--------------------------------

-- Converts CallDateTime to proper time zone and gets Case IDs within the date range
SELECT
	CallID,
	CallDateTime
INTO #ConvertedDate
FROM dbo.fn_rpt_ReferralDateTimeConversion
(
	@CallID,
	@ReferralStartDateTime,
	@ReferralEndDateTime,
	@CardiacStartDateTime,
	@CardiacEndDateTime,
	@DisplayMT
);
----------------------------------------------------------------

-- Get basic info for needed cases and initial filters
SELECT DISTINCT
	c.CallID,
	sc.SourceCodeID,
	Organization.OrganizationName AS 'ReferralFacility',
	LT.CallDateTime,
	dbo.fn_rpt_DonorAgeYear(ReferralDOB, ReferralDonorDeathDate,ReferralDonorAge, ReferralDonorAgeUnit) AS DonorAge
INTO #Calls
FROM
	dbo.[Call] c
	INNER JOIN #SourceCodes sc ON sc.SourceCodeID = c.SourceCodeID
	INNER JOIN #ConvertedDate LT ON LT.CallID = c.CallID
	INNER JOIN Referral ON Referral.CallID = c.CallID
	INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN LogEvent ON c.CallID = LogEvent.CallID
WHERE
	WebReportGroupOrg.WebReportGroupID = @ReportGroupID
AND	(
		@ReferralType IS NULL
	OR	@ReferralType = 0
	OR	Referral.ReferralTypeID = @ReferralType
	)
AND	(
		@OrganizationID IS NULL
	OR	Referral.ReferralCallerOrganizationID = @OrganizationID
	)
AND	(
		@PatientLastName IS NULL
	OR	PATINDEX(@PatientLastName, Referral.ReferralDonorLastName) > 0
	)
AND	(
		@PatientFirstName IS NULL
	OR	PATINDEX(@PatientFirstName, Referral.ReferralDonorFirstName) > 0
	)
AND	(
		@MedicalRecordNumber IS NULL
	OR	PATINDEX(@MedicalRecordNumber, Referral.ReferralDonorRecNumber) > 0
	)
AND	(
		@Gender IS NULL
	OR	Referral.ReferralDonorGender = @Gender
	)
AND (
		@CoordinatorID IS NULL
	OR	@CoordinatorID = 0
	OR	LogEvent.StatEmployeeID = @CoordinatorID
	)
;
--------------------------------

-- Get expanded info and final filters
SELECT  DISTINCT
	c.CallID,
	ReferralType.ReferralTypeName AS 'ReferralType',
	Alert.AlertGroupName AS 'AlertGroup',
	Alert.AlertID,
	CASE
		WHEN (@CardiacStartDateTime Is Not Null) 
		THEN CONVERT(datetime,IsNULL(CONVERT(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + SUBSTRING(IsNULL(ReferralDonorDeathTime, '00:00 '),1,5))
		ELSE c.CallDateTime
	END AS 'BasedOnDT1',
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'ReferralPerson',
	c.ReferralFacility,
	SubLocation.SubLocationName AS 'HospitalUnit',
	Referral.ReferralCallerSubLocationLevel AS 'Floor',
	CASE WHEN (@ReportGroupID = 37) 
		 THEN Alert.AlertGroupName
		 ELSE c.ReferralFacility
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
	#Calls c

	INNER JOIN Referral ON Referral.CallID = c.CallID
	INNER JOIN AlertOrganization ON Referral.ReferralCallerOrganizationID = AlertOrganization.OrganizationID
	INNER JOIN AlertSourceCode ON c.SourceCodeID = AlertSourceCode.SourceCodeID
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
	LEFT JOIN CallCriteria CC ON CC.CallID = c.CallID
	LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID
WHERE
	(
		@LowerAgeLimit IS NULL
	OR	c.DonorAge >= @LowerAgeLimit
	)
AND	(
		@UpperAgeLimit IS NULL
	OR	c.DonorAge <= @LowerAgeLimit
	)
GO
----------------------------------------------------------------

DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #ConvertedDate;
DROP TABLE IF EXISTS #Calls;
