SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralDataServiceAccess]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralDataServiceAccess]
GO


/****** Object:  Stored Procedure dbo.sps_ReferralDataServiceAccess    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReferralDataServiceAccess
	(@vCallID int = null)

AS

SET NOCOUNT ON

DECLARE
	@vSourceCodeID	int,
	@vOrgID		int


	/* First get the service level id of the selected callid */

	SELECT 	@vSourceCodeID = SourceCodeID
	FROM		Call
	WHERE 	CallID = @vCallID;

	/* Next get the get the organization id of the selected callid */

	SELECT	@vOrgID = ReferralCallerOrganizationID
	FROM		Referral
	WHERE	Referral.CallID = @vCallID;

	/* Last get the get the service level info */

	SELECT 	ServiceLevel.ServiceLevelID,
			ServiceLevelAppropriateOrgan, ServiceLevelAppropriateBone, ServiceLevelAppropriateTissue, ServiceLevelAppropriateSkin, ServiceLevelAppropriateValves, ServiceLevelAppropriateEyes, ServiceLevelAppropriateRsch,
			ServiceLevelApproachOrgan, ServiceLevelApproachBone, ServiceLevelApproachTissue, ServiceLevelApproachSkin, ServiceLevelApproachValves, ServiceLevelApproachEyes, ServiceLevelApproachRsch,
			ServiceLevelConsentOrgan, ServiceLevelConsentBone, ServiceLevelConsentTissue, ServiceLevelConsentSkin, ServiceLevelConsentValves, ServiceLevelConsentEyes, ServiceLevelConsentRsch,
			ServiceLevelRecoveryOrgan, ServiceLevelRecoveryBone, ServiceLevelRecoveryTissue, ServiceLevelRecoverySkin, ServiceLevelRecoveryValves, ServiceLevelRecoveryEyes, ServiceLevelRecoveryRsch,
			-- Added to select to ensure only one record is returned per CallId.  4/20/05 - SAP
			ServiceLevelStatus

	FROM		ServiceLevel
	JOIN		ServiceLevel30Organization ON ServiceLevel30Organization.ServiceLevelID = ServiceLevel.ServiceLevelID
	JOIN		ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID

	WHERE	ServiceLevel30Organization.OrganizationID = @vOrgID
	AND		ServiceLevelSourceCode.SourceCodeID = @vSourceCodeID
	-- Added to select to ensure only one record is returned per CallId.  4/20/05 - SAP
	AND		ServiceLevelStatus = 0;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

