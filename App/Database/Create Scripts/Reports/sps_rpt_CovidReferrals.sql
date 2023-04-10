IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_CovidReferrals')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_CovidReferrals';
		DROP  PROCEDURE  sps_rpt_CovidReferrals;
	END

GO

PRINT 'Creating Procedure sps_rpt_CovidReferrals';

GO

CREATE PROCEDURE sps_rpt_CovidReferrals
(
	@ReportGroupID	int,
	@StartDate		datetime,
	@EndDate		datetime
)
AS
/******************************************************************************
**		File: sps_rpt_CovidReferrals.sql
**		Name: sps_rpt_CovidReferrals
**		Desc: Referrals likely to be ruled out for Covid-19
**
**		Called by:   Covid Referrals Report
**              
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		02/16/2021	James Gerberich		Initial design
*******************************************************************************/

--DECLARE
--	@ReportGroupID	int			= 57, -- CO- Donor Alliance- Organ(All Referrals)
--	@StartDate		datetime	= '04/01/2020',
--	@EndDate		datetime	= GETDATE();
----------------------------------------------------------------

WITH RptGrp AS
(
	Select
		rptGrp.WebReportGroupID,
		org.OrganizationName + ' (' + rptGrp.WebReportGroupName + ')' AS ReportGroup
	From
		dbo.WebReportGroup rptGrp
		INNER JOIN dbo.Organization org ON rptGrp.OrgHierarchyParentID = org.OrganizationID
	Where rptGrp.WebReportGroupID = @ReportGroupID
)
----------------------------------------------------------------

SELECT
	RptGrp.ReportGroup,
	c.CallID AS ReferralNumber,
	refFac.OrganizationName AS ReferralFacility,
	c.CallDateTime,
	r.ReferralDonorAge,
	r.ReferralDonorAgeUnit,
	r.ReferralDonorGender,
	r.ReferralDonorAdmitDate,
	r.ReferralDonorAdmitTime,
	r.ReferralDonorDeathDate,
	r.ReferralDonorDeathTime,
	r.ReferralDonorOnVentilator,
	r.ReferralNotesCase AS MedHx,
	organ.AppropriateName AS OrganAppropriate,
	bone.AppropriateName AS BoneAppropriate,
	tissue.AppropriateName AS TissueAppropriate,
	skin.AppropriateName AS SkinAppropriate,
	valve.AppropriateName AS ValveAppropriate
FROM
	dbo.[Call] c
	INNER JOIN dbo.Referral r
			INNER JOIN WebReportGroupOrg rptGrpOrg
					INNER JOIN RptGrp ON RptGrp.WebReportGroupID = rptGrpOrg.WebReportGroupID
				ON r.ReferralCallerOrganizationID = rptGrpOrg.OrganizationID
			INNER JOIN dbo.Organization refFac ON r.ReferralCallerOrganizationID = refFac.OrganizationID
			LEFT JOIN dbo.Appropriate organ ON	r.ReferralOrganAppropriateID = organ.AppropriateID
			LEFT JOIN dbo.Appropriate bone ON	r.ReferralBoneAppropriateID = bone.AppropriateID
			LEFT JOIN dbo.Appropriate tissue ON r.ReferralTissueAppropriateID = tissue.AppropriateID
			LEFT JOIN dbo.Appropriate skin ON	r.ReferralSkinAppropriateID = skin.AppropriateID
			LEFT JOIN dbo.Appropriate valve ON	r.ReferralValvesAppropriateID = valve.AppropriateID
		ON c.CallID = r.CallID
WHERE
	c.CallDateTime >= @StartDate
AND	c.CallDateTime < @EndDate
AND	r.ReferralDonorDeathDate IS NOT NULL
AND	(
		PATINDEX('%negative%', r.ReferralNotesCase) = 0
	AND	(
			PATINDEX('% covid%', r.ReferralNotesCase) > 0
		OR	PATINDEX('% coronavirus %', r.ReferralNotesCase) > 0
		)
	)
AND	(
		r.ReferralOrganAppropriateID = 4 --Med RO
	OR	r.ReferralOrganAppropriateID = 5 --Not Appropriate
	OR	r.ReferralBoneAppropriateID = 4
	OR	r.ReferralBoneAppropriateID = 5
	OR	r.ReferralTissueAppropriateID = 4
	OR	r.ReferralTissueAppropriateID = 5
	OR	r.ReferralSkinAppropriateID = 4
	OR	r.ReferralSkinAppropriateID = 5
	OR	r.ReferralValvesAppropriateID = 4
	OR	r.ReferralValvesAppropriateID = 5
	)
ORDER BY
	c.CallDateTime;