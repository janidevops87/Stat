SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_InitialApproacherSummary_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_rpt_InitialApproacherSummary_Select]
	PRINT 'Dropping sps_rpt_InitialApproacherSummary_Select'
End
go

PRINT 'Creating sps_rpt_InitialApproacherSummary_Select'
GO

CREATE    PROCEDURE sps_rpt_InitialApproacherSummary_Select
	@ReferralStartDateTime	datetime	= NULL,
	@ReferralEndDateTime	datetime  	= NULL,
	@ReportGroupID			int		= NULL, 
	@OrganizationID			int		= NULL,
	@SourceCodeName			varchar (10)	= NULL,
	@CoordinatorID			int		= NULL, 
	@DisplayMT				Int		= NULL
AS
/******************************************************************************
**		File: sps_rpt_InitialApproacherSummary_Select.sql
**		Name: sps_rpt_InitialApproacherSummary_Select
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
**		See Above
**
**		Called By:
**
**		Auth: christopher carroll
**		Date: 09/16/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**  	09/16/2008	ccarroll		Initial Release
****************************************************************************/

	SELECT
		Referral.CallID,
		SourceCode.SourceCodeName,
		Referral.ReferralCallerOrganizationID,
		Organization.OrganizationName,
		Referral.ReferralApproachedByPersonID,
		ApproachPerson.PersonLast AS 'ApproachPersonLastName',
		ApproachPerson.PersonFirst AS 'ApproactPersonFirstName',
		Referral.ReferralApproachTypeID,
		Referral.ReferralGeneralConsent,
		RegistryStatus.RegistryStatus,
		Referral.ReferralOrganAppropriateID,
		Referral.ReferralOrganApproachID,
		Referral.ReferralOrganConsentID,
		Referral.ReferralBoneAppropriateID,
		Referral.ReferralBoneApproachID,
		Referral.ReferralBoneConsentID,
		Referral.ReferralTissueAppropriateID,
		Referral.ReferralTissueApproachID,
		Referral.ReferralTissueConsentID,
		Referral.ReferralSkinAppropriateID,
		Referral.ReferralSkinApproachID,
		Referral.ReferralSkinConsentID,
		Referral.ReferralEyesTransAppropriateID,
		Referral.ReferralEyesTransApproachID,
		Referral.ReferralEyesTransConsentID,
		Referral.ReferralEyesRschAppropriateID,
		Referral.ReferralEyesRschApproachID,
		Referral.ReferralEyesRschConsentID,
		Referral.ReferralValvesAppropriateID,
		Referral.ReferralValvesApproachID,
		Referral.ReferralValvesConsentID

	FROM Call
	JOIN	/* NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
			   Converting the date as appropriate
			   The function limits the data returned by daterange and/or CallID
			*/
	(
		SELECT 		
			CallID, 
			CallDateTime 
			--ReferralDonorDeathDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		Null						,
		@ReferralStartDateTime		,
		@ReferralEndDateTime		,
		Null						,
		Null						, 
		@DisplayMT		 )
	) LT ON LT.CallID = Call.CallID
	JOIN Referral ON Call.CallID = Referral.CallID
	LEFT JOIN Person AS ApproachPerson ON Referral.ReferralApproachedByPersonID = ApproachPerson.PersonID
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID

	WHERE	Call.SourceCodeID IN 
		  (SELECT DISTINCT * 
	    FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName))
	AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID, Referral.ReferralCallerOrganizationID)
  	AND IsNull(Referral.ReferralApproachedByPersonID, 0) = IsNull(@CoordinatorID, IsNull(Referral.ReferralApproachedByPersonID, 0))
	AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

