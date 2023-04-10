  IF EXISTS (SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'DashboardUpdateSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardUpdateSelect';
		DROP Procedure DashboardUpdateSelect;
	END
GO
PRINT 'Creating Procedure DashboardUpdateSelect';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE DashboardUpdateSelect
	-- Add the parameters for the stored procedure here
	@startDateTime			datetime = null,
	@endDatetime			datetime = null,
	@timeZone				varchar(2),
	@callNumber			varchar(15) = null,
	@organizationName	VARCHAR(80) = NULL,
	@statAbbreviation	VARCHAR(2) = NULL,
	@referralDonorFirstName VARCHAR(40) = NULL,
	@referralDonorLastName VARCHAR(40) = NULL,
	@currentReferralTypeName VARCHAR(50) = NULL,
	@previousReferralTypeName VARCHAR(50) = NULL,
	@sourceCodeName VARCHAR(10) = NULL,
	@statEmployeeFirstName VARCHAR(50) = NULL,
	@statEmployeeLastName VARCHAR(50) = NULL,
	@userOrganizationID int
AS
BEGIN
/******************************************************************************
**	File: DashboardUpdateSelect.sql
**	Name: DashboardUpdateSelect
**	Desc: List update referrals 
**	Auth: jth
**	Date: Sept. 2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	02/25/2011		ccarroll				Removed Distinct. Changed JOIN order
**  03/2011			jth						removed qa criteria, don't use max on 
**											lastmodified, removed statemployee not 888, changed join to statemployee to logevent statemployee
**  06/11           jth						lookup call in logevent and not call to speed up, added incoming call criteria and use logeventdate instead of lastmod
**  08/11			jth						was left joining to referral, which meant messages were showing up
**  11/26/2014		Bret					Cleanup the Where clause to not use functions
**	12/18/2018		Mike Berenson			Optimized performance
*******************************************************************************/

-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- declare @callid to query only by callid
DECLARE 
	@callId					INT,
	@stalineOrganizationID	INT = 194;
-- adjust the time for the time zone
SELECT
	@startDateTime	= DATEADD(
								hh, 
								-dbo.fn_TimeZoneDifference
									(
										@TimeZone, 
										@startDateTime
									),
								@startDateTime		
							),
	@endDatetime = DATEADD(
								hh, 
								-dbo.fn_TimeZoneDifference
									(
										@TimeZone, 
										@endDatetime
									),
								@endDatetime		
							);
							 
IF ((LEN(@callNumber) = 7 OR LEN(@callNumber) = 8) AND PATINDEX('-', @callNumber)=0 )
BEGIN
	SELECT
		@callId						= @callNumber,
		@startDateTime				= NULL,
		@endDatetime				= NULL,
		@callNumber					= NULL,
		@organizationName			= NULL,
		@statAbbreviation			= NULL,
		@referralDonorFirstName		= NULL,
		@referralDonorLastName		= NULL,
		@currentReferralTypeName	= NULL,
		@previousReferralTypeName	= NULL,
		@sourceCodeName				= NULL,
		@statEmployeeFirstName		= NULL,
		@statEmployeeLastName		= NULL;
END

DROP TABLE IF EXISTS #InitialSelect;

--dates are always sent unless callid sent in. Must reduce number of rows for select logevent and referral are really slow unless limited.
SELECT DISTINCT
	LogEvent.CallID,
	LogEvent.LogEventID
INTO #InitialSelect
FROM LogEvent
	INNER JOIN Call ON Call.CallID = LogEvent.CallID
WHERE 
	(
		(@callId IS NULL
			AND LogEvent.LogEventDateTime >= @startDateTime
			AND LogEvent.LogEventDateTime <= @endDatetime
		)
		OR
		LogEvent.CallId = @callId
	);

SELECT DISTINCT
	[Call].CallID,
	[Call].CallNumber,
	LogEvent.LogEventDateTime AS 'CallDateTime',
	IsNull(Referral.ReferralDonorFirstName, '') AS ReferralDonorFirstName,
	IsNull(Referral.ReferralDonorLastName, '') AS ReferralDonorLastName,
	Organization.OrganizationName,
	[State].StateAbbrv,	
	CASE 
		WHEN Referral.ReferralTypeID = -1 THEN 'OTE'
		ELSE PreReferralType.ReferralAbbreviation
	END AS PrevReferralTypeName,
	CASE 
		WHEN Referral.CurrentReferralTypeID = -1 THEN 'OTE'
		ELSE ReferralType.ReferralAbbreviation
	END AS ReferralTypeName,
	SourceCode.SourceCodeName,
	StatEmployee.StatEmployeeFirstName,
	StatEmployee.StatEmployeeLastName,
	Person.OrganizationID	
FROM	#InitialSelect initSel	
	INNER JOIN  [Call] ON initSel.CallId = [Call].CallID 
	INNER JOIN	LogEvent ON initSel.LogEventID = LogEvent.LogEventID
	INNER JOIN	Referral ON [Call].CallID = Referral.CallID
	LEFT JOIN 	StatEmployee ON LogEvent.StatEmployeeID  = StatEmployee.StatEmployeeID 
	LEFT JOIN 	Person ON StatEmployee.PersonID = Person.PersonID 
	LEFT JOIN WebReportGroup
			INNER JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
		ON Call.SourceCodeID = WebReportGroupSourceCode.SourceCodeID
	LEFT JOIN	Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationID 
	LEFT JOIN	[State] ON Organization.StateID = [State].StateID
	LEFT JOIN	FSCase ON [Call].CallID = FSCase.CallID
	LEFT JOIN	ReferralType ON Referral.CurrentReferralTypeID = ReferralType.ReferralTypeID
	LEFT JOIN	ReferralType AS PreReferralType ON Referral.ReferralTypeID = PreReferralType.ReferralTypeId
	LEFT JOIN 	SourceCode ON [Call].SourceCodeID = SourceCode.SourceCodeID

WHERE 			
		(
			@userOrganizationID = @stalineOrganizationID
			OR
			(
				WebReportGroupSourceCode.SourceCodeID IS NOT NULL
			AND WebReportGroup.OrgHierarchyParentID = @userOrganizationID
			)
		)		
	AND (LogEvent.LogEventTypeID = (2)			-- Incoming Call
			OR LogEvent.LogEventTypeID = (7)	-- Consent Outcome
			OR LogEvent.LogEventTypeID = (8)	-- Recovery Outcome
			OR LogEvent.LogEventTypeID = (24)	-- Case Update
		)
	AND	LogEvent.StatEmployeeID <> '77' -- Online event update    
	AND LogEvent.LogEventNumber <> 1
	AND (
		/* Search (wildcards permitted) - CallNumber */
		(
			@callNumber IS NULL
		OR	PATINDEX(@callNumber + '%', [Call].CallNumber) > 0
		)
		/* Search (wildcards permitted) - Location */
		AND (
				@organizationName IS NULL
			OR	PATINDEX( @organizationName + '%' , Organization.OrganizationName) > 0
		)
		/* Search (wildcards permitted) - State */
		AND (
				@statAbbreviation IS NULL
			OR	PATINDEX(@statAbbreviation + '%', State.StateAbbrv) > 0
		)
		/* Search (wildcards permitted) - PatientFirst */
		AND (
				@referralDonorFirstName IS NULL
			OR	PATINDEX(@referralDonorFirstName + '%', Referral.ReferralDonorFirstName) > 0
		)
		/* Search (wildcards permitted) - PatientLast */
		AND (
				@referralDonorLastName IS NULL
			OR	PATINDEX(@referralDonorLastName + '%', Referral.ReferralDonorLastName) > 0
		)
		/* Search (wildcards permitted) - ReferralType */
		AND (
				@currentReferralTypeName IS NULL
			OR	PATINDEX(@currentReferralTypeName + '%', ReferralType.ReferralAbbreviation) > 0
		)
		/* Search (wildcards permitted) - PreReferralType */
		AND (
				@previousReferralTypeName IS NULL
			OR	PATINDEX(@previousReferralTypeName + '%', PreReferralType.ReferralAbbreviation) > 0
		)
		/* Search (wildcards permitted) - SourceCodeName */
		AND (
				@sourceCodeName IS NULL
			OR	PATINDEX(@sourceCodeName+ '%', SourceCode.SourceCodeName) > 0
		)
		/* Search (wildcards permitted) - TcName */
		AND (
				@statEmployeeFirstName IS NULL
			OR	PATINDEX(@statEmployeeFirstName + '%', StatEmployee.StatEmployeeFirstName) > 0
			)
		AND (
				@statEmployeeLastName IS NULL
			OR	PATINDEX(@statEmployeeLastName + '%', StatEmployee.StatEmployeeLastName) > 0
			)
		AND	(
				FSCase.CallID IS NULL
				OR FSCase.FSCaseFinalDateTime IS NOT NULL
			)
		)
ORDER BY
	CallDateTime DESC;

DROP TABLE IF EXISTS #InitialSelect;

END
GO