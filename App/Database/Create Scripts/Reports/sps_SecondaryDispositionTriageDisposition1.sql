IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = object_id(N'[dbo].[sps_SecondaryDispositionTriageDisposition1]') AND	OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_SecondaryDispositionTriageDisposition1';
		DROP PROCEDURE sps_SecondaryDispositionTriageDisposition1;
	END
GO

PRINT 'Creating Procedure: sps_SecondaryDispositionTriageDisposition1';
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

CREATE PROCEDURE [dbo].[sps_SecondaryDispositionTriageDisposition1]
(
	@CallID	int	= NULL
)
AS
/******************************************************************************
**	File: sps_SecondaryDispositionTriageDisposition1.sql
**	Name: sps_SecondaryDispositionTriageDisposition1
**	Desc: This stored procedure returns a list of (secondary) dispositions for
**		  given CallID and is an option for display in ReferralDetail
**
**	THIS REPLACES sps_SecondaryDispositionTriageDisposition BECAUSE IT DIDN'T USE DYNAMIC CATEGORY NAME
**	Return values:
**
**	Called by: ReferralDetail_Secondary.rdl
**
**	Parameters:
**	Input			Output
**	---------		-----------
**	@CallID
**
**	Auth: jth
**	Date: 10/9/2009
**
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author			Description:
**	--------	--------		-------------------------------------------
**
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
	t.ReferralID,
	t.CallID,
	t.DonorCategoryID,
	t.CategoryName,
	t.AppropriateID,
	t.ApproachID,
	t.ConsentID,
	t.ConversionID,
	a.FSAppropriateName AppropriateName,
	ac.ApproachName,
	c.ConsentName,
	r.ConversionName
FROM
(
	SELECT
		r.ReferralID,
		r.CallID,
		dc.DonorCategoryID,
		CASE dc.DonorCategoryID
			WHEN 1 THEN r.ReferralOrganAppropriateID
			WHEN 2 THEN r.ReferralBoneAppropriateID
			WHEN 3 THEN r.ReferralTissueAppropriateID
			WHEN 4 THEN r.ReferralSkinAppropriateID
			WHEN 5 THEN r.ReferralValvesAppropriateID
			WHEN 6 THEN r.ReferralEyesTransAppropriateID
			WHEN 7 THEN r.ReferralEyesRschAppropriateID
		END AppropriateID,
		CASE dc.DonorCategoryID
			WHEN 1 THEN r.ReferralOrganApproachID
			WHEN 2 THEN r.ReferralBoneApproachID
			WHEN 3 THEN r.ReferralTissueApproachID
			WHEN 4 THEN r.ReferralSkinApproachID
			WHEN 5 THEN r.ReferralValvesApproachID
			WHEN 6 THEN r.ReferralEyesTransApproachID
			WHEN 7 THEN r.ReferralEyesRschApproachID
		END ApproachID,
		CASE dc.DonorCategoryID
			WHEN 1 THEN r.ReferralOrganConsentID
			WHEN 2 THEN r.ReferralBoneConsentID
			WHEN 3 THEN r.ReferralTissueConsentID
			WHEN 4 THEN r.ReferralSkinConsentID
			WHEN 5 THEN r.ReferralValvesConsentID
			WHEN 6 THEN r.ReferralEyesTransConsentID
			WHEN 7 THEN r.ReferralEyesRschConsentID
		END ConsentID,
		CASE dc.DonorCategoryID
			WHEN 1 THEN r.ReferralOrganConversionID
			WHEN 2 THEN r.ReferralBoneConversionID
			WHEN 3 THEN r.ReferralTissueConversionID
			WHEN 4 THEN r.ReferralSkinConversionID
			WHEN 5 THEN r.ReferralValvesConversionID
			WHEN 6 THEN r.ReferralEyesTransConversionID
			WHEN 7 THEN r.ReferralEyesRschConversionID
		END ConversionID,
		CASE dc.DonorCategoryID
			WHEN 1
			THEN
			(
				SELECT DynamicDonorCategory.DynamicDonorCategoryName
				FROM
					Criteria
					INNER JOIN CallCriteria ON Criteria.CriteriaID = CallCriteria.OrganCriteriaID
					INNER JOIN DynamicDonorCategory ON Criteria.DynamicDonorCategoryID = DynamicDonorCategory.DynamicDonorCategoryID
				WHERE CallCriteria.CallID = @CallID
			)
			WHEN 2
			THEN
			(
				SELECT DynamicDonorCategory.DynamicDonorCategoryName
				FROM
					Criteria
					INNER JOIN CallCriteria ON Criteria.CriteriaID = CallCriteria.BoneCriteriaID
					INNER JOIN DynamicDonorCategory ON Criteria.DynamicDonorCategoryID = DynamicDonorCategory.DynamicDonorCategoryID
				WHERE CallCriteria.CallID = @CallID
			)
			WHEN 3
			THEN
			(
				SELECT DynamicDonorCategory.DynamicDonorCategoryName
				FROM
					Criteria
					INNER JOIN CallCriteria ON Criteria.CriteriaID = CallCriteria.TissueCriteriaID
					INNER JOIN DynamicDonorCategory ON Criteria.DynamicDonorCategoryID = DynamicDonorCategory.DynamicDonorCategoryID
				WHERE CallCriteria.CallID = @CallID
			)
			WHEN 4
			THEN
			(
				SELECT DynamicDonorCategory.DynamicDonorCategoryName
				FROM
					Criteria
					INNER JOIN CallCriteria ON Criteria.CriteriaID = CallCriteria.SkinCriteriaID
					INNER JOIN DynamicDonorCategory ON Criteria.DynamicDonorCategoryID = DynamicDonorCategory.DynamicDonorCategoryID
				WHERE CallCriteria.CallID = @CallID
			)
			WHEN 5
			THEN
			(
				SELECT DynamicDonorCategory.DynamicDonorCategoryName
				FROM
					Criteria
					INNER JOIN CallCriteria ON Criteria.CriteriaID = CallCriteria.ValvesCriteriaID
					INNER JOIN DynamicDonorCategory ON Criteria.DynamicDonorCategoryID = DynamicDonorCategory.DynamicDonorCategoryID
				WHERE CallCriteria.CallID = @CallID
			)
			WHEN 6
			THEN
			(
				SELECT DynamicDonorCategory.DynamicDonorCategoryName
				FROM
					Criteria INNER JOIN CallCriteria ON Criteria.CriteriaID = CallCriteria.EyesCriteriaID
					INNER JOIN DynamicDonorCategory ON Criteria.DynamicDonorCategoryID = DynamicDonorCategory.DynamicDonorCategoryID
				WHERE CallCriteria.CallID = @CallID
			)
			WHEN 7
			THEN
			(
				SELECT DynamicDonorCategory.DynamicDonorCategoryName
				FROM
					Criteria
					INNER JOIN CallCriteria ON Criteria.CriteriaID = CallCriteria.OtherCriteriaID
					INNER JOIN DynamicDonorCategory ON Criteria.DynamicDonorCategoryID = DynamicDonorCategory.DynamicDonorCategoryID
				WHERE CallCriteria.CallID = @CallID
			)
		END CategoryName
		FROM
			Referral r,
			DonorCategory dc
		WHERE CallID = @Callid
	) t
	LEFT JOIN Conversion r    ON t.ConversionID = r.ConversionID
	LEFT JOIN Consent c       ON t.ConsentID = c.ConsentID
	LEFT JOIN Approach ac     ON t.ApproachID = ac.ApproachID
	LEFT JOIN FSAppropriate a ON t.AppropriateID = a.FSAppropriateID;

GO
