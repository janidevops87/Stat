SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionRetrieveIndications]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionRetrieveIndications]
GO


CREATE PROCEDURE sps_SecondaryDispositionRetrieveIndications 
	@CallID   INT AS

/******************************************************************************
**		File: sps_SecondaryDispositionRetrieveIndications.sql
**		Name: sps_SecondaryDispositionRetrieveIndications
**		Desc: Obtains list of secondary disposition indications
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
**		05/25/07	Bret Knoll			added comment documentation.
**										Cannot add set read transaction level
*******************************************************************************/
SELECT j.CallID, j.CriteriaID, j.DonorCategoryID, sc.SubCriteriaID, st.SubTypeID, st.SubTypeName, sc.ProcessorID, o.OrganizationName AS ProcessorName, fsi.FSIndicationName
FROM (SELECT cc.CallID,
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
FROM CallCriteria cc, DonorCategory dc, ServiceLevel sl
WHERE cc.ServiceLevelID = sl.ServiceLevelID
AND   cc.CallID         = @CallID) j,
     FSIndication fsi,
     SubCriteria sc,
     Organization o,
     ProcessorCriteria_ConditionalRO pccro,
     SubType st,
     CriteriaSubType cst
WHERE sc.ProcessorID = o.OrganizationID
AND   sc.SubCriteriaID = pccro.SubCriteriaID
AND   fsi.FSIndicationID = pccro.FSIndicationID
AND   st.SubTypeID = cst.SubTypeID
AND   sc.SubtypeID = cst.SubTypeID
AND   sc.CriteriaID = cst.CriteriaID
AND   sc.CriteriaID = j.CriteriaID
AND   sc.DonorCategoryID = j.DonorCategoryID
AND   pccro.FSConditionID <> 0
ORDER BY j.CallID, j.CriteriaID, j.DonorCategoryID, sc.SubCriteriaID, st.SubTypeName, ProcessorName, fsi.FSIndicationName

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

