SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_IncompleteReferralCount]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_IncompleteReferralCount]
GO


CREATE FUNCTION fn_IncompleteReferralCount (@vReportGroupID int, @vStartDate datetime, @vEndDate  datetime, @vOrgId int, @vOrgType varchar(1))

RETURNS Integer  

-- Takes a ReportGroupId, start and end dates, and an OrganizationId
-- and returns the count of incomplete referrals for those params.
-- Logic based upon _ReferralProdReport.dbo.sps_IncompleteReferrals
-- 10/20/04 - SAP

AS  
BEGIN 

DECLARE @incompleteCount Integer,
	@vOrgTypeNumeric Integer

-- Set numeric ReferralType for specific O, T, or E views
IF @vOrgType = 'O'
	SET @vOrgTypeNumeric = 1
ELSE IF @vOrgType = 'T'
	SET @vOrgTypeNumeric = 2
ELSE IF @vOrgType = 'E'
	SET @vOrgTypeNumeric = 3
ELSE 
	SET @vOrgTypeNumeric = 0


IF @vOrgId = 0
     IF @vOrgTypeNumeric > 0  -- A specific organization type was selected
	SET @incompleteCount = 
	 (SELECT Count(DISTINCT Call.CallID) as ctr
	 FROM   Call
	 JOIN   Referral ON Referral.CallID = Call.CallID
	 JOIN   WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	 JOIN  WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID 
	 JOIN  ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	 JOIN  ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID
	 JOIN  Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	 WHERE  CallDateTime >= @vStartDate
	 AND   CallDateTime <= @vEndDate
	 AND  WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	 AND  WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	 AND  Referral.ReferralTypeId = @vOrgTypeNumeric
	 AND 
	 (
	   (  AccessOrgansUpdate = 1
	   AND  ReferralOrganAppropriateID = 1 
	   AND  (
	      (ServiceLevelApproachOrgan  = -1 
	      AND ReferralOrganApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralOrganApproachID = 2)
	     OR (ServiceLevelRecoveryOrgan  = -1 
	      AND ReferralOrganConsentID IN(1, 7, 8) 
	      AND ReferralOrganConversionID = -1))
	   )
	   OR
	   (  AccessBoneUpdate = 1
	   AND  ReferralBoneAppropriateID = 1 
	   AND  ((ServiceLevelApproachBone  = -1 
	      AND ReferralBoneApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralBoneApproachID = 2)
	     OR (ServiceLevelRecoveryBone  = -1 
	      AND ReferralBoneConsentID IN(1, 7, 8) 
	      AND ReferralBoneConversionID = -1))
	   ) 
	   OR
	   (  AccessTissueUpdate = 1
	   AND  ReferralTissueAppropriateID = 1 
	   AND  ((ServiceLevelApproachTissue  = -1 
	      AND ReferralTissueApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralTissueApproachID = 2)
	     OR (ServiceLevelRecoveryTissue  = -1 
	      AND ReferralTissueConsentID IN(1, 7, 8) 
	      AND ReferralTissueConversionID = -1))
	   )
	   OR
	   (  AccessSkinUpdate = 1
	   AND  ReferralSkinAppropriateID = 1 
	   AND  ((ServiceLevelApproachSkin  = -1 
	      AND ReferralSkinApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralSkinApproachID = 2)
	     OR (ServiceLevelRecoverySkin  = -1 
	      AND ReferralSkinConsentID IN(1, 7, 8) 
	      AND ReferralSkinConversionID = -1))
	   ) 
	   OR
	   (  AccessValvesUpdate = 1
	   AND  ReferralValvesAppropriateID = 1 
	   AND  ((ServiceLevelApproachValves  = -1 
	      AND ReferralValvesApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralValvesApproachID = 2)
	     OR (ServiceLevelRecoveryValves  = -1 
	      AND ReferralValvesConsentID IN(1, 7, 8)
	      AND ReferralValvesConversionID = -1))
	   )
	   OR
	   (  AccessEyesUpdate = 1
	   AND  ReferralEyesTransAppropriateID = 1 
	   AND  ((ServiceLevelApproachEyes  = -1 
	      AND ReferralEyesTransApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralEyesTransApproachID = 2)
	     OR (ServiceLevelRecoveryEyes  = -1 
	      AND ReferralEyesTransConsentID IN(1, 7, 8) 
	      AND ReferralEyesTransConversionID = -1))
	   ) 
	   OR
	   (  AccessResearchUpdate = 1
	   AND  ReferralEyesRschAppropriateID = 1 
	   AND  ((ServiceLevelApproachRsch  = -1 
	      AND ReferralEyesRschApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralEyesRschApproachID = 2)
	     OR (ServiceLevelRecoveryRsch  = -1 
	      AND ReferralEyesRschConsentID IN(1, 7, 8) 
	      AND ReferralEyesRschConversionID = -1))
	   )  
	 ));
     ELSE  -- No specific organization type was selected
	SET @incompleteCount = 
	 (SELECT Count(DISTINCT Call.CallID) as ctr
	 FROM   Call
	 JOIN   Referral ON Referral.CallID = Call.CallID
	 JOIN   WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	 JOIN  WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID 
	 JOIN  ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	 JOIN  ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID
	 JOIN  Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	 WHERE  CallDateTime >= @vStartDate
	 AND   CallDateTime <= @vEndDate
	 AND  WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	 AND  WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	 AND 
	 (
	   (  AccessOrgansUpdate = 1
	   AND  ReferralOrganAppropriateID = 1 
	   AND  (
	      (ServiceLevelApproachOrgan  = -1 
	      AND ReferralOrganApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralOrganApproachID = 2)
	     OR (ServiceLevelRecoveryOrgan  = -1 
	      AND ReferralOrganConsentID IN(1, 7, 8) 
	      AND ReferralOrganConversionID = -1))
	   )
	   OR
	   (  AccessBoneUpdate = 1
	   AND  ReferralBoneAppropriateID = 1 
	   AND  ((ServiceLevelApproachBone  = -1 
	      AND ReferralBoneApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralBoneApproachID = 2)
	     OR (ServiceLevelRecoveryBone  = -1 
	      AND ReferralBoneConsentID IN(1, 7, 8) 
	      AND ReferralBoneConversionID = -1))
	   ) 
	   OR
	   (  AccessTissueUpdate = 1
	   AND  ReferralTissueAppropriateID = 1 
	   AND  ((ServiceLevelApproachTissue  = -1 
	      AND ReferralTissueApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralTissueApproachID = 2)
	     OR (ServiceLevelRecoveryTissue  = -1 
	      AND ReferralTissueConsentID IN(1, 7, 8) 
	      AND ReferralTissueConversionID = -1))
	   )
	   OR
	   (  AccessSkinUpdate = 1
	   AND  ReferralSkinAppropriateID = 1 
	   AND  ((ServiceLevelApproachSkin  = -1 
	      AND ReferralSkinApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralSkinApproachID = 2)
	     OR (ServiceLevelRecoverySkin  = -1 
	      AND ReferralSkinConsentID IN(1, 7, 8) 
	      AND ReferralSkinConversionID = -1))
	   ) 
	   OR
	   (  AccessValvesUpdate = 1
	   AND  ReferralValvesAppropriateID = 1 
	   AND  ((ServiceLevelApproachValves  = -1 
	      AND ReferralValvesApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralValvesApproachID = 2)
	     OR (ServiceLevelRecoveryValves  = -1 
	      AND ReferralValvesConsentID IN(1, 7, 8)
	      AND ReferralValvesConversionID = -1))
	   )
	   OR
	   (  AccessEyesUpdate = 1
	   AND  ReferralEyesTransAppropriateID = 1 
	   AND  ((ServiceLevelApproachEyes  = -1 
	      AND ReferralEyesTransApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralEyesTransApproachID = 2)
	     OR (ServiceLevelRecoveryEyes  = -1 
	      AND ReferralEyesTransConsentID IN(1, 7, 8) 
	      AND ReferralEyesTransConversionID = -1))
	   ) 
	   OR
	   (  AccessResearchUpdate = 1
	   AND  ReferralEyesRschAppropriateID = 1 
	   AND  ((ServiceLevelApproachRsch  = -1 
	      AND ReferralEyesRschApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralEyesRschApproachID = 2)
	     OR (ServiceLevelRecoveryRsch  = -1 
	      AND ReferralEyesRschConsentID IN(1, 7, 8) 
	      AND ReferralEyesRschConversionID = -1))
	   )  
	 ));

ELSE  -- An OrgId was provided
     IF @vOrgTypeNumeric > 0  -- A specific organization type was selected
	SET @incompleteCount =
	 (SELECT Count(DISTINCT Call.CallID) as ctr
	 FROM   Call
	 JOIN   Referral ON Referral.CallID = Call.CallID
	 JOIN   WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	 JOIN  WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID 
	 JOIN  ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	 JOIN  ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID
	 JOIN  Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	 WHERE  CallDateTime >= @vStartDate
	 AND   CallDateTime <= @vEndDate
	 AND  WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	 AND  WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	 AND  Organization.OrganizationId = @vOrgId
	 AND  Referral.ReferralTypeId = @vOrgTypeNumeric
	 AND 
	 (
	   (  AccessOrgansUpdate = 1
	   AND  ReferralOrganAppropriateID = 1 
	   AND  (
	      (ServiceLevelApproachOrgan  = -1 
	      AND ReferralOrganApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralOrganApproachID = 2)
	     OR (ServiceLevelRecoveryOrgan  = -1 
	      AND ReferralOrganConsentID IN(1, 7, 8) 
	      AND ReferralOrganConversionID = -1))
	   )
	   OR
	   (  AccessBoneUpdate = 1
	   AND  ReferralBoneAppropriateID = 1 
	   AND  ((ServiceLevelApproachBone  = -1 
	      AND ReferralBoneApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralBoneApproachID = 2)
	     OR (ServiceLevelRecoveryBone  = -1 
	      AND ReferralBoneConsentID IN(1, 7, 8) 
	      AND ReferralBoneConversionID = -1))
	   ) 
	   OR
	   (  AccessTissueUpdate = 1
	   AND  ReferralTissueAppropriateID = 1 
	   AND  ((ServiceLevelApproachTissue  = -1 
	      AND ReferralTissueApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralTissueApproachID = 2)
	     OR (ServiceLevelRecoveryTissue  = -1 
	      AND ReferralTissueConsentID IN(1, 7, 8) 
	      AND ReferralTissueConversionID = -1))
	   )
	   OR
	   (  AccessSkinUpdate = 1
	   AND  ReferralSkinAppropriateID = 1 
	   AND  ((ServiceLevelApproachSkin  = -1 
	      AND ReferralSkinApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralSkinApproachID = 2)
	     OR (ServiceLevelRecoverySkin  = -1 
	      AND ReferralSkinConsentID IN(1, 7, 8) 
	      AND ReferralSkinConversionID = -1))
	   ) 
	   OR
	   (  AccessValvesUpdate = 1
	   AND  ReferralValvesAppropriateID = 1 
	   AND  ((ServiceLevelApproachValves  = -1 
	      AND ReferralValvesApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralValvesApproachID = 2)
	     OR (ServiceLevelRecoveryValves  = -1 
	      AND ReferralValvesConsentID IN(1, 7, 8)
	      AND ReferralValvesConversionID = -1))
	   )
	   OR
	   (  AccessEyesUpdate = 1
	   AND  ReferralEyesTransAppropriateID = 1 
	   AND  ((ServiceLevelApproachEyes  = -1 
	      AND ReferralEyesTransApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralEyesTransApproachID = 2)
	     OR (ServiceLevelRecoveryEyes  = -1 
	      AND ReferralEyesTransConsentID IN(1, 7, 8) 
	      AND ReferralEyesTransConversionID = -1))
	   ) 
	   OR
	   (  AccessResearchUpdate = 1
	   AND  ReferralEyesRschAppropriateID = 1 
	   AND  ((ServiceLevelApproachRsch  = -1 
	      AND ReferralEyesRschApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralEyesRschApproachID = 2)
	     OR (ServiceLevelRecoveryRsch  = -1 
	      AND ReferralEyesRschConsentID IN(1, 7, 8) 
	      AND ReferralEyesRschConversionID = -1))
	   )  
	 ));

     ELSE  -- No organization type was selected
	SET @incompleteCount =
	 (SELECT Count(DISTINCT Call.CallID) as ctr
	 FROM   Call
	 JOIN   Referral ON Referral.CallID = Call.CallID
	 JOIN   WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	 JOIN  WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID 
	 JOIN  ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	 JOIN  ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID
	 JOIN  Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	 WHERE  CallDateTime >= @vStartDate
	 AND   CallDateTime <= @vEndDate
	 AND  WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	 AND  WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	 AND  Organization.OrganizationId = @vOrgId
	 AND 
	 (
	   (  AccessOrgansUpdate = 1
	   AND  ReferralOrganAppropriateID = 1 
	   AND  (
	      (ServiceLevelApproachOrgan  = -1 
	      AND ReferralOrganApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralOrganApproachID = 2)
	     OR (ServiceLevelRecoveryOrgan  = -1 
	      AND ReferralOrganConsentID IN(1, 7, 8) 
	      AND ReferralOrganConversionID = -1))
	   )
	   OR
	   (  AccessBoneUpdate = 1
	   AND  ReferralBoneAppropriateID = 1 
	   AND  ((ServiceLevelApproachBone  = -1 
	      AND ReferralBoneApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralBoneApproachID = 2)
	     OR (ServiceLevelRecoveryBone  = -1 
	      AND ReferralBoneConsentID IN(1, 7, 8) 
	      AND ReferralBoneConversionID = -1))
	   ) 
	   OR
	   (  AccessTissueUpdate = 1
	   AND  ReferralTissueAppropriateID = 1 
	   AND  ((ServiceLevelApproachTissue  = -1 
	      AND ReferralTissueApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralTissueApproachID = 2)
	     OR (ServiceLevelRecoveryTissue  = -1 
	      AND ReferralTissueConsentID IN(1, 7, 8) 
	      AND ReferralTissueConversionID = -1))
	   )
	   OR
	   (  AccessSkinUpdate = 1
	   AND  ReferralSkinAppropriateID = 1 
	   AND  ((ServiceLevelApproachSkin  = -1 
	      AND ReferralSkinApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralSkinApproachID = 2)
	     OR (ServiceLevelRecoverySkin  = -1 
	      AND ReferralSkinConsentID IN(1, 7, 8) 
	      AND ReferralSkinConversionID = -1))
	   ) 
	   OR
	   (  AccessValvesUpdate = 1
	   AND  ReferralValvesAppropriateID = 1 
	   AND  ((ServiceLevelApproachValves  = -1 
	      AND ReferralValvesApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralValvesApproachID = 2)
	     OR (ServiceLevelRecoveryValves  = -1 
	      AND ReferralValvesConsentID IN(1, 7, 8)
	      AND ReferralValvesConversionID = -1))
	   )
	   OR
	   (  AccessEyesUpdate = 1
	   AND  ReferralEyesTransAppropriateID = 1 
	   AND  ((ServiceLevelApproachEyes  = -1 
	      AND ReferralEyesTransApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralEyesTransApproachID = 2)
	     OR (ServiceLevelRecoveryEyes  = -1 
	      AND ReferralEyesTransConsentID IN(1, 7, 8) 
	      AND ReferralEyesTransConversionID = -1))
	   ) 
	   OR
	   (  AccessResearchUpdate = 1
	   AND  ReferralEyesRschAppropriateID = 1 
	   AND  ((ServiceLevelApproachRsch  = -1 
	      AND ReferralEyesRschApproachID = -1)  
	     OR (ReferralApproachTypeID = 7
	      AND ReferralEyesRschApproachID = 2)
	     OR (ServiceLevelRecoveryRsch  = -1 
	      AND ReferralEyesRschConsentID IN(1, 7, 8) 
	      AND ReferralEyesRschConversionID = -1))
	   )  
	 ));
	
RETURN @incompleteCount;


END







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

