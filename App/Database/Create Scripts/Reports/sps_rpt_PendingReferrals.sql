IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_PendingReferrals')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_PendingReferrals';
	DROP Procedure sps_rpt_PendingReferrals;
END
GO

PRINT 'Creating Procedure sps_rpt_PendingReferrals';
GO
CREATE Procedure [dbo].[sps_rpt_PendingReferrals]
	@CallID						INT				= NULL,
	@ReferralStartDateTime		DATETIME		= NULL,
	@ReferralEndDateTime		DATETIME		= NULL,
	@ReferralType				INT				= NULL,		
	@ReportGroupID				INT				= NULL,
	@OrganizationID				INT				= NULL,
	@SourceCodeName				VARCHAR(10)		= NULL,
	@CoordinatorID				INT				= NULL,
	@LowerAgeLimit				INT				= NULL,
	@UpperAgeLimit				INT				= NULL,
	@Gender						VARCHAR(1)		= NULL,
	@DisplayMT					INT				= NULL

AS

/******************************************************************************
**		File: sps_rpt_PendingReferrals.sql
**		Name: sps_rpt_PendingReferrals
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
**		Date: 10/10/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      10/10/2008		ccarroll			Initial release
**		06/22/2009		ccarroll			HS 17764, Categories not checked in View By Option
**											(StatTrac Report Groups) are not displayed when only item pending.
**		06/11/2010		James Gerberich		Added Pending Referral Type Column and reworked logic to return
**											only Pending Referrals VS 6248 & 6249
**		01/16/2011		James Gerberich		Requirements clarification for Consent = No, Unknown.  Include in results
**											HS 26529, VS 9392
**      09/2011			jth					added ctod and lsa dates
**		06/24/2020		Mike Berenson		Added to source control
**		06/26/2020		Mike Berenson		Refactored
**		06/27/2020		Mike Berenson		Refactored - round 2
**		10/22/2020		Mike Berenson		Fixed bad logic in the OrganAppropriate area of the where clause
**		01/22/2021		Mike Berenson		Created a new version from sps_rpt_PendingReferrals_select.sql with bug fix on @UpperAgeLimit logic.   
**												Also refactored with added temp tables for SourceCodes, ConvertedCalls & FilteredCalls.
**		01/28/2021		Mike Berenson		Added = operator to the date range comparison to include exact matches
**		01/30/2021		Mike Berenson		Fixed upper & lower age limit default logic
*******************************************************************************/

BEGIN

	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;

	DECLARE
		@AdjustedReferralStartDateTime	SMALLDATETIME = DATEADD(HH, -4, @ReferralStartDateTime),
		@AdjustedReferralEndDateTime	SMALLDATETIME = DATEADD(HH, 4, @ReferralEndDateTime);

	SELECT 
		@UpperAgeLimit = CASE WHEN @LowerAgeLimit IS NOT NULL
							AND (@UpperAgeLimit IS NULL OR @UpperAgeLimit = 0)
						THEN 200 -- Set default upper limit
						ELSE @UpperAgeLimit END,
		@LowerAgeLimit = CASE WHEN (@LowerAgeLimit IS NULL OR @LowerAgeLimit = 0)
							AND @UpperAgeLimit IS NOT NULL
						THEN 0 -- Set default lower limit
						ELSE @LowerAgeLimit END;

	-- Load #SourceCodes
	SELECT SourceCodeID
	INTO #SourceCodes
	FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName);
	
	-- Load #ConvertedCalls with CallID and converted CallDateTime
	SELECT 
		c.CallID,
		dbo.fn_rpt_ConvertDateTime(r.ReferralCallerOrganizationID, c.CallDateTime, @DisplayMT) AS 'CallDateTime'
	INTO #ConvertedCalls
	FROM 
		[Call] c
		JOIN #SourceCodes sc				ON c.SourceCodeID = sc.SourceCodeID
		JOIN Referral r						ON c.CallID = r.CallID
		LEFT JOIN WebReportGroupOrg wrgo	ON wrgo.OrganizationID = r.ReferralCallerOrganizationID 
	WHERE
		(
			(@CallID IS NULL
				AND c.CallDateTime > @AdjustedReferralStartDateTime
				AND c.CallDateTime < @AdjustedReferralEndDateTime
			)
			OR c.CallID = @CallID
		)
		AND (@CoordinatorID IS NULL OR c.StatEmployeeID = @CoordinatorID)
		AND (@OrganizationID IS NULL OR r.ReferralCallerOrganizationID = @OrganizationID)
		AND (@ReportGroupID IS NULL OR wrgo.WebReportGroupID = @ReportGroupID);

	-- Load #FilteredCalls with calls filtered after date conversion
	SELECT 
		c.CallID,
		c.CallDateTime,
		dbo.fn_rpt_DonorAgeYear(Referral.ReferralDOB, Referral.ReferralDonorDeathDate, Referral.ReferralDonorAge, Referral.ReferralDonorAgeUnit) AS 'DonorAge',
		CASE
			WHEN
				(
					Referral.ReferralOrganAppropriateID = 1 --Organ Appropriate
				AND	Referral.ReferralOrganApproachID IN (-1,0,2) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralOrganApproachID = 1 --Approach = Yes
				AND	Referral.ReferralOrganConsentID IN (-1,0) --Consent NULL
				)
			OR
				(
					Referral.ReferralOrganConsentID = 1 --Consent = Yes
				AND	Referral.ReferralOrganConversionID IN (-1,0,9) --Recovery NULL or Unknown
				)
			THEN
				'O'
			ELSE
				''
		END
			+
		CASE
			WHEN
				(
					Referral.ReferralBoneAppropriateID = 1 --Bone Appropriate
				AND	Referral.ReferralBoneApproachID IN (-1,0,2) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralBoneApproachID = 1 --Approach = Yes
				AND	Referral.ReferralBoneConsentID IN (-1,0) --Consent NULL
				)
			OR
				(
					Referral.ReferralBoneConsentID = 1 --Consent = Yes
				AND	Referral.ReferralBoneConversionID IN (-1,0,9) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralTissueAppropriateID = 1 --Tissue Appropriate
				AND	Referral.ReferralTissueApproachID IN (-1,0,2) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralTissueApproachID = 1 --Approach = Yes
				AND	Referral.ReferralTissueConsentID IN (-1,0) --Consent NULL
				)
			OR
				(
					Referral.ReferralTissueConsentID = 1 --Consent = Yes
				AND	Referral.ReferralTissueConversionID IN (-1,0,9) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralSkinAppropriateID = 1 --Skin Appropriate
				AND	Referral.ReferralSkinApproachID IN (-1,0,2) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralSkinApproachID = 1 --Approach = Yes
				AND	Referral.ReferralSkinConsentID IN (-1,0) --Consent NULL
				)
			OR
				(
					Referral.ReferralSkinConsentID = 1 --Consent = Yes
				AND	Referral.ReferralSkinConversionID IN (-1,0,9) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralValvesAppropriateID = 1 --Valves Appropriate
				AND	Referral.ReferralValvesApproachID IN (-1,0,2) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralValvesApproachID = 1 --Approach = Yes
				AND	Referral.ReferralValvesConsentID IN (-1,0) --Consent NULL
				)
			OR
				(
					Referral.ReferralValvesConsentID = 1 --Consent = Yes
				AND	Referral.ReferralValvesConversionID IN (-10,9) --Recovery NULL or Unknown
				)
			THEN
				'T'
			ELSE
				''
		END
			+
		CASE
			WHEN
				(
					Referral.ReferralEyesTransAppropriateID = 1 --EyesTrans Appropriate
				AND	Referral.ReferralEyesTransApproachID IN (-1,0,2) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralEyesTransApproachID = 1 --Approach = Yes
				AND	Referral.ReferralEyesTransConsentID IN (-1,0) --Consent NULL
				)
			OR
				(
					Referral.ReferralEyesTransConsentID = 1 --Consent = Yes
				AND	Referral.ReferralEyesTransConversionID IN (-1,0,9) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralEyesRschAppropriateID = 1 --EyesRsch Appropriate
				AND	Referral.ReferralEyesRschApproachID IN (-1,0,2) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralEyesRschApproachID = 1 --Approach = Yes
				AND	Referral.ReferralEyesRschConsentID IN (-1,0) --Consent NULL
				)
			OR
				(
					Referral.ReferralEyesRschConsentID = 1 --Consent = Yes
				AND	Referral.ReferralEyesRschConversionID IN (-1,0,9) --Recovery NULL or Unknown
				)
			THEN
				'E'
			ELSE
				''
		END AS 'PendingReferralType'
	INTO #FilteredCalls
	FROM
		#ConvertedCalls c
		JOIN Referral ON Referral.CallID = c.CallID
	WHERE
		(
			(
				@CallID IS NULL 
				AND c.CallDateTime >= @ReferralStartDateTime
				AND c.CallDateTime <= @ReferralEndDateTime
			)
			OR @CallID IS NOT NULL
		)

		/* Search - Referral Type */
		AND (ReferralTypeID IS NOT NULL AND ReferralTypeID <> 4) -- referraltype not ruleout

		/* Search - Organization */
		AND (@OrganizationID IS NULL OR Referral.ReferralCallerOrganizationID = @OrganizationID)

		/* Search - Gender */
		AND (@Gender IS NULL OR Referral.ReferralDonorGender = @Gender)

		AND
			/*
			Appropriate, Approach, Consent & Conversion values come from the following tables:
			AppropriateID	--> Table: Appropriate
			ApproachID		--> Table: Approach
			ConsentID		--> Table: Consent
			ConversionID	--> Table: Conversion

			Sample Values
			-1 = Unanswered
			0 = ?
			1 = Yes (identified by table values)
			*/
			(
				(
					Referral.ReferralOrganAppropriateID = 1 --Organ Appropriate
				AND	(Referral.ReferralOrganApproachID = -1 
						OR Referral.ReferralOrganApproachID = 0 
						OR Referral.ReferralOrganApproachID = 2
					) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralOrganApproachID = 1 --Approach = Yes
				AND	(Referral.ReferralOrganConsentID = -1 
						OR Referral.ReferralOrganConsentID = 0
					) --Consent NULL
				)
			OR
				(
					Referral.ReferralOrganConsentID = 1 --Consent = Yes
				AND	(Referral.ReferralOrganConversionID = -1 
						OR Referral.ReferralOrganConversionID = 0 
						OR Referral.ReferralOrganConversionID = 9
					) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralBoneAppropriateID = 1 --Bone Appropriate
				AND	(Referral.ReferralBoneApproachID = -1 
						OR Referral.ReferralBoneApproachID = 0 
						OR Referral.ReferralBoneApproachID = 2
					) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralBoneApproachID = 1 --Approach = Yes
				AND	(Referral.ReferralBoneConsentID = -1
						OR Referral.ReferralBoneConsentID = 0
					) --Consent NULL
				)
			OR
				(
					Referral.ReferralBoneConsentID = 1 --Consent = Yes
				AND	(Referral.ReferralBoneConversionID = -1
						OR Referral.ReferralBoneConversionID = 0 
						OR Referral.ReferralBoneConversionID = 9
					) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralTissueAppropriateID = 1 --Tissue Appropriate
				AND	(Referral.ReferralTissueApproachID = -1
						OR Referral.ReferralTissueApproachID = 0
						OR Referral.ReferralTissueApproachID = 2
					) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralTissueApproachID = 1 --Approach = Yes
				AND	(Referral.ReferralTissueConsentID = -1 
						OR Referral.ReferralTissueConsentID = 0
					) --Consent NULL
				)
			OR
				(
					Referral.ReferralTissueConsentID = 1 --Consent = Yes
				AND	(Referral.ReferralTissueConversionID = -1 
						OR Referral.ReferralTissueConversionID = 0
						OR Referral.ReferralTissueConversionID = 9
					) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralSkinAppropriateID = 1 --Skin Appropriate
				AND	(Referral.ReferralSkinApproachID = -1 
						OR Referral.ReferralSkinApproachID = 0
						OR Referral.ReferralSkinApproachID = 2
					) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralSkinApproachID = 1 --Approach = Yes
				AND	(Referral.ReferralSkinConsentID = -1
						OR Referral.ReferralSkinConsentID = 0
					) --Consent NULL
				)
			OR
				(
					Referral.ReferralSkinConsentID = 1 --Consent = Yes
				AND	(Referral.ReferralSkinConversionID =  -1
						OR Referral.ReferralSkinConversionID = 0
						OR Referral.ReferralSkinConversionID = 9
					) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralValvesAppropriateID = 1 --Valves Appropriate
				AND	(Referral.ReferralValvesApproachID = -1
						OR Referral.ReferralValvesApproachID = 0
						OR Referral.ReferralValvesApproachID = 2
					) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralValvesApproachID = 1 --Approach = Yes
				AND	(Referral.ReferralValvesConsentID = -1
						OR Referral.ReferralValvesConsentID = 0
					) --Consent NULL
				)
			OR
				(
					Referral.ReferralValvesConsentID = 1 --Consent = Yes
				AND	(Referral.ReferralValvesConversionID = -1
						OR Referral.ReferralValvesConversionID = 0
						OR Referral.ReferralValvesConversionID = 9
					) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralEyesTransAppropriateID = 1 --EyesTrans Appropriate
				AND	(Referral.ReferralEyesTransApproachID = -1
						OR Referral.ReferralEyesTransApproachID = 0
						OR Referral.ReferralEyesTransApproachID =2
					) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralEyesTransApproachID = 1 --Approach = Yes
				AND	(Referral.ReferralEyesTransConsentID = -1
						OR Referral.ReferralEyesTransConsentID = 0
					) --Consent NULL
				)
			OR
				(
					Referral.ReferralEyesTransConsentID = 1 --Consent = Yes
				AND	(Referral.ReferralEyesTransConversionID = -1
						OR Referral.ReferralEyesTransConversionID = 0
						OR Referral.ReferralEyesTransConversionID = 9
					) --Recovery NULL or Unknown
				)
			OR
				(
					Referral.ReferralEyesRschAppropriateID = 1 --EyesRsch Appropriate
				AND	(Referral.ReferralEyesRschApproachID = -1
						OR Referral.ReferralEyesRschApproachID = 0
						OR Referral.ReferralEyesRschApproachID = 2
					) --Approach NULL or Unknown
				)
			OR
				(
					Referral.ReferralEyesRschApproachID = 1 --Approach = Yes
				AND	(Referral.ReferralEyesRschConsentID = -1
						OR Referral.ReferralEyesRschConsentID = 0
					) --Consent NULL
				)
			OR
				(
					Referral.ReferralEyesRschConsentID = 1 --Consent = Yes
				AND	(Referral.ReferralEyesRschConversionID = -1
						OR Referral.ReferralEyesRschConversionID = 0
						OR Referral.ReferralEyesRschConversionID = 9
					) --Recovery NULL or Unknown
				)
			);	

	-- Run final select
	SELECT DISTINCT
		fc.CallID,
		fc.CallDateTime AS 'BasedOnDT',
		Organization.OrganizationName AS 'ReferralFacility',

		/* Patient Information */
		ISNULL(Referral.ReferralDonorLastName, '') + ', ' + ISNULL(Referral.ReferralDonorFirstName, '') + ' '
			+ ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
		Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) + ' / '
			+ Referral.ReferralDonorGender + ' / ' + IsNull(UPPER(SUBSTRING(Race.RaceName,1,2)),'') AS 'A/S/R',
	
		/* RS Search parameters */
		Referral.ReferralDonorLastName AS 'PatientLastName',
		Referral.ReferralDonorFirstName AS 'PatientFirstName',

		/* RS GroupBy ReferralType ID */
		Referral.ReferralTypeID,
		ISNULL(CONVERT(VARCHAR, Referral.ReferralDonorLSADate, 101),' ') + ' ' + ISNULL(Referral.ReferralDonorLSATime, ' ') AS 'DonorLSADeathDT',
		ISNULL(CONVERT(VARCHAR, Referral.ReferralDonorDeathDate, 101),' ') + ' ' + ISNULL(Referral.ReferralDonorDeathTime, ' ') AS 'DonorCTODDeathDT',
		PendingReferralType
	FROM
		#FilteredCalls fc
		JOIN Referral ON Referral.CallID = fc.CallID
		LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
		LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID

	/* Search - ReferralType */
	WHERE (
			(@ReferralType IS NULL OR @ReferralType = 0)
		OR	(@ReferralType = 1 AND PATINDEX('O%', PendingReferralType) > 0)
		OR	(@ReferralType = 2 AND PATINDEX('%T%', PendingReferralType) > 0)
		OR	(@ReferralType = 3 AND PATINDEX('%E', PendingReferralType) > 0)
		)		
		
		/* Search - Lower/Upper Age Limit */
		AND (@LowerAgeLimit IS NULL OR fc.DonorAge >= @LowerAgeLimit)
		AND (@UpperAgeLimit IS NULL OR fc.DonorAge <= @UpperAgeLimit);
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;

END
GO

GRANT EXEC ON sps_rpt_PendingReferrals TO PUBLIC;
GO