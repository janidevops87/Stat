SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionRetrieveGrid1_OLD]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionRetrieveGrid1_OLD]
GO


CREATE PROCEDURE sps_SecondaryDispositionRetrieveGrid1_OLD
	@CallID   INT AS

SELECT j.CallID, j.CriteriaID, j.DonorCategoryID,
       DonorCategory = CASE
                         WHEN j.CriteriaID = 0 OR j.CriteriaID IS NULL THEN
                            DCN.DonorCategoryName
                            /*
                           BJK 12/30/03
                          (SELECT DonorCategoryName
                           FROM DonorCategory
                           WHERE DonorCategoryID = j.DonorCategoryID)
                           */
                         ELSE
                            ddc.DynamicDonorCategoryName 
                           /*
                           BJK 12/30/03
                           (SELECT DISTINCT ddc.DynamicDonorCategoryName
                            FROM Criteria c, DynamicDonorCategory ddc
                            WHERE c.DynamicDonorCategoryID = ddc.DynamicDonorCategoryID
                            AND c.CriteriaID               = j.CriteriaID)
                            */
                            
                         END,
       sc.SubCriteriaID, st.SubTypeID, st.SubTypeName, sc.ProcessorID, NULL btn1, NULL btn2, o.OrganizationName ProcessorName, 
       Appropriate = SecondaryDispositionAppropriate
       		      /*
       		      BJK 12/30/03
       		      (SELECT SecondaryDispositionAppropriate
                      FROM SecondaryDisposition
                      WHERE SubCriteriaID = sc.SubCriteriaID
                      AND   CallID        = @CallID)
                      */
                      ,
                      
       Approach =    SecondaryDispositionApproach
       		     /*
       		     BJK 12/30/03
       		     (SELECT SecondaryDispositionApproach
                      FROM SecondaryDisposition
                      WHERE SubCriteriaID = sc.SubCriteriaID
                      AND   CallID        = @CallID)
                      */
                      ,
                      
       Consent =     SecondaryDispositionConsent
       		     /*
       		     BJK 12/30/03
       		     (SELECT SecondaryDispositionConsent
                      FROM SecondaryDisposition
                      WHERE SubCriteriaID = sc.SubCriteriaID
                      AND   CallID        = @CallID)
                      */
                      ,
       Recovery =    SecondaryDispositionConversion
       		      /*
       		      BJK 12/30/03 
       		      (SELECT SecondaryDispositionConversion
                      FROM SecondaryDisposition
                      WHERE SubCriteriaID = sc.SubCriteriaID
                      AND   CallID        = @CallID)
                      */
                      , NULL buffer, 
       j.SLAppropriate, j.SLApproach, j.SLConsent, j.SLRecovery, 
       ARO = 
		CASE 
			WHEN j.DonorCategoryID = 1 AND r.ReferralOrganAppropriateID      = 1 THEN 0
			WHEN j.DonorCategoryID = 2 AND r.ReferralBoneAppropriateID       = 1 THEN 0
			WHEN j.DonorCategoryID = 3 AND r.ReferralTissueAppropriateID     = 1 THEN 0
			WHEN j.DonorCategoryID = 4 AND r.ReferralSkinAppropriateID       = 1 THEN 0
			WHEN j.DonorCategoryID = 5 AND r.ReferralValvesAppropriateID     = 1 THEN 0
			WHEN j.DonorCategoryID = 6 AND r.ReferralEyesTransAppropriateID  = 1 THEN 0
			WHEN j.DonorCategoryID = 7 AND r.ReferralEyesRschAppropriateID   = 1 THEN 0
			ELSE -1
		END
		/*
		BJK 12/30/03
       	     (
       	      SELECT 
       	      		CASE 
			       WHEN j.DonorCategoryID = 1 AND r.ReferralOrganAppropriateID      = 1 THEN 0
			       WHEN j.DonorCategoryID = 2 AND r.ReferralBoneAppropriateID       = 1 THEN 0
			       WHEN j.DonorCategoryID = 3 AND r.ReferralTissueAppropriateID     = 1 THEN 0
			       WHEN j.DonorCategoryID = 4 AND r.ReferralSkinAppropriateID       = 1 THEN 0
			       WHEN j.DonorCategoryID = 5 AND r.ReferralValvesAppropriateID     = 1 THEN 0
			       WHEN j.DonorCategoryID = 6 AND r.ReferralEyesTransAppropriateID  = 1 THEN 0
			       WHEN j.DonorCategoryID = 7 AND r.ReferralEyesRschAppropriateID   = 1 THEN 0
			       ELSE -1
	                END
		FROM	Referral r
        	WHERE	 r.CallID = @CallID)
        	*/
        	, 
        	
        CRO = ISNULL(SecondaryDispositionCRO, 0)
        	     /*
        	     BJK 12/30/03
        	     (SELECT SecondaryDispositionCRO
                      FROM SecondaryDisposition
                      WHERE SubCriteriaID = sc.SubCriteriaID
                      AND   CallID        = @CallID), 0)*/ , 0 PRO	--1/10/03 drh
FROM ServiceLevel sl 
INNER JOIN (SELECT cc.CallID,
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
	AND   cc.CallID         = @CallID) j ON sl.ServiceLevelID = j.ServiceLevelID 
	LEFT OUTER JOIN SubCriteria sc 
	INNER JOIN Organization o ON sc.ProcessorID = o.OrganizationID 
	RIGHT OUTER JOIN SubType st 
	INNER JOIN CriteriaSubType cst ON st.SubTypeID = cst.SubTypeID ON sc.SubtypeID = cst.SubTypeID AND sc.CriteriaID = cst.CriteriaID ON j.CriteriaID = sc.CriteriaID AND j.DonorCategoryID = sc.DonorCategoryID
	
	LEFT JOIN Referral r ON r.CallID = j.CallID
	LEFT JOIN DonorCategory DCN ON DCN.DonorCategoryID =  j.DonorCategoryID 	
	LEFT JOIN SecondaryDisposition SD ON SD.SubCriteriaID = sc.SubCriteriaID AND SD.CallID = j.CallID
	LEFT JOIN Criteria c ON c.CriteriaID = j.CriteriaID
	LEFT JOIN DynamicDonorCategory ddc ON ddc.DynamicDonorCategoryID = c.DynamicDonorCategoryID
	
ORDER BY --j.CallID, 
	 j.DonorCategoryID, cst.SubCriteriaPrecedence, sc.ProcessorPrecedence, sc.SUBCRITERIAID



RETURN @@ROWCOUNT
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

