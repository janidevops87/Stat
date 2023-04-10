IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AgeDemographics_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AgeDemographics_Select'
		DROP  Procedure  sps_rpt_AgeDemographics_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_AgeDemographics_Select'

GO

CREATE Procedure sps_rpt_AgeDemographics_Select
	(
		@ReferralStartDateTime	DateTime,
		@ReferralEndDateTime	DateTime,
		@CardiacStartDateTime	DateTime,
		@CardiacEndDateTime		DateTime,
		@AgeRange				Bit,	-- 0 = 10 years, 1 = 5 years
		@ReportGroupID			Int,
		@OrganizationID			Int,
		@SourceCodeName			VarChar(10),
		@DisplayMT				Int
	)
AS
/******************************************************************************
**		File: 
**		Name: sps_rpt_AgeDemographics_Select
**		Desc: Referrals broken down by Age
**
**		Called by:   Age Demographics Report
**              
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		3/8/10	James Gerberich		Initial design
**		
**		
**		
**		
*******************************************************************************/
----------------------------------------------------------------------------
/*
Referral Type
	1	Organ/Tissue/Eye
	2	Tissue/Eye
	3	Eyes Only
	4	Ruleout

----------------------------------------------------------------------------

Registry Status Type
	1	StateRegistry
	2	WebRegistry
	3	Not on Registry
	4	Manually Found
	5	Not Checked
*/
----------------------------------------------------------------------------

--DECLARE
--	@ReferralStartDateTime	DateTime,
--	@ReferralEndDateTime	DateTime,
--	@CardiacStartDateTime	DateTime,
--	@CardiacEndDateTime		DateTime,
--	@AgeRange				Bit,	-- 0 = 10 years, 1 = 5 years
--	@ReportGroupID			Int,
--	@OrganizationID			Int,
--	@SourceCodeName			VarChar(10),
--	@DisplayMT				Int

--SELECT
--	@ReferralStartDateTime	=	'2010-03-01 00:00:00', --CAST (DATEPART(yyyy,GETDATE())AS VarChar) + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(mm,GETDATE())),2) + '-' + '01',
--	@ReferralEndDateTime	=	'2010-04-03 00:00:00', --CAST (DATEPART(yyyy,GETDATE())AS VarChar) + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(mm,GETDATE())),2)  + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(dd,GETDATE())),2)
--	@CardiacStartDateTime	=	NULL,
--	@CardiacEndDateTime		=	NULL,
--	@AgeRange				=	0, --1
--	@ReportGroupID			=	37,
--	@OrganizationID			=	NULL,
--	@SourceCodeName			=	'OROP',
--	@DisplayMT				=	0

----------------------------------------------------------------------------

--It is possible for a Donor's Registry Status to change over time, so get the latest.

DECLARE
	@RegStatus	TABLE
		(
			CallID			Int,
			RegistryStatus	Int,
			ModDate			DateTime
		)

INSERT INTO
	@RegStatus
		SELECT
			CallID,
			RegistryStatus,
			Max(LastModified)
		FROM
			RegistryStatus
		GROUP BY
			CallID,
			RegistryStatus

----------------------------------------------------------------------------

SELECT
	o.OrganizationID,
	o.OrganizationName,
	p.PersonID,
	p.PersonLast + ', ' + p.PersonFirst,
	r.CallID,
	r.ReferralDonorName,
	rg.RegistryStatus,
	rs.RegistryType,
	r.ReferralDonorRaceID,
	ISNULL(ra.RaceName, 'Was Not Given'),
	CASE
		WHEN r.ReferralDonorGender = 'F'
			THEN 'Female'
		WHEN r.ReferralDonorGender = 'M'
			THEN 'Male'
		ELSE 'Was Not Given'
	END	AS ReferralDonorGender,
	CASE
		WHEN r.ReferralDonorAgeUnit = 'Days'
			THEN r.ReferralDonorAge/365
		WHEN r.ReferralDonorAgeUnit = 'Months'
			THEN r.ReferralDonorAge/12
		ELSE r.ReferralDonorAge
	END AS DonorAgeYears,
	NULL AS AgeRange,
	r.ReferralTypeID,
	rt.ReferralTypeName,
	r.ReferralOrganAppropriateID,
	ao.AppropriateName		AS	AppOrgan,
	r.ReferralBoneAppropriateID,
	ab.AppropriateName		AS	AppBone,
	r.ReferralTissueAppropriateID,
	at.AppropriateName		AS	AppTissue,
	r.ReferralSkinAppropriateID,
	[as].AppropriateName	AS	AppSkin,
	r.ReferralValvesAppropriateID,
	av.AppropriateName		AS	AppValve,
	r.ReferralEyesTransAppropriateID,
	ae.AppropriateName		AS	AppEyes,
	r.ReferralAllTissueDispositionID,
	aa.AppropriateName		AS	AppOther,
	ct.CallTypeName
FROM
	Referral r
	INNER JOIN		[Call] c				ON r.CallID = c.CallID
	INNER JOIN		Person p				ON r.ReferralCallerPersonID = p.PersonID
	INNER JOIN		Organization o			ON p.OrganizationID = o.OrganizationID
	INNER JOIN		CallType ct				ON c.CallTypeID = ct.CallTypeID
	INNER JOIN
		(
			SELECT
				CallID,
				CallDateTime
			FROM
				dbo.fn_rpt_ReferralDateTimeConversion 
					(
						Null					,
						@ReferralStartDateTime	,
						@ReferralEndDateTime	,
						@CardiacStartDateTime	,
						@CardiacEndDateTime		,
						@DisplayMT
					)
		) LT ON LT.CallID = c.CallID
	LEFT OUTER JOIN ReferralType rt			ON r.ReferralTypeID = rt.ReferralTypeID
	LEFT OUTER JOIN @RegStatus rg			ON r.CallID = rg.CallID
	LEFT OUTER JOIN RegistryStatusType rs	ON rg.RegistryStatus = rs.ID
	LEFT OUTER JOIN	Race ra					ON ra.RaceID = r.ReferralDonorRaceID
	LEFT OUTER JOIN Appropriate ao			ON ao.AppropriateID = r.ReferralOrganAppropriateID
	LEFT OUTER JOIN Appropriate ab			ON ab.AppropriateID = r.ReferralBoneAppropriateID
	LEFT OUTER JOIN Appropriate [at]		ON [at].AppropriateID = r.ReferralTissueAppropriateID
	LEFT OUTER JOIN Appropriate [as]		ON [as].AppropriateID = r.ReferralSkinAppropriateID
	LEFT OUTER JOIN Appropriate av			ON av.AppropriateID = r.ReferralValvesAppropriateID
	LEFT OUTER JOIN Appropriate ae			ON ae.AppropriateID = r.ReferralEyesTransAppropriateID
	LEFT OUTER JOIN Appropriate aa			ON aa.AppropriateID = r.ReferralAllTissueDispositionID
	LEFT OUTER JOIN WebReportGroupOrg wr	ON wr.OrganizationID = r.ReferralCallerOrganizationID
WHERE
	c.SourceCodeID IN
		(
			SELECT DISTINCT * 
			FROM
			dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName)
		)
AND r.ReferralCallerOrganizationID = ISNULL(@OrganizationID, r.ReferralCallerOrganizationID)
AND wr.WebReportGroupID = ISNULL(@ReportGroupID, 0)
ORDER BY
	o.OrganizationName,
	p.PersonLast,
	p.PersonFirst,
	c.CallID,
	ct.CallTypeName

GRANT EXECUTE ON sps_rpt_AgeDemographics_Select TO PUBLIC