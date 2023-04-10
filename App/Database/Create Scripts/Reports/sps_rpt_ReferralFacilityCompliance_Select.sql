SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER OFF;
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_rpt_ReferralFacilityCompliance_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sps_rpt_ReferralFacilityCompliance_Select];
GO

CREATE Procedure [dbo].[sps_rpt_ReferralFacilityCompliance_Select]
	@ReferralStartDateTime		DATETIME	= NULL,
	@ReferralEndDateTime		DATETIME	= NULL,	
	@ReportGroupID				INT			= NULL,
	@OrganizationID				INT			= NULL,
	@SourceCodeName				VARCHAR(10) = NULL,
	@DisplayMT					INT			= NULL

AS
/******************************************************************************
**		File: sps_rpt_ReferralFacilityCompliance_Select.sql
**		Name: sps_rpt_ReferralFacilityCompliance_Select
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
**		See above
**
**		Auth: christopher carroll
**		Date: 10/20/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      10/20/2008		ccarroll			Initial release
**      12/29/2008      jth                 added ,0 in select to handle change from parent
**		7/13/2010		sd					Correct the Where Statement for @Organization Search
**      07/2010         jth                 fixes to get images to work
**      12/12/2016      mberenson			Added DLA Registry
*******************************************************************************/
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;

	DECLARE
		@AdjustedReferralStartDateTime	DATETIME = DATEADD(HH, -4, @ReferralStartDateTime),
		@AdjustedReferralEndDateTime	DATETIME = DATEADD(HH, 4, @ReferralEndDateTime);

	-- Load #SourceCodes
	SELECT SourceCodeId 
	INTO #SourceCodes
	FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName);	
	
	-- Load #ConvertedCalls with Converted DateTimes
	SELECT 
		Referral.CallID,
		dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT) 'CallDateTime'
	INTO #ConvertedCalls
	FROM
		Referral
		INNER JOIN [Call] ON Referral.CallID = [Call].CallID
		INNER JOIN #SourceCodes SC ON Call.SourceCodeID = SC.SourceCodeId
	WHERE
			Call.CallDateTime >= @AdjustedReferralStartDateTime
		AND Call.CallDateTime <= @AdjustedReferralEndDateTime;
			
	-- Load #ConvertedCalls with Filtered Converted Calls
	SELECT 
		CallID	
	INTO #FilteredCalls
	FROM #ConvertedCalls
	WHERE
		CallDateTime >= @ReferralStartDateTime
		AND CallDateTime <= @ReferralEndDateTime;

	-- Select filtered calls with details
	SELECT DISTINCT
		Referral.ReferralCallerOrganizationID AS 'OrganizationID',
		Organization.OrganizationName,
		COUNT(fc.CallID) AS 'TotalReferrals',
		SUM(CASE WHEN RegistryStatus.RegistryStatus = 1			-- StateRegistry
						OR RegistryStatus.RegistryStatus = 2	-- WebRegistry
						OR RegistryStatus.RegistryStatus = 4	-- Manually Found
						OR RegistryStatus.RegistryStatus = 6	-- DlaRegistry
					THEN 1
					ELSE 0 END
			)				 AS 'TotalRegistered',
	
		SUM(CASE WHEN  Referral.ReferralDonorDeathDate IS NOT NULL
					THEN 1
					ELSE 0 END
			)				 AS 'TotalCTOD'
	FROM #FilteredCalls fc
		JOIN Referral ON Referral.CallID = fc.CallID 
		LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
		LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		LEFT JOIN RegistryStatus ON fc.CallID = RegistryStatus.CallID
	WHERE
		-- Search ReportGroup
		(@ReportGroupID IS NULL OR WebReportGroupOrg.WebReportGroupID = @ReportGroupID)	
		-- Search Organization
		AND	(@OrganizationID IS NULL OR @OrganizationID = 0 OR Referral.ReferralCallerOrganizationID = @OrganizationID)
	GROUP BY
		Referral.ReferralCallerOrganizationID,
		Organization.OrganizationName;
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;

END
GO