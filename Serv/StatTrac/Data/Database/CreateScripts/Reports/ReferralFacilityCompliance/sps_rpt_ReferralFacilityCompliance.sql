IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralFacilityCompliance')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralFacilityCompliance'
		DROP  Procedure  sps_rpt_ReferralFacilityCompliance
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralFacilityCompliance'
GO


CREATE Procedure sps_rpt_ReferralFacilityCompliance
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

--Declare @ReferralStartDateTime		DateTime 
--Declare	@ReferralEndDateTime		DateTime 
	
--Declare	@ReportGroupID				int 
--Declare	@OrganizationID				int 
--Declare	@SourceCodeName				varchar(10) 
--Declare	@UserOrgId					int 
--declare @DisplayMT					int


--set @ReferralStartDateTime = '1/1/10'
--set @ReferralEndDateTime = '1/31/10'
--set @ReportGroupID = 37
--set @OrganizationID = 4

------	@DisplayMT					int = Null



SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @YearStartID Int
DECLARE @YearEndID Int

DECLARE @MonthStartID Int
DECLARE @MonthEndID Int

SET @YearStartID = CAST(DatePart(yyyy, @ReferralStartDateTime) AS Int)
SET @MonthStartID = CAST(DatePart(m, @ReferralStartDateTime) AS Int)

SET @YearEndID = CAST(DatePart(yyyy, @ReferralEndDateTime) AS Int)
SET @MonthEndID = CAST(DatePart(m, @ReferralEndDateTime) AS Int)

DECLARE @CustomCode AS Int
		

/* Set CustomCode */
EXEC @CustomCode = fn_GetOrganizationCustomReport @UserOrgID

--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */

--	/* determine if date range is in Archive db */
--	DECLARE @maxTableDate DATETIME
--	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

--		IF (ISNULL(@ReferralStartDateTime, GetDate()) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 1
--			END 

--		IF (    ISNULL(@ReferralStartDateTime, GetDate()) < @maxTableDate 
--			AND ISNULL(@ReferralEndDateTime, GetDate()) < @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 2
--			END 

--		IF (    ISNULL(@ReferralStartDateTime, GetDate()) < @maxTableDate 
--			AND ISNULL(@ReferralEndDateTime, GetDate()) > @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 3
--			END 




CREATE TABLE #sps_rpt_ReferralFacilityComplianceResults
   (
--	[CallID] [int] NULL,
	[OrganizationID] [int] NULL,
	[OrganizationName] [varchar] (100) NULL,
	[ReportCustomCode] [int] null,
	[TotalReferrals] [int] NULL,
	[TotalRegistered] [int] NULL,
	[TotalCTOD] [int] NULL,
	[ClientReportedDeaths] [int] NULL
	
	)

--CREATE TABLE #Temp_OrganizationDeaths
  -- (
--	[OrganizationID] [int] NULL,
--	[ClientReportedDeaths] [int] NULL
--	)


----INSERT #Temp_OrganizationDeaths
INSERT #sps_rpt_ReferralFacilityComplianceResults
SELECT 
		OrganizationID,'',@CustomCode,0,0,0,
		sum(TotalDeaths)
FROM vwDataWarehouseOrganizationDeaths OrganizationDeaths

WHERE
		IsNull(@OrganizationID, OrganizationID) = OrganizationID
		AND CONVERT(datetime, Cast(OrganizationDeaths.MonthID AS varchar(2))+ '/01/' + Cast(OrganizationDeaths.YearID AS varchar(4)) ) BETWEEN @ReferralStartDateTime AND @ReferralEndDateTime


--		AND (OrganizationDeaths.YearID >= @YearStartID
--		AND OrganizationDeaths.MonthID >= @MonthStartID)
--		AND (OrganizationDeaths.YearID <= @YearEndID
--		AND OrganizationDeaths.MonthID <= @MonthEndID)

GROUP BY
		OrganizationID

--***TEST***
-- SELECT * FROM #Temp_OrganizationDeaths

	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_ReferralFacilityComplianceResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralFacilityCompliance_Select
	--						@ReferralStartDateTIme,
	--						@ReferralEndDateTime,
	--						@ReportGroupID,
	--						@OrganizationID,
	--						@SourceCodeName,
	--						@UserOrgId,
	--						@DisplayMT

	--				/* run in production database */
	--				INSERT #sps_rpt_ReferralFacilityComplianceResults 
	--					EXEC sps_rpt_ReferralFacilityCompliance_Select
	--						@ReferralStartDateTIme,
	--						@ReferralEndDateTime,
	--						@ReportGroupID,
	--						@OrganizationID,
	--						@SourceCodeName,
	--						@UserOrgid,
	--						@DisplayMT
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #sps_rpt_ReferralFacilityComplianceResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralFacilityCompliance_Select
	--						@ReferralStartDateTIme,
	--						@ReferralEndDateTime,
	--						@ReportGroupID,
	--						@OrganizationID,
	--						@SourceCodeName,
	--						@UserOrgId,
	--						@DisplayMT
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
			INSERT #sps_rpt_ReferralFacilityComplianceResults 
				EXEC sps_rpt_ReferralFacilityCompliance_Select
							@ReferralStartDateTIme,
							@ReferralEndDateTime,
							@ReportGroupID,
							@OrganizationID,
							@SourceCodeName,
							@UserOrgId,
							@DisplayMT
			--END


/* Get SourcodeList for User ReportGroupID */
DECLARE @SourceCodeList varchar(200)
if(db_name() like '%dev%')
BEGIN
	exec sps_GetReportGroupSourceCodeList @ReportGroupID, @SourceCodeList output
END
ELSE
BEGIN
	exec _ReferralProd_DataWarehouse.dbo.sps_GetReportGroupSourceCodeList @ReportGroupID, @SourceCodeList output
END	



SELECT
		Organization.OrganizationID,
		Organization.OrganizationName,
		@CustomCode as ReportCustomCode, SUM(ISNull(TotalReferrals,0)) AS 'TotalReferrals',
		SUM(ISNull(TotalRegistered, 0)) AS 'TotalRegistered',
		SUM(ISNull(TotalCTOD, 0)) AS 'TotalCTOD',
		@SourceCodeList AS 'SourceCodeList',
		SUM(ClientReportedDeaths) AS 'ClientReportedDeaths',
		CASE WHEN IsNull(SUM(ClientReportedDeaths), 0) > 0
			 THEN IsNull(CAST(SUM(TotalCTOD) AS Decimal), 0)/CAST(SUM(ClientReportedDeaths) AS Decimal) 
		END AS 'PercentCompliance',
		CASE WHEN IsNull(SUM(ClientReportedDeaths), 0) > 0
			 THEN 
				CASE WHEN SUM(ClientReportedDeaths) <= SUM(TotalCTOD) THEN '100 %' ELSE
					CAST(CAST((IsNull(CAST(SUM(TotalCTOD) AS Decimal), 0)/CAST(SUM(ClientReportedDeaths) AS Decimal)* 100) AS numeric(4,0)) AS varchar(15)) + ' %'
				END
			 ELSE  '-'
		END AS '%_Compliance'
FROM Organization
-- left join #Temp_OrganizationDeaths OrganizationDeaths on OrganizationDeaths.OrganizationID = ReferralFacilityComplianceResults.OrganizationID 
LEFT JOIN #sps_rpt_ReferralFacilityComplianceResults ReferralFacilityComplianceResults ON Organization.OrganizationID = ReferralFacilityComplianceResults.OrganizationID
JOIN webreportgrouporg ON webreportgrouporg.OrganizationID = Organization.OrganizationID
WHERE webreportgrouporg.webreportgroupid = @ReportGroupID 
and (Organization.OrganizationID = @OrganizationID or @OrganizationID is null)
GROUP BY
Organization.OrganizationID,
Organization.OrganizationName,
ReportCustomCode





DROP TABLE #sps_rpt_ReferralFacilityComplianceResults

--DROP TABLE #Temp_OrganizationDeaths
