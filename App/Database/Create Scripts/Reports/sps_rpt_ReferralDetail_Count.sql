IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = object_id(N'[dbo].[sps_rpt_ReferralDetail_Count]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_ReferralDetail_Count';
		DROP  PROCEDURE  sps_rpt_ReferralDetail_Count;
	END

GO

PRINT 'Creating Procedure: sps_rpt_ReferralDetail_Count';
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

CREATE PROCEDURE [dbo].[sps_rpt_ReferralDetail_Count]
(
	@CallID					int			= NULL,
	@ReferralStartDateTime	datetime	= NULL,
	@ReferralEndDateTime	datetime	= NULL,
	@CardiacStartDateTime	datetime	= NULL,
	@CardiacEndDateTime		datetime	= NULL,
	@ReportGroupID			int			= NULL,
	@OrganizationID			int			= NULL,
	@SourceCodeName			varchar(10)	= NULL,
	@CoordinatorID			int			= NULL,
	@LowerAgeLimit			int			= NULL,
	@UpperAgeLimit			int			= NULL,
	@Gender					varchar(1)	= NULL,
	@DisplayMT				int			= NULL
)
AS
/******************************************************************************
**	File: sps_rpt_ReferralDetail_Count.sql
**	Name: sps_rpt_ReferralDetail_Count
**	Desc:
**	
**	
**	Return values:
**	
**	Called by: ReferralDetail.rdl
**	
**	Parameters:
**	Input			Output
**	----------		-----------
**	See Above
**	
**	Auth: Bret Knoll
**	Date: 04/08/2008
**	
*******************************************************************************
**	Change History
*******************************************************************************
**	Date		Author:				Description:
**	--------	--------			-------------------------------------------
**	04/08/2008	bret				Initail release
**	08/04/2020	James Gerberich		Refactored. VS	69297
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;
----------------------------------------------------------------

DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #ConvertedDate;
DROP TABLE IF EXISTS #Calls;
----------------------------------------------------------------

-- If a Call ID is provided ignore all other parameters
IF(@CallID IS NOT NULL AND @CallID <> 0)
BEGIN SELECT
	@ReferralStartDateTime	= NULL,
	@ReferralEndDateTime	= NULL,
	@CardiacStartDateTime	= NULL,
	@CardiacEndDateTime		= NULL,
	@OrganizationID			= NULL,
	@SourceCodeName			= NULL,
	@CoordinatorID			= NULL,
	@LowerAgeLimit			= NULL,
	@UpperAgeLimit			= NULL,
	@Gender					= NULL;
END;
----------------------------------------------------------------

-- Get list of needed Source Codes 
SELECT SourceCodeID
INTO #SourceCodes
FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName);
--------------------------------

-- Converts CallDateTime to proper time zone and gets Case IDs within the date range
SELECT
	CallID,
	CallDateTime
INTO #ConvertedDate
FROM dbo.fn_rpt_ReferralDateTimeConversion
(
	@CallID,
	@ReferralStartDateTime,
	@ReferralEndDateTime,
	@CardiacStartDateTime,
	@CardiacEndDateTime,
	@DisplayMT
);
----------------------------------------------------------------

-- Get basic info for needed cases and initial filters
SELECT DISTINCT
	c.CallID,
	dbo.fn_rpt_DonorAgeYear(ReferralDOB, ReferralDonorDeathDate,ReferralDonorAge, ReferralDonorAgeUnit) AS DonorAge
INTO #Calls
FROM
	dbo.[Call] c
	INNER JOIN #SourceCodes sc ON sc.SourceCodeID = c.SourceCodeID
	INNER JOIN #ConvertedDate LT ON LT.CallID = c.CallID
	INNER JOIN Referral ON Referral.CallID = c.CallID
	INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
WHERE
	WebReportGroupOrg.WebReportGroupID = @ReportGroupID
AND	(
		@OrganizationID IS NULL
	OR	Referral.ReferralCallerOrganizationID = @OrganizationID
	)
AND	(
		@Gender IS NULL
	OR	Referral.ReferralDonorGender = @Gender
	);
--------------------------------

-- Get count
SELECT COUNT(DISTINCT c.CallID) 'RecordCount'
FROM #Calls c
	LEFT JOIN LogEvent ON c.CallID = LogEvent.CallID
WHERE
	(
		@LowerAgeLimit IS NULL
	OR	c.DonorAge >= @LowerAgeLimit
	)
AND	(
		@UpperAgeLimit IS NULL
	OR	c.DonorAge <= @UpperAgeLimit
	)
AND	(
		@CoordinatorID IS NULL
	OR	LogEvent.StatEmployeeID = @CoordinatorID
	);
----------------------------------------------------------------

-- Clean up temp tables
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #ConvertedDate;
DROP TABLE IF EXISTS #Calls;
----------------------------------------------------------------

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
