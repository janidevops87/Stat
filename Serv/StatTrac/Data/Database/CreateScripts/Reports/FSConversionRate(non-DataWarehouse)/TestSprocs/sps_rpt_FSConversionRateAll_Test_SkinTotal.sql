

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_FSConversionRateAll_Test_SkinTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_rpt_FSConversionRateAll_Test_SkinTotal]
End
go

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO









CREATE       PROCEDURE sps_rpt_FSConversionRateAll_Test_SkinTotal
	@StartDateTime		datetime	= NULL ,
	@EndDateTime		datetime  	= NULL ,
	@ReportGroupID		int			= NULL , 
	@OrganizationID		int			= NULL ,
	@SourceCodeName		varchar (10)	= NULL ,
	@ApproachPersonID	int		= NULL 
AS
	-- set transaction isolation level
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

DECLARE /* Totals */
	@TotalReferralBone int,
	@TotalReferralTissue int,
	@TotalReferralSkin int,
	@TotalReferralValves int,
	@TotalReferralEyes int,
	@TotalReferralOther int,

	@TotalTissueTotalReferrals int,
	@TotalTissueApproached int, 
	@TotalTissueConsented int, 
	@TotalTissueRecovered int, 
	@TotalTissueNotRecovered int, 
	@TotalTissueUnknownRecovery int, 

	@TotalReferralsTotalReferrals int, 
	@TotalReferralsApproached int, 
	@TotalReferralsConsented int, 
	@TotalReferralsRecovered int, 
	@TotalReferralsNotRecovered int, 
	@TotalReferralsUnknownRecovery int 
	
/******************************************************************************
**		File: sps_rpt_FSConversionRateAll.sql
**		Name: sps_rpt_FSConversionRateAll
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by: sps_rpt_FSConversionRate.sql which is called by FS Conversion Rate.rdl              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@StartDateTime
**		@EndDateTime
**		@ReportGroupID
**		@OrganizationID
**		@SourceCodeName
**		@ApproachPersonID
**
**		
**		Auth: Christopher Carroll
**		Date: 04/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		04/10/2007		Christopher Carroll		Initial Release    
****************************************************************************/



	/*	Create virtual table used in finial display */
	DECLARE	@TempCounts table ( 
		ID int identity(1,1),
		FormatCode int NULL, -- Values to format row: 0 = None, 1 = Bold, 2 = Bold & Italic 
		Category varchar (20) NULL,
		TotalReferrals int NULL,
		Approached int NULL,
		Consented int NULL,
		Recovered int NULL,
		NotRecovered int NULL,
		UnknownRecovery int NULL )


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
		@StartDateTime = ISNULL(
						@StartDateTime, 
						CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = ISNULL	(
						@EndDateTime, 
						CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
					)



/* Create Temp table select */
DECLARE @Temp_FSConversion_Select TABLE 
	(
		[CallID] [INT] ,
		[CallDateTime] [DATETIME] , 
		[CallSourceCodeID] [INT] NULL , 
		[CallStatEmployeeID] [INT] NULL,

		[SecondaryApproachedBy] [INT] NULL ,		
		[SecondaryConsentBy] [INT] NULL,
	
		[ReferralGeneralConsent] [INT] NULL,

		[ReferralOrganAppropriateID] [INT] NULL , 
		[ReferralBoneAppropriateID] [INT] NULL , 
		[ReferralTissueAppropriateID] [INT] NULL , 
		[ReferralSkinAppropriateID] [INT] NULL , 
		[ReferralEyesTransAppropriateID] [INT] NULL , 
		[ReferralEyesRschAppropriateID] [INT] NULL , 
		[ReferralValvesAppropriateID] [INT] NULL , 

		[ReferralOrganApproachID] [INT] NULL , 
		[ReferralBoneApproachID] [INT] NULL , 
		[ReferralTissueApproachID] [INT] NULL , 
		[ReferralSkinApproachID] [INT] NULL , 

		[ReferralEyesTransApproachID] [INT] NULL , 
		[ReferralEyesRschApproachID] [INT] NULL , 
		[ReferralValvesApproachID] [INT] NULL , 

		[ReferralOrganConsentID] [INT] NULL , 
		[ReferralBoneConsentID] [INT] NULL , 
		[ReferralTissueConsentID] [INT] NULL , 
		[ReferralSkinConsentID] [INT] NULL , 
		[ReferralEyesTransConsentID] [INT] NULL , 
		[ReferralEyesRschConsentID] [INT] NULL , 
		[ReferralValvesConsentID] [INT] NULL , 

		[ReferralOrganConversionID] [INT] NULL , 
		[ReferralBoneConversionID] [INT] NULL , 
		[ReferralTissueConversionID] [INT] NULL , 
		[ReferralSkinConversionID] [INT] NULL , 
		[ReferralEyesTransConversionID] [INT] NULL , 
		[ReferralEyesRschConversionID] [INT] NULL , 
		[ReferralValvesConversionID] [INT]  NULL 
	)


INSERT INTO @Temp_FSConversion_Select
	
	SELECT DISTINCT
		Call.CallID,
		Call.CallDateTime,
		Call.SourceCodeID,
		Call.StatEmployeeID,
		SecondaryApproach.SecondaryApproachedBy,
		SecondaryApproach.SecondaryConsentBy,

		Referral.ReferralGeneralConsent,

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
  JOIN Referral ON Call.CallID = Referral.CallID
  JOIN SecondaryApproach ON SecondaryApproach.CallID = Call.CallID
  JOIN LogEvent ON LogEvent.CallID = Call.CallID
  JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 

  WHERE Call.CallDateTime BETWEEN @StartDateTime AND @EndDateTime -- StartDate / EndDate
  AND Call.SourceCodeID IN 
	(SELECT DISTINCT * 
	    FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))
  AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID,Referral.ReferralCallerOrganizationID)
--  AND SecondaryApproach.SecondaryApproachedBy = ISNULL(@ApproachPersonID,SecondaryApproach.SecondaryApproachedBy)
  AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
  AND LogEvent.LogEventTypeID = 15 -- Secondary Pending




SELECT	*
FROM @Temp_FSConversion_Select
WHERE ReferralSkinAppropriateID = 1





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO






/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT 'sps_rpt_FSConversionRateAll_Test_SkinTotal'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 sps_rpt_FSConversionRateAll_Test_SkinTotal'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/


