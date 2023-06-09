SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_FSHourlySummary]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sps_FSHourlySummary];
GO


CREATE PROCEDURE [dbo].[sps_FSHourlySummary]

	@vStartDate		DATETIME	= NULL ,
	@vEndDate		DATETIME  	= NULL ,
	@vEmployeeID	INT			= NULL ,
	@SourceCodeName	VARCHAR(10) = NULL ,
	@PersonOrgID	INT			= 194  -- DEFAULT 194 for statline

AS
/******************************************************************************
**		File: sps_FSHourlySummary.sql
**		Name: sps_FSHourlySummary
**		Desc: Returns summary data for the FS Hourly report
**
**              
**		Return values:
** 
**		Called by:   'FS Hourly.rdl'
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: ?
**		Date: ?
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      8/20/2020		mberenson			Added to source control
**		
*******************************************************************************/
BEGIN

	DECLARE 
		@StartMonth		INT = MONTH(@vStartDate),
		@StartDay		INT = DAY(@vStartDate),
		@StartYear		INT = YEAR(@vStartDate),
		@EndMonth		INT = MONTH(@vEndDate),
		@EndDay			INT = DAY(@vEndDate),
		@EndYear		INT = YEAR(@vEndDate);	

	SELECT 	
		se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName	AS 'Statline Employee',
		sc.SourceCodeName											AS 'Source Code',
		rfh.HourID													AS 'Hour', 		
		SUM(rfh.SecondaryScreeningCount)							AS 'Secondary Screening', 
		SUM(rfh.FamilyApproachCount)								AS 'Family Approach', 
		SUM(rfh.TotalApproachesCount)								AS 'Total Approaches', 
		SUM(rfh.FamilyUnavailableCount)								AS 'Family Unavailable', 
		SUM(rfh.ConsentCount)										AS 'Consent', 
		SUM(rfh.MedSocCount)										AS 'Med/Soc'  		
	FROM 	
		Referral_FSHourlyCount rfh
		JOIN _ReferralProdReport.dbo.StatEmployee se ON se.StatEmployeeID = rfh.StatEmployeeID
		JOIN _ReferralProdReport.dbo.Person p ON p.PersonID = se.PersonID
		LEFT JOIN _ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = rfh.SourceCodeID
	WHERE	
			(
				(rfh.YearID > @StartYear)
				OR (rfh.YearID = @StartYear AND rfh.MonthID >= @StartMonth)
				OR (rfh.YearID = @StartYear AND rfh.MonthID = @StartMonth AND rfh.DayID >= @StartDay)
			)
		AND (
				(rfh.YearID < @EndYear)
				OR (rfh.YearID = @EndYear AND rfh.MonthID <= @EndMonth)
				OR (rfh.YearID = @EndYear AND rfh.MonthID = @EndMonth AND rfh.DayID <= @EndDay)
			)	
		AND (@vEmployeeID IS NULL OR rfh.StatEmployeeID = @vEmployeeID)
		AND (@SourceCodeName IS NULL OR sc.SourceCodeName = @SourceCodeName)
		AND (@PersonOrgID IS NULL OR p.OrganizationID = @PersonOrgID)
	GROUP BY
		sc.SourceCodeName,
		se.StatEmployeeFirstName,
		se.StatEmployeeLastName,
		rfh.HourID  
	ORDER BY	
		sc.SourceCodeName,
		se.StatEmployeeFirstName,
		se.StatEmployeeLastName,
		rfh.HourID;

END
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

