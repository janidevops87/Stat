SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_rpt_ReferralFacilityCompliance]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sps_rpt_ReferralFacilityCompliance]
GO

CREATE Procedure [dbo].[sps_rpt_ReferralFacilityCompliance]
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@UserOrgId					int = Null,

	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralFacilityCompliance.sql
**		Name: sps_rpt_ReferralFacilityCompliance
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
**      12/23/2008      jth                 fixed join of temp tables...s/b refdata to orgdeaths
**      12/29/08        jth                 now inserts deaths into same temp table as referrals, join to webreportgroupid to get correct report group with org
**		06/17/2009		ccarroll			Changed table joins of final select to display all Organizations even if no deaths. HS-18361
**		07/13/2010		sdabiri				Added a where clause to search by @OrganizationId 
**      07/2010         jth                 Changes to get images to work
**		12/03/2012		James Gerberich		Archive database is being turned off, so
**											this sproc is modified to eliminate
**											the database selection
**		12/13/2016		Mike Berenson		Removed hard-coded database for development
*******************************************************************************/
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	DROP TABLE IF EXISTS #OrganizationDeaths;
	DROP TABLE IF EXISTS #sps_rpt_ReferralFacilityComplianceResults;
	CREATE TABLE #sps_rpt_ReferralFacilityComplianceResults
	(
		[OrganizationID]		[INT] NULL,
		[OrganizationName]		[VARCHAR] (100) NULL,
		[TotalReferrals]		[INT] NULL,
		[TotalRegistered]		[INT] NULL,
		[TotalCTOD]				[INT] NULL	
	);

	DECLARE 
		@StartMonth			INT = MONTH(@ReferralStartDateTime),
		@StartYear			INT = YEAR(@ReferralStartDateTime),
		@EndMonth			INT = MONTH(@ReferralEndDateTime),
		@EndYear			INT = YEAR(@ReferralEndDateTime),
		@ReportCustomCode	INT;	
	
	-- Look up the ReportCustomCode from the UserOrgID
	EXEC @ReportCustomCode = fn_GetOrganizationCustomReport @UserOrgID;

	-- Load #OrganizationDeaths
	SELECT 
		OrganizationID				AS 'OrganizationID',
		SUM(ISNULL(TotalDeaths, 0))	AS 'ClientReportedDeaths'
	INTO #OrganizationDeaths
	FROM 
		vwDataWarehouseOrganizationDeaths
	WHERE
		(@OrganizationID IS NULL OR OrganizationID = @OrganizationID)
		AND (
				(YearID > @StartYear)
				OR (YearID = @StartYear AND MonthID >= @StartMonth)
			)
		AND (
				(YearID < @EndYear)
				OR (YearID = @EndYear AND MonthID <= @EndMonth)
			)			
	GROUP BY
		OrganizationID;	

	-- Insert filtered details
	INSERT #sps_rpt_ReferralFacilityComplianceResults 
	EXEC sps_rpt_ReferralFacilityCompliance_Select
				@ReferralStartDateTIme,
				@ReferralEndDateTime,
				@ReportGroupID,
				@OrganizationID,
				@SourceCodeName,
				@DisplayMT;

	-- Select summary data with ReportCustomCode, ClientReportedDeaths & PercentCompliance
	SELECT
		o.OrganizationID																	AS 'OrganizationID',
		o.OrganizationName																	AS 'OrganizationName',
		@ReportCustomCode																	AS 'ReportCustomCode', 
		r.TotalReferrals																	AS 'TotalReferrals',
		r.TotalRegistered																	AS 'TotalRegistered',
		r.TotalCTOD																			AS 'TotalCTOD',
		od.ClientReportedDeaths																AS 'ClientReportedDeaths',
		CASE WHEN od.ClientReportedDeaths > 0
			THEN CAST(r.TotalCTOD AS DECIMAL) / CAST(od.ClientReportedDeaths AS DECIMAL) 
		END																					AS 'PercentCompliance'
	FROM Organization o
		JOIN WebReportGroupOrg wrgo ON wrgo.OrganizationID = o.OrganizationID
		LEFT JOIN #sps_rpt_ReferralFacilityComplianceResults r ON r.OrganizationID = o.OrganizationID
		LEFT JOIN #OrganizationDeaths od ON od.OrganizationID = o.OrganizationID
	WHERE 
		wrgo.WebReportGroupID = @ReportGroupID 
		AND (@OrganizationID IS NULL OR o.OrganizationID = @OrganizationID);
		
	DROP TABLE IF EXISTS #OrganizationDeaths;
	DROP TABLE IF EXISTS #sps_rpt_ReferralFacilityComplianceResults;

END
GO