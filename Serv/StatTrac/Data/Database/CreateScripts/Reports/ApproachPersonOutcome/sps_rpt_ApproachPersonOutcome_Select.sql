SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ApproachPersonOutcome_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_rpt_ApproachPersonOutcome_Select]
	PRINT 'Dropping sps_rpt_ApproachPersonOutcome_Select'
End
go

PRINT 'Creating sps_rpt_ApproachPersonOutcome_Select'
GO

CREATE    PROCEDURE sps_rpt_ApproachPersonOutcome_Select
	@ReferralStartDateTime	datetime	= NULL,
	@ReferralEndDateTime	datetime  	= NULL,
	@ReportGroupID			int		= NULL, 
	@OrganizationID			int		= NULL,
	@SourceCodeName			varchar (10)	= NULL,
	@CoordinatorID			int		= NULL, 
	@LowerAgeLimit			int		= NULL,
	@UpperAgeLimit			int		= NULL,
	@Gender					varchar (1)	= NULL,
	@DisplayMT				Int		= NULL
AS
/******************************************************************************
**		File: sps_rpt_ApproachPersonOutcome_Select.sql
**		Name: sps_rpt_ApproachPersonOutcome_Select
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
**		Date: 09/04/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**  	09/04/2008	ccarroll		Initial Release
****************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT	DISTINCT
		Referral.CallID,
		Referral.ReferralApproachedByPersonID,
		ApproachPerson.PersonLast,
		ApproachPerson.PersonFirst,
		Referral.ReferralDonorGender,
		datediff(year,Referral.ReferralDOB, Referral.ReferralDonorDeathDate)-1 AS 'ReferralDonorAge',
		Referral.ReferralApproachTypeID,
		Referral.ReferralGeneralConsent,
		CASE WHEN SecondaryApproach.SecondaryApproachOutcome = 1 THEN 2 -- Triage Yes Verbal
			 WHEN SecondaryApproach.SecondaryApproachOutcome = 2 THEN 1 -- Triage Yes Written
			 ELSE SecondaryApproach.SecondaryApproachOutcome
		END AS 'SecondaryApproachOutcome',
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
	JOIN Person AS ApproachPerson ON Referral.ReferralApproachedByPersonID = ApproachPerson.PersonID
	LEFT JOIN StatEmployee AS StatEmployeeApproach ON StatEmployeeApproach.PersonID = ApproachPerson.PersonID 
	LEFT JOIN SecondaryApproach ON SecondaryApproach.CallID = Referral.CallID
	JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID
	LEFT JOIN LogEvent ON Call.CallID = LogEvent.CallID

	WHERE	Call.SourceCodeID IN 
		  (SELECT DISTINCT * 
	    FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName))
	AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID, Referral.ReferralCallerOrganizationID)
   	AND (Referral.ReferralDonorAge >= ISNULL(@LowerAgeLimit, Referral.ReferralDonorAge)
		AND Referral.ReferralDonorAge <= ISNULL(@UpperAgeLimit, Referral.ReferralDonorAge)
	     )
	--AND IsNull(StatEmployeeApproach.StatEmployeeID, 0) = IsNull(@CoordinatorID, IsNull(StatEmployeeApproach.StatEmployeeID, 0))
	AND LogEvent.StatEmployeeID = ISNULL(@CoordinatorID, LogEvent.StatEmployeeID)
	AND Referral.ReferralDonorGender = ISNULL(@Gender,Referral.ReferralDonorGender)
	AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
	AND Referral.ReferralApproachTypeID IN (2, 3, 4, 5, 6, 8)
	 /* Selection on:
			(2)Pre-Ref, Coupled
			(3)Pre-Ref, Decoupled
			(4)Post Ref, Coupled
			(5)Post Ref, Decoupled
			(6)Family Initiated
			(8)Registry
		Excluded from selection: (1) Not Approached and (7) Unknown	*/

	Order By
	ApproachPerson.PersonLast,
	ApproachPerson.PersonFirst

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

