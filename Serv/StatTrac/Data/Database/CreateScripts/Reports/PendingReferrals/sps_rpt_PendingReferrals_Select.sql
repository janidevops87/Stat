IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_PendingReferrals_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_PendingReferrals_Select'
		DROP  Procedure  sps_rpt_PendingReferrals_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_PendingReferrals_Select'
GO


CREATE Procedure sps_rpt_PendingReferrals_Select
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@ReferralType				int = Null,		
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,
	@DisplayMT					int = Null

AS

/******************************************************************************
**		File: sps_rpt_PendingReferrals_Select.sql
**		Name: sps_rpt_PendingReferrals_Select
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
*******************************************************************************/

--DECLARE
--	@CallID						int,
--	@ReferralStartDateTime		DateTime,
--	@ReferralEndDateTime		DateTime,
--	@ReferralType				int,
--	@ReportGroupID				int,
--	@OrganizationID				int,
--	@SourceCodeName				varchar(10),
--	@CoordinatorID				int,
--	@LowerAgeLimit				int,
--	@UpperAgeLimit				int,
--	@Gender						varchar(1),
--	@DisplayMT					int

--SELECT
--	@CallID = NULL,
--	@ReferralStartDateTime = '2010-05-01 00:00:00',
--	@ReferralEndDateTime = '2010-05-15 23:59:59',
--	@ReferralType = 1,
--	@ReportGroupID = 37,
--	@OrganizationID = NULL,
--	@SourceCodeName = NULL,
--	@CoordinatorID = NULL,
--	@LowerAgeLimit = NULL,
--	@UpperAgeLimit = NULL,
--	@Gender = NULL,
--	@DisplayMT = 1

IF
	@LowerAgeLimit Is Not Null
AND IsNull(@UpperAgeLimit, 0) = 0
/* Set default limit */
	BEGIN
		SELECT
			@UpperAgeLimit = 200
	END
IF
	IsNull(@LowerAgeLimit, 0) = 0
AND @UpperAgeLimit Is Not Null
/* Set default limit */
	BEGIN
		SELECT @LowerAgeLimit = 0
	END

SELECT DISTINCT
	[Call].CallID,
	LT.CallDateTime AS 'BasedOnDT',
	Organization.OrganizationName AS 'ReferralFacility',
/* Patient Information */
	IsNull(Referral.ReferralDonorLastName, '') + ', ' + IsNull(Referral.ReferralDonorFirstName, '') + ' '
		+ IsNull(Referral.ReferralDonorNameMI,'') AS 'PatientName',
	Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) + ' / '
		+ Referral.ReferralDonorGender + ' / ' + IsNull(UPPER(SUBSTRING(race.RaceName,1,2)),'') AS 'A/S/R',
/* RS Search parameters */
	Referral.ReferralDonorLastName AS 'PatientLastName',
	Referral.ReferralDonorFirstName AS 'PatientFirstName',
/* RS GroupBy ReferralType ID */
	Referral.ReferralTypeID,
	ISNULL(convert(varchar, ReferralDonorLSADate, 101),' ') + ' ' + ISNULL(ReferralDonorLSATime, ' ') AS 'DonorLSADeathDT',
	ISNULL(convert(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + ISNULL(ReferralDonorDeathTime, ' ') AS 'DonorCTODDeathDT',
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
FROM
	[Call]
	JOIN
		(
			SELECT
				CallID,
				CallDateTime
			FROM
				dbo.fn_rpt_ReferralDateTimeConversion
				(
					@CallID					,
					@ReferralStartDateTime	,
					@ReferralEndDateTime	,
					Null					,
					Null					,
					@DisplayMT
				)
		) LT ON LT.CallID = Call.CallID
	JOIN Referral ON Referral.CallID = Call.CallID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
		/* 06/19/2009 ccarroll - HS 17764 added table join for category access */
 	LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = ISNULL(@ReportGroupID, 0) AND (WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID)
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID
		--	LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID
	LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID
	LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID
	LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID
	LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID
	LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID
	LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID
	LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID
	LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID

WHERE
	ISNULL(@CallID,[Call].CallID) = [Call].CallID
	/* Search - ReportGroup */
AND [Call].SourceCodeID IN
		(
			SELECT DISTINCT * 
			FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName)
		)
	/* Search - Referral Type */
AND IsNull(ReferralTypeID, 0) <> 4 
	/* Search - Organization */
AND IsNull(Referral.ReferralCallerOrganizationID, 0) = IsNull(IsNull(@OrganizationID, Referral.ReferralCallerOrganizationID), 0)
	/* Search - Lower/Upper Age Limit */
AND
	(
	--- either use the fn_rpt_DonorAgeYear or ignore
		(
			dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit)
			BETWEEN @LowerAgeLimit AND @UpperAgeLimit
		)
	OR
		(
			ISNULL(@LowerAgeLimit, 0) = 0
		AND ISNULL(@UpperAgeLimit, 0) = 0
		)
	)		
	/* Search - Coordinator */
AND IsNull(Call.StatEmployeeID, 0) = ISNULL(@CoordinatorID, IsNull(Call.StatEmployeeID, 0))
	/* Search - Gender */
AND IsNull(Referral.ReferralDonorGender, 0) = ISNULL(@Gender, IsNull(Referral.ReferralDonorGender,0))
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
AND
	(
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
	OR
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
		AND	Referral.ReferralValvesConversionID IN (-1,0,9) --Recovery NULL or Unknown
		)
	OR
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
	)
GROUP BY
	Referral.ReferralTypeID,
	[Call].CallID,
	LT.CallDateTime,
	Referral.ReferralDonorLastName,
	Referral.ReferralDonorFirstName,
	Referral.ReferralDonorNameMI,
	Referral.ReferralDonorAge,
	Referral.ReferralDonorAgeUnit,
	Referral.ReferralDonorGender,
	Organization.OrganizationName,
	Race.RaceName,
	Referral.ReferralOrganAppropriateID,
	Referral.ReferralOrganApproachID,
	Referral.ReferralOrganConsentID,
	Referral.ReferralOrganConversionID,
	Referral.ReferralBoneAppropriateID,
	Referral.ReferralBoneApproachID,
	Referral.ReferralBoneConsentID,
	Referral.ReferralBoneConversionID,
	Referral.ReferralTissueAppropriateID,
	Referral.ReferralTissueApproachID,
	Referral.ReferralTissueConsentID,
	Referral.ReferralTissueConversionID,
	Referral.ReferralSkinAppropriateID,
	Referral.ReferralSkinApproachID,
	Referral.ReferralSkinConsentID,
	Referral.ReferralSkinConversionID,
	Referral.ReferralValvesAppropriateID,
	Referral.ReferralValvesApproachID,
	Referral.ReferralValvesConsentID,
	Referral.ReferralValvesConversionID,
	Referral.ReferralEyesTransAppropriateID,
	Referral.ReferralEyesTransApproachID,
	Referral.ReferralEyesTransConsentID,
	Referral.ReferralEyesTransConversionID,
	Referral.ReferralEyesRschAppropriateID,
	Referral.ReferralEyesRschApproachID,
	Referral.ReferralEyesRschConsentID,
	Referral.ReferralEyesRschConversionID,
	ReferralDonorLSADate,
	ReferralDonorLSATime,
	ReferralDonorDeathDate,
	ReferralDonorDeathTime