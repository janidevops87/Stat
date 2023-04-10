IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_rpt_OutcomeByCategory_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sps_rpt_OutcomeByCategory_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sps_rpt_OutcomeByCategory_Select]
	@ReferralStartDateTime		DATETIME		= NULL,
	@ReferralEndDateTime		DATETIME  		= NULL,
	@ReportGroupID				INT				= NULL, 
	@OrganizationID				INT				= NULL,
	@SourceCodeName				VARCHAR (10)	= NULL,
	@DisplayMT					INT				= NULL 

AS
	
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
BEGIN

	-- set transaction isolation level
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		@DisplayMT = ISNULL(@DisplayMT, 0),
		@ReferralStartDateTime = ISNULL(
											@ReferralStartDateTime, 
											CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110)
										),
		@ReferralEndDateTime = ISNULL	(
											@ReferralEndDateTime, 
											CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
										);
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #CallsFilteredBy_CallDateTime;	
	DROP TABLE IF EXISTS #CallsFilteredBy_ConvertedCallDateTime;

	-- Load temp table with source codes
	SELECT SourceCodeID 
	INTO #SourceCodes
	FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName);

	-- Load temp table with calls filtered by CallDateTime	
	CREATE TABLE #CallsFilteredBy_CallDateTime (
		CallID					INT,
		CallDateTime			DATETIME,
		ConvertedCallDateTime	DATETIME  NULL
	);

	INSERT INTO #CallsFilteredBy_CallDateTime(CallID, CallDateTime, ConvertedCallDateTime)
	SELECT 
		[Call].CallID,
		[Call].CallDateTime,
		NULL
	FROM 
		[Call]
	WHERE
		(
			(
				@ReferralStartDateTime IS NULL
			OR	CallDateTime >= DATEADD(HH, -4, @ReferralStartDateTime)
			)
		AND	(
				@ReferralEndDateTime IS NULL
			OR	CallDateTime <= DATEADD(HH, 4, @ReferralEndDateTime)
			)
		);

	-- Populate temp table with Converted CallDateTime 
	UPDATE c
	SET ConvertedCallDateTime = dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, c.CallDateTime, @DisplayMT)
	FROM #CallsFilteredBy_CallDateTime c
		JOIN Referral ON Referral.CallID = c.CallID;
	
	-- Load temp table with calls filtered by Converted CallDateTime			
	SELECT 
		CallID, 
		CallDateTime		
	INTO #CallsFilteredBy_ConvertedCallDateTime
	FROM #CallsFilteredBy_CallDateTime subQuery
	WHERE
		(
			(
				@ReferralStartDateTime IS NULL
			OR	ConvertedCallDateTime >= @ReferralStartDateTime
			)
		AND (
				@ReferralEndDateTime IS NULL
			OR	ConvertedCallDateTime <= @ReferralEndDateTime
			)
		);

	-- Run final select
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
		JOIN #CallsFilteredBy_ConvertedCallDateTime fc ON fc.CallID = Call.CallID
		JOIN #SourceCodes sc ON sc.SourceCodeID = Call.SourceCodeID
		JOIN Referral ON Call.CallID = Referral.CallID
		LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
		LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Call.CallID  
	WHERE
		(@ReportGroupID IS NULL OR WebReportGroupOrg.WebReportGroupID = @ReportGroupID)
		AND (@OrganizationID IS NULL OR Referral.ReferralCallerOrganizationID = @OrganizationID)
		AND (@ReportGroupID IS NULL OR WebReportGroupOrg.WebReportGroupID = @ReportGroupID) 
	ORDER BY 
		Call.CallID;
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #CallsFilteredBy_CallDateTime;	
	DROP TABLE IF EXISTS #CallsFilteredBy_ConvertedCallDateTime;

END

GO