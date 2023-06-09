SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionTriageDisposition]') and OBJECTPROPERTY(id,
	N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionTriageDisposition]
GO


CREATE PROCEDURE sps_SecondaryDispositionTriageDisposition 
	@Callid INT 
AS
/******************************************************************************
**		File: sps_SecondaryDispositionTriageDisposition.sql
**		Name: sps_SecondaryDispositionTriageDisposition
**		Desc: 
**
**              
**		Return values: returns disposition information for Secondary
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**  @CallID int,
**		Auth: Dave Hoffman
**		Date: 09/01/2001
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		05/25/07	Bret Knoll			Add description comment. 
**										Could not set read transaction level
*******************************************************************************/
SELECT 
	t.ReferralID,
	t.CallID,
	t.DonorCategoryID,
	t.DonorCategoryName,
	t.AppropriateID,
	t.ApproachID,
	t.ConsentID,
	t.ConversionID,
	a.FSAppropriateName AppropriateName,
	ac.ApproachName,
	c.ConsentName,
	r.ConversionName
FROM (
		SELECT 
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
			r.ReferralID,
			r.CallID,
			dc.DonorCategoryID,
			dc.DonorCategoryName
		FROM 
			Referral r,
			DonorCategory dc
		WHERE 
			CallID = @Callid) t
LEFT OUTER JOIN 
	Conversion r    ON t.ConversionID = r.ConversionID 
LEFT OUTER JOIN 
	Consent c       ON t.ConsentID = c.ConsentID 
LEFT OUTER JOIN 
	Approach ac     ON t.ApproachID = ac.ApproachID 
LEFT OUTER JOIN 
	FSAppropriate a ON t.AppropriateID = a.FSAppropriateID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

