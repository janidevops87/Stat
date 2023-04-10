SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_FSConversion_Select_All]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure: sps_rpt_FSConversion_Select_All'
	drop procedure [dbo].[sps_rpt_FSConversion_Select_All]
End
go

PRINT 'Creating Procedure: sps_rpt_FSConversion_Select_All'
GO

CREATE     PROCEDURE sps_rpt_FSConversion_Select_All
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
**		File: sps_rpt_FSConversion_Select_All.sql
**		Name: sps_rpt_FSConversion_Select_All
**		Desc: 
**
**		Return values:
** 
**		Called by following Sprocs when All option is selected in report:
**		1. sps_rpt_FSConversionRateAll.sql						- Standard
**		2. sps_rpt_FSConversionBoneSkin.sql						- Bone and Skin
**		3. sps_rpt_FSConversionRateByClient.sql					- ByClient
**		4. sps_rpt_FSConversionRateSummarizeByApproacher.sql	- SummarizeBy Approacher
**
**		Parameters:	See Above
**
**		Auth: ccarroll
**		Date: 07/03/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		07/03/2007		ccarroll				Initial Release
****************************************************************************/

If @DisplayMT Is Null
	BEGIN
	/* Null, 0 - Run in referral facility time
			 1 - Run in Mountain Time */
		SET @DisplayMT = 0
	END

	/*	Create and populate a virtual table of valid Statline,MTF and MTF(ASP)users
   		who have FCS or Manager access to family service cases. */
	DECLARE	@PersonTable table ( 
		ID int identity(1,1), 
		PersonID int NOT NULL )

	INSERT INTO @PersonTable (PersonID)
		SELECT PersonID FROM Person
		JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID
		WHERE OrganizationID IN (194,14019,3891)--Statline,MTF and MTF(ASP)users
		AND PersonType.PersonTypeId IN (11,24,44,18,19,60,77,81,84,90,10,108)


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
		
		/* Approach PersonIDs */
		SecondaryApproach.SecondaryApproachedBy,
		SecondaryApproach.SecondaryConsentBy,
		LogEvent.PersonID,

		Referral.ReferralApproachTypeID,
		Referral.ReferralGeneralConsent,
		Referral.ReferralTypeID,
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
  JOIN SecondaryApproach ON SecondaryApproach.CallID = Call.CallID
  JOIN LogEvent ON LogEvent.CallID = Call.CallID
  JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
  LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Call.CallID

  WHERE  Call.SourceCodeID IN 
		(SELECT DISTINCT * 
			FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))
  AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID,Referral.ReferralCallerOrganizationID)
  AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
  AND LogEvent.LogEventTypeID = 15 /* Secondary Pending */


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
