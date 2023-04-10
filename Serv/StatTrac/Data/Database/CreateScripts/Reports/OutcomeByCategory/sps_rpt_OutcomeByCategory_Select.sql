SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_OutcomeByCategory_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure: sps_rpt_OutcomeByCategory_Select'
	drop procedure [dbo].[sps_rpt_OutcomeByCategory_Select]
End
go

PRINT 'Creating Procedure: sps_rpt_OutcomeByCategory_Select'
GO

CREATE     PROCEDURE sps_rpt_OutcomeByCategory_Select
	@ReferralStartDateTime		datetime	= NULL ,
	@ReferralEndDateTime		datetime  	= NULL ,
	@ReportGroupID			int			= NULL , 
	@OrganizationID			int			= NULL ,
	@SourceCodeName			varchar (10) = NULL ,
	@DisplayMT				int	= Null 

AS
	-- set transaction isolation level
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	
/******************************************************************************
**		File: sps_rpt_OutcomeByCategory_Select.sql
**		Name: sps_rpt_OutcomeByCategory_Select
**		Desc: 
**
**		Return values:
** 
**		Called by following Sprocs when All option is selected in report:
**		1. sps_rpt_OutcomeByCategory_Select.sql
**
**		Parameters:	See Above
**
**		Auth: ccarroll
**		Date: 08/14/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		08/14/2008		ccarroll				Initial Release
****************************************************************************/

If @DisplayMT Is Null
	BEGIN
	/* Null, 0 - Run in referral facility time
			 1 - Run in Mountain Time */
		SET @DisplayMT = 0
	END


SELECT
		@ReferralStartDateTime = ISNULL(
						@ReferralStartDateTime, 
						CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@ReferralEndDateTime = ISNULL	(
						@ReferralEndDateTime, 
						CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
					)

	
	SELECT DISTINCT
		Call.CallID,
		Call.CallDateTime,
		Call.SourceCodeID,
		Call.StatEmployeeID,

		Referral.ReferralGeneralConsent,
		Referral.ReferralTypeID,
		Referral.ReferralCallerOrganizationID,
		RegistryStatus.RegistryStatus, 

		Referral.ReferralOrganAppropriateID,
		Referral.ReferralBoneAppropriateID,
		Referral.ReferralTissueAppropriateID,
		Referral.ReferralSkinAppropriateID,
		Referral.ReferralEyesTransAppropriateID,
		Referral.ReferralEyesRschAppropriateID,
		Referral.ReferralValvesAppropriateID,

		Referral.ReferralOrganApproachID,
		Referral.ReferralBoneApproachID,
		Referral.ReferralTissueApproachID,
		Referral.ReferralSkinApproachID,
		Referral.ReferralEyesTransApproachID,
		Referral.ReferralEyesRschApproachID,
		Referral.ReferralValvesApproachID,

		Referral.ReferralOrganConsentID,
		Referral.ReferralBoneConsentID,
		Referral.ReferralTissueConsentID,
		Referral.ReferralSkinConsentID,
		Referral.ReferralEyesTransConsentID,
		Referral.ReferralEyesRschConsentID,
		Referral.ReferralValvesConsentID,

		Referral.ReferralOrganConversionID,
		Referral.ReferralBoneConversionID,
		Referral.ReferralTissueConversionID,
		Referral.ReferralSkinConversionID,
		Referral.ReferralEyesTransConversionID, 
		Referral.ReferralEyesRschConversionID, 
		Referral.ReferralValvesConversionID 
  FROM Call
 	JOIN	/* NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
			   Converting the date as appropriate
			   The function limits the data returned by date range and/or CallID
			*/
	(
		SELECT 		
			CallID, 
			CallDateTime 
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
  LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
  LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Call.CallID
  
  WHERE

  /* Search - ReportGroup */
	WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
  
	  AND
			Call.SourceCodeID IN 
				(SELECT SourceCodeID 
					FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName)
				)
  AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID,Referral.ReferralCallerOrganizationID)
  AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
 
ORDER BY Call.CallID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
