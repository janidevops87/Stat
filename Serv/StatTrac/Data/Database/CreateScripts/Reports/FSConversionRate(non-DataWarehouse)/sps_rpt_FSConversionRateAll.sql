SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_FSConversionRateAll]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure: sps_rpt_FSConversionRateAll'
	drop procedure [dbo].[sps_rpt_FSConversionRateAll]
End
go

PRINT 'Creating Procedure: sps_rpt_FSConversionRateAll'
GO

CREATE     PROCEDURE sps_rpt_FSConversionRateAll
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
**		06/29/2007		Christopher Carroll		Added @ApproachPersonID to Where
**		05/12/2007		Christopher Carroll		added OR Statement to WHERE for initial Referral selection 
**												when @ApproachPersonID contains value 
**		07/01/2008		Christopher Carroll		Corrected initial Approach selection scope 
**		04/04/2013		Jim Gerberich			Corrected Approacher selection to return Consent only if Approacher 
**													is null.  HS 35601 VS 5989
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

/*Change for HS 35601 VS 5989*/
 -- AND ( ISNULL(SecondaryApproach.SecondaryApproachedBy, 0) = ISNULL(@ApproachPersonID, ISNULL(SecondaryApproach.SecondaryApproachedBy, 0))
	--OR  ISNULL(SecondaryApproach.SecondaryConsentBy, 0) = ISNULL(@ApproachPersonID, ISNULL(SecondaryApproach.SecondaryConsentBy, 0))
	   --)

AND (Coalesce(SecondaryApproach.SecondaryApproachedBy, SecondaryApproach.SecondaryConsentBy, 0) = Coalesce(@ApproachPersonID, SecondaryApproach.SecondaryApproachedBy, 
SecondaryApproach.SecondaryConsentBy, 0))

  AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
  AND LogEvent.LogEventTypeID = 15 -- Secondary Pending


/* Set Total Referral Counts */
SELECT
	@TotalReferralBone = SUM(CASE WHEN ReferralBoneAppropriateID = 1 THEN 1 ELSE 0 END),
	@TotalReferralTissue = SUM(CASE WHEN ReferralTissueAppropriateID = 1 THEN 1 ELSE 0 END),
	@TotalReferralSkin = SUM(CASE WHEN ReferralSkinAppropriateID = 1 THEN 1 ELSE 0 END),
	@TotalReferralValves = SUM(CASE WHEN ReferralValvesAppropriateID = 1 THEN 1 ELSE 0 END),
	@TotalReferralEyes = SUM(CASE WHEN ReferralEyesTransAppropriateID = 1 THEN 1 ELSE 0 END),
	@TotalReferralOther = SUM(CASE WHEN ReferralEyesRschAppropriateID = 1 THEN 1 ELSE 0 END),
	@TotalTissueTotalReferrals = SUM(CASE
				WHEN ReferralBoneAppropriateID = 1
				OR   ReferralTissueAppropriateID = 1
				OR   ReferralSkinAppropriateID = 1
				OR   ReferralValvesAppropriateID = 1
				OR   ReferralEyesRschAppropriateID = 1
				THEN 1 ELSE 0 END),
	@TotalReferralsTotalReferrals = SUM(CASE
				WHEN ReferralBoneAppropriateID = 1
				OR   ReferralTissueAppropriateID = 1
				OR   ReferralSkinAppropriateID = 1
				OR   ReferralValvesAppropriateID = 1
				OR   ReferralEyesTransAppropriateID = 1
				OR   ReferralEyesRschAppropriateID = 1
				THEN 1 ELSE 0 END)
	
	
FROM @Temp_FSConversion_Select





/* Select Approach, Consented and Recovered Counts
  Bone */
INSERT INTO @TempCounts
SELECT
	0 AS 'FormatCode',
	'Bone' AS 'Category',
	@TotalReferralBone AS 'TotalReferrals',
 	SUM(CASE WHEN ReferralBoneApproachID = 1 THEN 1 ELSE 0 END) AS 'ApproachedBone',
 	SUM(CASE WHEN ReferralBoneApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralBoneConsentID = 1
				THEN 1 ELSE 0 END) AS 'ConsentBone',
 	SUM(CASE WHEN ReferralBoneApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralBoneConsentID = 1
				AND ReferralBoneConversionID = 1
				THEN 1 ELSE 0 END) AS 'RecoveredBone',
 	SUM(CASE WHEN ReferralBoneApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralBoneConsentID = 1
				AND ReferralBoneConversionID > 1					
				THEN 1 ELSE 0 END) AS 'NotRecoveredBone',
 	SUM(CASE WHEN ReferralBoneApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralBoneConsentID = 1
				AND ReferralBoneConversionID = -1					
				THEN 1 ELSE 0 END) AS 'UnknownRecoveryBone'
FROM @Temp_FSConversion_Select
LEFT JOIN @PersonTable AS Approach ON Approach.PersonID = SecondaryApproachedBy
LEFT JOIN @PersonTable AS Consent ON Consent.PersonID = SecondaryConsentBy
WHERE (Approach.PersonID = SecondaryApproachedBy OR Consent.PersonID = SecondaryConsentBy)


/* Tissue */
INSERT INTO @TempCounts
SELECT
	0 AS 'FormatCode',
	'Tissue' AS 'Category',
	@TotalReferralTissue AS 'TotalReferrals',
 	SUM(CASE WHEN ReferralTissueApproachID = 1 THEN 1 ELSE 0 END) AS 'ApproachedTissue',
 	SUM(CASE WHEN ReferralTissueApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralTissueConsentID = 1
				THEN 1 ELSE 0 END) AS 'ConsentTissue',
 	SUM(CASE WHEN ReferralTissueApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralTissueConsentID = 1
				AND ReferralTissueConversionID = 1
				THEN 1 ELSE 0 END) AS 'RecoveredTissue',
 	SUM(CASE WHEN ReferralTissueApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralTissueConsentID = 1
				AND ReferralTissueConversionID > 1					
				THEN 1 ELSE 0 END) AS 'NotRecoveredTissue',
 	SUM(CASE WHEN ReferralTissueApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralTissueConsentID = 1
				AND ReferralTissueConversionID = -1					
				THEN 1 ELSE 0 END) AS 'UnknownRecoveryTissue'

FROM @Temp_FSConversion_Select
LEFT JOIN @PersonTable AS Approach ON Approach.PersonID = SecondaryApproachedBy
LEFT JOIN @PersonTable AS Consent ON Consent.PersonID = SecondaryConsentBy
WHERE (Approach.PersonID = SecondaryApproachedBy OR Consent.PersonID = SecondaryConsentBy)


/* Skin */
INSERT INTO @TempCounts
SELECT
	0 AS 'FormatCode',
	'Skin' AS 'Category',
	@TotalReferralSkin AS 'TotalReferrals',
 	SUM(CASE WHEN ReferralSkinApproachID = 1 THEN 1 ELSE 0 END) AS 'ApproachedSkin',
 	SUM(CASE WHEN ReferralSkinApproachID = 1
				AND ReferralGeneralConsent = 1
				AND ReferralSkinConsentID = 1
				THEN 1 ELSE 0 END) AS 'ConsentSkin',
 	SUM(CASE WHEN ReferralSkinApproachID = 1
				AND ReferralGeneralConsent = 1
				AND ReferralSkinConsentID = 1
				AND ReferralSkinConversionID = 1
				THEN 1 ELSE 0 END) AS 'RecoveredSkin',
 	SUM(CASE WHEN ReferralSkinApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralSkinConsentID = 1
				AND ReferralSkinConversionID > 1					
				THEN 1 ELSE 0 END) AS 'NotRecoveredSkin',
 	SUM(CASE WHEN ReferralSkinApproachID = 1
				AND ReferralGeneralConsent = 1
				AND ReferralSkinConsentID = 1
				AND ReferralSkinConversionID = -1					
				THEN 1 ELSE 0 END) AS 'UnknownRecoverySkin'
FROM @Temp_FSConversion_Select
LEFT JOIN @PersonTable AS Approach ON Approach.PersonID = SecondaryApproachedBy
LEFT JOIN @PersonTable AS Consent ON Consent.PersonID = SecondaryConsentBy
WHERE (Approach.PersonID = SecondaryApproachedBy OR Consent.PersonID = SecondaryConsentBy)


/* Valves */
INSERT INTO @TempCounts
SELECT
	0 AS 'FormatCode',
	'Valves' AS 'Category',
	@TotalReferralValves AS 'TotalReferrals',
 	SUM(CASE WHEN ReferralValvesApproachID = 1 THEN 1 ELSE 0 END) AS 'ApproachedValves',
 	SUM(CASE WHEN ReferralValvesApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralValvesConsentID = 1
				THEN 1 ELSE 0 END) AS 'ConsentValves',
 	SUM(CASE WHEN ReferralValvesApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralValvesConsentID = 1
				AND ReferralValvesConversionID = 1
				THEN 1 ELSE 0 END) AS 'RecoveredValves',
 	SUM(CASE WHEN ReferralValvesApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralValvesConsentID = 1
				AND ReferralValvesConversionID > 1					
				THEN 1 ELSE 0 END) AS 'NotRecoveredValves',
 	SUM(CASE WHEN ReferralValvesApproachID = 1
				AND ReferralGeneralConsent = 1
				AND ReferralValvesConsentID = 1
				AND ReferralValvesConversionID = -1					
				THEN 1 ELSE 0 END) AS 'UnknownRecoveryValves'
FROM @Temp_FSConversion_Select
LEFT JOIN @PersonTable AS Approach ON Approach.PersonID = SecondaryApproachedBy
LEFT JOIN @PersonTable AS Consent ON Consent.PersonID = SecondaryConsentBy
WHERE (Approach.PersonID = SecondaryApproachedBy OR Consent.PersonID = SecondaryConsentBy)


/* Eyes */
INSERT INTO @TempCounts
SELECT
	0 AS 'FormatCode',
	'Eyes' AS 'Category',
	@TotalReferralEyes AS 'TotalReferrals',
 	SUM(CASE WHEN ReferralEyesTransApproachID = 1 THEN 1 ELSE 0 END) AS 'ApproachedEyes',
 	SUM(CASE WHEN ReferralEyesTransApproachID = 1
				AND ReferralGeneralConsent = 1
				AND ReferralEyesTransConsentID = 1
				THEN 1 ELSE 0 END) AS 'ConsentEyes',
 	SUM(CASE WHEN ReferralEyesTransApproachID = 1
				AND ReferralGeneralConsent = 1
				AND ReferralEyesTransConsentID = 1
				AND ReferralEyesTransConversionID = 1
				THEN 1 ELSE 0 END) AS 'RecoveredEyes',
 	SUM(CASE WHEN ReferralEyesTransApproachID = 1
				AND ReferralGeneralConsent = 1
				AND ReferralEyesTransConsentID = 1
				AND ReferralEyesTransConversionID > 1					
				THEN 1 ELSE 0 END) AS 'NotRecoveredEyes',
 	SUM(CASE WHEN ReferralEyesTransApproachID = 1
				AND ReferralGeneralConsent = 1
				AND ReferralEyesTransConsentID = 1
				AND ReferralEyesTransConversionID = -1				
				THEN 1 ELSE 0 END) AS 'UnknownRecoveryEyes'
FROM @Temp_FSConversion_Select
LEFT JOIN @PersonTable AS Approach ON Approach.PersonID = SecondaryApproachedBy
LEFT JOIN @PersonTable AS Consent ON Consent.PersonID = SecondaryConsentBy
WHERE (Approach.PersonID = SecondaryApproachedBy OR Consent.PersonID = SecondaryConsentBy)


/* Other (EyesRsch)*/
INSERT INTO @TempCounts
SELECT
	0 AS 'FormatCode',
	'Other' AS 'Category',
	@TotalReferralOther AS 'TotalReferrals',
 	SUM(CASE WHEN ReferralEyesRschApproachID = 1 THEN 1 ELSE 0 END) AS 'ApproachedOther',
 	SUM(CASE WHEN ReferralEyesRschApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralEyesRschConsentID = 1
				THEN 1 ELSE 0 END) AS 'ConsentOther',
 	SUM(CASE WHEN ReferralEyesRschApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralEyesRschConsentID = 1
				AND ReferralEyesRschConversionID = 1
				THEN 1 ELSE 0 END) AS 'RecoveredOther',
 	SUM(CASE WHEN ReferralEyesRschApproachID = 1
				AND ReferralGeneralConsent =1
				AND ReferralEyesRschConsentID = 1
				AND ReferralEyesRschConversionID > 1					
				THEN 1 ELSE 0 END) AS 'NotRecoveredOther',
 	SUM(CASE WHEN ReferralEyesRschApproachID = 1
				AND ReferralGeneralConsent = 1
				AND ReferralEyesRschConsentID = 1
				AND ReferralEyesRschConversionID = -1				
				THEN 1 ELSE 0 END) AS 'UnknownRecoveryOther'
FROM @Temp_FSConversion_Select
LEFT JOIN @PersonTable AS Approach ON Approach.PersonID = SecondaryApproachedBy
LEFT JOIN @PersonTable AS Consent ON Consent.PersonID = SecondaryConsentBy
WHERE (Approach.PersonID = SecondaryApproachedBy OR Consent.PersonID = SecondaryConsentBy)


/* Total_Tissue */
INSERT INTO @TempCounts
SELECT
	1 AS 'FormatCode',
	'Total Tissue' AS 'Category',
	@TotalTissueTotalReferrals AS 'TotalTissueReferrals',
	SUM(CASE WHEN ReferralBoneApproachID = 1
				OR   ReferralTissueApproachID = 1
				OR   ReferralSkinApproachID = 1
				OR   ReferralValvesApproachID = 1
				OR   ReferralEyesRschApproachID = 1
				THEN 1 ELSE 0 END) AS 'TotalTissueApproached',

	SUM(CASE WHEN ReferralGeneralConsent = 1
				AND  ((ReferralBoneApproachID = 1 AND ReferralBoneConsentID = 1)
				OR   (ReferralTissueApproachID = 1 AND ReferralTissueConsentID = 1)
				OR   (ReferralSkinApproachID = 1 AND ReferralSkinConsentID = 1)
				OR   (ReferralValvesApproachID = 1 AND ReferralValvesConsentID = 1)
				OR   (ReferralEyesRschApproachID = 1 AND ReferralEyesRschConsentID = 1))
				THEN 1 ELSE 0 END) AS 'TotalTissueConsented',

	SUM(CASE WHEN ReferralGeneralConsent = 1
				AND  ((ReferralBoneApproachID = 1 AND ReferralBoneConsentID = 1 AND ReferralBoneConversionID = 1)
				OR   (ReferralTissueApproachID = 1 AND ReferralTissueConsentID = 1 AND ReferralTissueConversionID = 1)
				OR   (ReferralSkinApproachID = 1 AND ReferralSkinConsentID = 1 AND ReferralSkinConversionID = 1)
				OR   (ReferralValvesApproachID = 1 AND ReferralValvesConsentID = 1 AND ReferralValvesConversionID = 1)
				OR   (ReferralEyesRschApproachID = 1 AND ReferralEyesRschConsentID = 1 AND ReferralEyesRschConversionID = 1))
				THEN 1 ELSE 0 END) AS 'TotalTissueRecovered',

	SUM(CASE WHEN ReferralGeneralConsent = 1
					AND  (	ReferralBoneConversionID <> 1 AND
							ReferralTissueConversionID <> 1 AND
							ReferralSkinConversionID <> 1 AND
							ReferralValvesConversionID <> 1 AND
							--ReferralEyesTransConversionID <> 1 AND
							ReferralEyesRschConversionID <> 1
						 )

				AND  ((ReferralBoneApproachID = 1 AND ReferralBoneConsentID = 1 AND ReferralBoneConversionID > 1)
				OR   (ReferralTissueApproachID = 1 AND ReferralTissueConsentID = 1 AND ReferralTissueConversionID > 1)
				OR   (ReferralSkinApproachID = 1 AND ReferralSkinConsentID = 1 AND ReferralSkinConversionID > 1)
				OR   (ReferralValvesApproachID = 1 AND ReferralValvesConsentID = 1 AND ReferralValvesConversionID > 1)
				OR   (ReferralEyesRschApproachID = 1 AND ReferralEyesRschConsentID = 1 AND ReferralEyesRschConversionID > 1))
				THEN 1 ELSE 0 END) AS 'TotalTissueNotRecovered',

	SUM(CASE WHEN ReferralGeneralConsent = 1
					AND  (	ReferralBoneConversionID = -1 AND
							ReferralTissueConversionID = -1 AND
							ReferralSkinConversionID = -1 AND
							ReferralValvesConversionID = -1 AND
							--ReferralEyesTransConversionID = -1 AND
							ReferralEyesRschConversionID = -1
						 )
				AND  ((ReferralBoneApproachID = 1 AND ReferralBoneConsentID = 1 AND ReferralBoneConversionID = -1)
				OR   (ReferralTissueApproachID = 1 AND ReferralTissueConsentID = 1 AND ReferralTissueConversionID = -1)
				OR   (ReferralSkinApproachID = 1 AND ReferralSkinConsentID = 1 AND ReferralSkinConversionID = -1)
				OR   (ReferralValvesApproachID = 1 AND ReferralValvesConsentID = 1 AND ReferralValvesConversionID = -1)
				OR   (ReferralEyesRschApproachID = 1 AND ReferralEyesRschConsentID = 1 AND ReferralEyesRschConversionID = -1))
				THEN 1 ELSE 0 END) AS 'TotalTissueUnknownRecovery'
FROM @Temp_FSConversion_Select
LEFT JOIN @PersonTable AS Approach ON Approach.PersonID = SecondaryApproachedBy
LEFT JOIN @PersonTable AS Consent ON Consent.PersonID = SecondaryConsentBy
WHERE (Approach.PersonID = SecondaryApproachedBy OR Consent.PersonID = SecondaryConsentBy)


/* Total_Referrals */
INSERT INTO @TempCounts
SELECT
	1 AS 'FormatCode',
	'Total Referrals' AS 'Category',
	@TotalReferralsTotalReferrals AS 'TotalReferralsTotalReferrals',
	SUM(CASE WHEN ReferralBoneApproachID = 1
				OR   ReferralTissueApproachID = 1
				OR   ReferralSkinApproachID = 1
				OR   ReferralValvesApproachID = 1
				OR   ReferralEyesTransApproachID = 1
				OR   ReferralEyesRschApproachID = 1
				THEN 1 ELSE 0 END) AS 'TotalReferralsApproached',

	SUM(CASE WHEN ReferralGeneralConsent = 1
				AND  ((ReferralBoneApproachID = 1 AND ReferralBoneConsentID = 1)
				OR   (ReferralTissueApproachID = 1 AND ReferralTissueConsentID = 1)
				OR   (ReferralSkinApproachID = 1 AND ReferralSkinConsentID = 1)
				OR   (ReferralValvesApproachID = 1 AND ReferralValvesConsentID = 1)
				OR   (ReferralEyesTransApproachID = 1 AND ReferralEyesTransConsentID = 1)
				OR   (ReferralEyesRschApproachID = 1 AND ReferralEyesRschConsentID = 1))
				THEN 1 ELSE 0 END) AS 'TotalReferralsConsented',

	SUM(CASE WHEN ReferralGeneralConsent = 1
				AND  ((ReferralBoneApproachID = 1 AND ReferralBoneConsentID = 1 AND ReferralBoneConversionID = 1)
				OR   (ReferralTissueApproachID = 1 AND ReferralTissueConsentID = 1 AND ReferralTissueConversionID = 1)
				OR   (ReferralSkinApproachID = 1 AND ReferralSkinConsentID = 1 AND ReferralSkinConversionID = 1)
				OR   (ReferralValvesApproachID = 1 AND ReferralValvesConsentID = 1 AND ReferralValvesConversionID = 1)
				OR   (ReferralEyesTransApproachID = 1 AND ReferralEyesTransConsentID = 1 AND ReferralEyesTransConversionID = 1)
				OR   (ReferralEyesRschApproachID = 1 AND ReferralEyesRschConsentID = 1 AND ReferralEyesRschConversionID = 1))
				THEN 1 ELSE 0 END) AS 'TotalReferralsRecovered',

	SUM(CASE WHEN ReferralGeneralConsent = 1
						AND  (	ReferralBoneConversionID <> 1 AND
							ReferralTissueConversionID <> 1 AND
							ReferralSkinConversionID <> 1 AND
							ReferralValvesConversionID <> 1 AND
							ReferralEyesTransConversionID <> 1 AND
							ReferralEyesRschConversionID <> 1
						 )

				AND  ((ReferralBoneApproachID = 1 AND ReferralBoneConsentID = 1 AND ReferralBoneConversionID > 1)
				OR   (ReferralTissueApproachID = 1 AND ReferralTissueConsentID = 1 AND ReferralTissueConversionID > 1)
				OR   (ReferralSkinApproachID = 1 AND ReferralSkinConsentID = 1 AND ReferralSkinConversionID > 1)
				OR   (ReferralValvesApproachID = 1 AND ReferralValvesConsentID = 1 AND ReferralValvesConversionID > 1)
				OR   (ReferralEyesTransApproachID = 1 AND ReferralEyesTransConsentID = 1 AND ReferralEyesTransConversionID > 1)
				OR   (ReferralEyesRschApproachID = 1 AND ReferralEyesRschConsentID = 1 AND ReferralEyesRschConversionID > 1))
				THEN 1 ELSE 0 END) AS 'TotalReferralsNotRecovered',

	SUM(CASE WHEN ReferralGeneralConsent = 1
						AND  (	ReferralBoneConversionID = -1 AND
							ReferralTissueConversionID = -1 AND
							ReferralSkinConversionID = -1 AND
							ReferralValvesConversionID = -1 AND
							ReferralEyesTransConversionID = -1 AND
							ReferralEyesRschConversionID = -1
						 )

				AND  ((ReferralBoneApproachID = 1 AND ReferralBoneConsentID = 1 AND ReferralBoneConversionID = -1)
				OR   (ReferralTissueApproachID = 1 AND ReferralTissueConsentID = 1 AND ReferralTissueConversionID = -1)
				OR   (ReferralSkinApproachID = 1 AND ReferralSkinConsentID = 1 AND ReferralSkinConversionID = -1)
				OR   (ReferralValvesApproachID = 1 AND ReferralValvesConsentID = 1 AND ReferralValvesConversionID = -1)
				OR   (ReferralEyesTransApproachID = 1 AND ReferralEyesTransConsentID = 1 AND ReferralEyesTransConversionID = -1)
				OR   (ReferralEyesRschApproachID = 1 AND ReferralEyesRschConsentID = 1 AND ReferralEyesRschConversionID = -1))
				THEN 1 ELSE 0 END) AS 'TotalReferralsUnknownRecovery'
FROM @Temp_FSConversion_Select
LEFT JOIN @PersonTable AS Approach ON Approach.PersonID = SecondaryApproachedBy
LEFT JOIN @PersonTable AS Consent ON Consent.PersonID = SecondaryConsentBy
WHERE (Approach.PersonID = SecondaryApproachedBy OR Consent.PersonID = SecondaryConsentBy)



SELECT
		ID,
		FormatCode, -- Values to format row: 0 = None, 1 = Bold, 2 = Bold & Italic 
		Category,
		ISNULL(TotalReferrals, 0) AS 'TotalReferrals', 
		ISNULL(Approached, 0) AS 'Approached',
		ISNULL(Consented, 0) AS 'Consented',
		ISNULL(Recovered, 0) AS 'Recovered',
		ISNULL(NotRecovered, 0) AS 'NotRecovered',
		ISNULL(UnknownRecovery, 0) AS 'UnknownRecovery'
FROM @TempCounts


--Use to return data less formating codes
--SELECT Category, TotalReferrals, Approached, Consented, Recovered, NotRecovered, UnknownRecovery
--FROM @TempCounts

/* Test for Total referrals
SELECT Approach.*, Consent.* ,* 
FROM @Temp_FSConversion_Select
LEFT JOIN @PersonTable AS Approach ON Approach.PersonID = SecondaryApproachedBy
LEFT JOIN @PersonTable AS Consent ON Consent.PersonID = SecondaryConsentBy
WHERE (Approach.PersonID = SecondaryApproachedBy OR Consent.PersonID = SecondaryConsentBy)
AND ReferralGeneralConsent = 1
AND  ((ReferralBoneApproachID = 1 AND ReferralBoneConsentID = 1 AND ReferralBoneConversionID <> 1)
OR   (ReferralTissueApproachID = 1 AND ReferralTissueConsentID = 1 AND ReferralTissueConversionID <> 1)
OR   (ReferralSkinApproachID = 1 AND ReferralSkinConsentID = 1 AND ReferralSkinConversionID <> 1)
OR   (ReferralValvesApproachID = 1 AND ReferralValvesConsentID = 1 AND ReferralValvesConversionID <> 1)
OR   (ReferralEyesTransApproachID = 1 AND ReferralEyesTransConsentID = 1 AND ReferralEyesTransConversionID <> 1)
OR   (ReferralEyesRschApproachID = 1 AND ReferralEyesRschConsentID = 1 AND ReferralEyesRschConversionID <> 1))
*/


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



