SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_MessageCountSummary1]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sps_MessageCountSummary1];
GO

CREATE PROCEDURE sps_MessageCountSummary1
	@vReportGroupID		INT			= 0,
	@vStartDate			DATETIME	= NULL,
	@vEndDate			DATETIME	= NULL,
	@vOrgID				INT			= 0,
	@vSourceCodeName 	VARCHAR(50)	= NULL
AS
/******************************************************************************
**		File: 
**		Name: sps_MessageCountSummary
**		Desc: select proc for billable count summary...brings in message count
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: jth
**		Date: 03/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      09/08       jth                 if org 194 selected, then null org parm and select orgid to itself 

**		04/10		sd					Added Organization 
*******************************************************************************/
BEGIN

	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DECLARE
		@StartYear	INT = YEAR(@vStartDate),
		@StartMonth INT = MONTH(@vStartDate),
		@StartDay	INT = DAY(@vStartDate),
		@EndYear	INT = YEAR(@vEndDate),
		@EndMonth	INT = MONTH(@vEndDate),
		@EndDay		INT = DAY(@vEndDate);

	IF @vOrgID = 194 -- Statline
	BEGIN
		SET @vOrgID	= NULL;
	END
	
	DROP TABLE IF EXISTS #SourceCodes;

	-- Load #SourceCodes
	SELECT SourceCodeId 
	INTO #SourceCodes
	FROM fnDataWarehousefn_SourceCodeList(@vReportGroupID, @vSourceCodeName);
	
	SELECT	
		SUM(ISNULL(rmcs.TotalMessages, 0)) AS 'TotalMessages',
		SUM(ISNULL(rmcs.TotalImports, 0)) AS 'TotalImports',
		SUM(ISNULL(rmcs.TotalMessages, 0) + ISNULL(TotalImports, 0)) AS 'TotalImportsMessages', 
		scv.SourceCodeName AS 'SourceName',
		orgid.OrganizationName	
    FROM
		Referral_MessageCountSummary rmcs
		JOIN #SourceCodes scf ON rmcs.SourceCodeID = scf.SourceCodeId
		JOIN vwDataWarehouseSourceCode scv ON scv.SourceCodeID = rmcs.SourceCodeID
		LEFT JOIN dbo.vwDataWarehouseOrganization orgid on rmcs.Organizationid = orgid.organizationid	
   	WHERE 		
   		(@vOrgID IS NULL OR rmcs.OrganizationID = @vOrgID)
		AND	
		(
			rmcs.YearID > @StartYear
			OR (rmcs.YearID = @StartYear AND rmcs.MonthID > @StartMonth)
			OR (rmcs.YearID = @StartYear AND rmcs.MonthID = @StartMonth AND rmcs.DayID >= @StartDay)
		)
		AND		
		(
			rmcs.YearID < @EndYear
			OR (rmcs.YearID = @EndYear AND rmcs.MonthID < @EndMonth)
			OR (rmcs.YearID = @EndYear AND rmcs.MonthID = @EndMonth AND rmcs.DayID <= @EndDay)
		)
	GROUP BY 
		SourceCodeName, 
		OrganizationName
	ORDER BY 
		scv.SourceCodeName;
	
	DROP TABLE IF EXISTS #SourceCodes;

END
GO