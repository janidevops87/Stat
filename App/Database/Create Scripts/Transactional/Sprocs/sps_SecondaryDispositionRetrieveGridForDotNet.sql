SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionRetrieveGridForDotNet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionRetrieveGridForDotNet]
GO

CREATE PROCEDURE sps_SecondaryDispositionRetrieveGridForDotNet 
	@CallID   INT 

AS
/******************************************************************************
**		File: sps_SecondaryDispositionRetrieveGridForDotNet.sql
**		Name: sps_SecondaryDispositionRetrieveGridForDotNet
**		Desc: 
**
**              
**		Return values: 
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**  @CallID int,
**		Auth: Dave Hoffmann
**		Date: 09/01/2001
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		2/15/05		Scott Plummer - SAP	Rewrote query to use table variable for join*****										instead of joining to subselect after
**										timeouts and slow queries appearing.
**		05/25/07	Bret Knoll			Add Comment block
**										Cannot use read transaction level
**		04/2010		Bret Knoll			Created new Sproc from sps_SecondaryDispositionRetrieveGrid to add column for processor sort
*******************************************************************************/
SET NOCOUNT ON

DECLARE @dispTbl Table (CallID Int,
			CriteriaID Int,
			DonorCategoryID Int,
			ServiceLevelID Int,
			SLAppropriate Int,
			SLApproach Int,
			SLConsent Int,
			SLRecovery Int
			) 

-- First, get the donor category information for this call and insert
-- it into a table variable to be used to join to the larger query below.
INSERT INTO @dispTbl
SELECT cc.CallID,
       CASE dc.DonorCategoryID
         WHEN 1 THEN cc.OrganCriteriaID
         WHEN 2 THEN cc.BoneCriteriaID
         WHEN 3 THEN cc.TissueCriteriaID
         WHEN 4 THEN cc.SkinCriteriaID
         WHEN 5 THEN cc.ValvesCriteriaID
         WHEN 6 THEN cc.EyesCriteriaID
         WHEN 7 THEN cc.OtherCriteriaID
         ELSE 0
       END CriteriaID,
       dc.DonorCategoryID, cc.ServiceLevelID,
       CASE dc.DonorCategoryID
         WHEN 1 THEN sl.ServiceLevelAppropriateOrgan
         WHEN 2 THEN sl.ServiceLevelAppropriateBone
         WHEN 3 THEN sl.ServiceLevelAppropriateTissue
         WHEN 4 THEN sl.ServiceLevelAppropriateSkin
         WHEN 5 THEN sl.ServiceLevelAppropriateValves
         WHEN 6 THEN sl.ServiceLevelAppropriateEyes
         WHEN 7 THEN sl.ServiceLevelAppropriateRsch
         ELSE 0
       END SLAppropriate,
       CASE dc.DonorCategoryID
         WHEN 1 THEN sl.ServiceLevelApproachOrgan
         WHEN 2 THEN sl.ServiceLevelApproachBone
         WHEN 3 THEN sl.ServiceLevelApproachTissue
         WHEN 4 THEN sl.ServiceLevelApproachSkin
         WHEN 5 THEN sl.ServiceLevelApproachValves
         WHEN 6 THEN sl.ServiceLevelApproachEyes
         WHEN 7 THEN sl.ServiceLevelApproachRsch
         ELSE 0
       END SLApproach,
       CASE dc.DonorCategoryID
         WHEN 1 THEN sl.ServiceLevelConsentOrgan
         WHEN 2 THEN sl.ServiceLevelConsentBone
         WHEN 3 THEN sl.ServiceLevelConsentTissue
         WHEN 4 THEN sl.ServiceLevelConsentSkin
         WHEN 5 THEN sl.ServiceLevelConsentValves
         WHEN 6 THEN sl.ServiceLevelConsentEyes
         WHEN 7 THEN sl.ServiceLevelConsentRsch
         ELSE 0
       END SLConsent,
       CASE dc.DonorCategoryID
         WHEN 1 THEN sl.ServiceLevelRecoveryOrgan
         WHEN 2 THEN sl.ServiceLevelRecoveryBone
         WHEN 3 THEN sl.ServiceLevelRecoveryTissue
         WHEN 4 THEN sl.ServiceLevelRecoverySkin
         WHEN 5 THEN sl.ServiceLevelRecoveryValves
         WHEN 6 THEN sl.ServiceLevelRecoveryEyes
         WHEN 7 THEN sl.ServiceLevelRecoveryRsch
         ELSE 0
       END SLRecovery
	FROM CallCriteria cc, DonorCategory dc,ServiceLevel sl 
	WHERE cc.ServiceLevelID = sl.ServiceLevelID
	AND cc.CallID = @CallId;

-- Now use the table created above (aliased as J) to join to data from other tables.
SELECT J.CallID, J.CriteriaID, J.DonorCategoryID,
       DonorCategory = CASE
                         WHEN J.CriteriaID = 0 OR J.CriteriaID IS NULL THEN
                            DCN.DonorCategoryName
                         ELSE
                            ddc.DynamicDonorCategoryName 
                         END,
       sc.SubCriteriaID, st.SubTypeID, st.SubTypeName, sc.ProcessorID, 
       NULL btn1, NULL btn2, o.OrganizationName ProcessorName, 
       Appropriate = SecondaryDispositionAppropriate,  
       Approach =    SecondaryDispositionApproach,  
       Consent =     SecondaryDispositionConsent,
       Recovery =    SecondaryDispositionConversion, NULL buffer, 
       J.SLAppropriate, J.SLApproach, J.SLConsent, J.SLRecovery, 
       ARO = CASE 
			WHEN J.DonorCategoryID = 1 AND r.ReferralOrganAppropriateID      = 1 THEN 0
			WHEN J.DonorCategoryID = 2 AND r.ReferralBoneAppropriateID       = 1 THEN 0
			WHEN J.DonorCategoryID = 3 AND r.ReferralTissueAppropriateID     = 1 THEN 0
			WHEN J.DonorCategoryID = 4 AND r.ReferralSkinAppropriateID       = 1 THEN 0
			WHEN J.DonorCategoryID = 5 AND r.ReferralValvesAppropriateID     = 1 THEN 0
			WHEN J.DonorCategoryID = 6 AND r.ReferralEyesTransAppropriateID  = 1 THEN 0
			WHEN J.DonorCategoryID = 7 AND r.ReferralEyesRschAppropriateID   = 1 THEN 0
			ELSE -1
		END,
        CRO = ISNULL(SecondaryDispositionCRO, 0), 0 PRO	,
        ProcessorOrder = COALESCE(sc.ProcessorPrecedence, 0)

FROM ServiceLevel sl 
	INNER JOIN @dispTbl J ON sl.ServiceLevelID = J.ServiceLevelID 
	LEFT OUTER JOIN SubCriteria sc 
	INNER JOIN Organization o ON sc.ProcessorID = o.OrganizationID 
	RIGHT OUTER JOIN SubType st 
	INNER JOIN CriteriaSubType cst ON st.SubTypeID = cst.SubTypeID ON sc.SubtypeID = cst.SubTypeID 
		AND sc.CriteriaID = cst.CriteriaID ON J.CriteriaID = sc.CriteriaID AND J.DonorCategoryID = sc.DonorCategoryID
	LEFT JOIN Referral r ON r.CallID = J.CallID
	LEFT JOIN DonorCategory DCN ON DCN.DonorCategoryID =  J.DonorCategoryID 	
	LEFT JOIN SecondaryDisposition SD (NOLOCK) ON SD.CallID = J.CallID AND SD.SubCriteriaID = sc.SubCriteriaID
	LEFT JOIN Criteria c ON c.CriteriaID = J.CriteriaID
	LEFT JOIN DynamicDonorCategory ddc ON ddc.DynamicDonorCategoryID = c.DynamicDonorCategoryID
	
ORDER BY J.DonorCategoryID, cst.SubCriteriaPrecedence, ProcessorOrder, sc.SUBCRITERIAID;

RETURN @@ROWCOUNT;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 