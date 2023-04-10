 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardReferralsSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardReferralsSelect'
		DROP Procedure DashboardReferralsSelect
	END
GO
PRINT 'Creating Procedure DashboardReferralsSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: DashboardReferralsSelect.sql
**	Name: DashboardReferralsSelect
**	Desc: List active referrals
**	Auth: jth
**	Date: Sept. 2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	07/23/15		Aykut Ucar				Added 8 digit numbers to quick search		
**	07/06/20		Mike Berenson			Refactor - round 1
**	07/06/20		Mike Berenson			Refactor - round 2
*******************************************************************************/

CREATE PROCEDURE DashboardReferralsSelect
	-- Add the parameters for the stored procedure here
	@startDateTime		DATETIME,
	@endDatetime		DATETIME,
	@timeZone			VARCHAR(2),
	@callNumber			VARCHAR(11) = NULL,
	@organizationName	VARCHAR(80) = NULL,
	@statAbbreviation	VARCHAR(2) = NULL,
	@referralDonorFirstName VARCHAR(40) = NULL,
	@referralDonorLastName VARCHAR(40) = NULL,
	@currentReferralTypeName VARCHAR(50) = NULL,
	@previousReferralTypeName VARCHAR(50) = NULL,
	@sourceCodeName VARCHAR(10) = NULL,
	@statEmployeeFirstName VARCHAR(50) = NULL,
	@statEmployeeLastName VARCHAR(50) = NULL,
	@userOrganizationID INT
AS
BEGIN
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

	--Added 8 digit numbers to quick search					 
	IF ((LEN(@callNumber) = 7 OR LEN(@callNumber) = 8) AND PATINDEX('-', @callNumber) = 0)
	BEGIN
		SELECT
			@callId = @callNumber,
			@startDateTime = NULL,
			@endDatetime = NULL,
			@callNumber = NULL,
			@organizationName = NULL,
			@statAbbreviation = NULL,
			@referralDonorFirstName = NULL,
			@referralDonorLastName = NULL,
			@currentReferralTypeName = NULL,
			@previousReferralTypeName = NULL,
			@sourceCodeName = NULL,
			@statEmployeeFirstName = NULL,
			@statEmployeeLastName = NULL;
	END

	DROP TABLE IF EXISTS #sourceCodes;
	DROP TABLE IF EXISTS #callsFilteredByDate;
	
	CREATE TABLE #sourceCodes
	(
		SourceCodeID INT
	);

	-- Load #sourceCodes If Not Statline
	IF @userOrganizationID <> @stalineOrganizationID
	BEGIN
		INSERT INTO #sourceCodes
		SELECT WebReportGroupSourceCode.SourceCodeID
		FROM WebReportGroupSourceCode
		JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
		WHERE WebReportGroup.OrgHierarchyParentID = @userOrganizationID;
	END

	-- Load #callsFilteredByDate With CallIDs	
	SELECT
		Call.CallID
	INTO #callsFilteredByDate
	FROM
		Call
	WHERE		
		(@endDatetime IS NULL OR CallDateTime <= @endDatetime)
	AND 
		(@startDateTime IS NULL OR CallDateTime >= @startDateTime)
	AND
		(@CallID IS NULL OR Call.CallID = @CallID);
	
	SELECT DISTINCT 
		Call.CallID,
		Call.CallNumber,
		DATEADD(
				hh, 
				dbo.fn_TimeZoneDifference
											(
												@TimeZone, 
												Call.CallDateTime
											), 
				Call.CallDateTime) 
				AS 
					'CallDateTime',
		Referral.ReferralDonorFirstName,
		Referral.ReferralDonorLastName,
		Organization.OrganizationName,
		State.StateAbbrv,
		CASE 
				WHEN (Call.CallTypeID = 1 AND ABS(Referral.ReferralTypeID) = 1) THEN 'OTE' 
				WHEN (Call.CallTypeID = 1 AND Referral.ReferralTypeID = 2) THEN  'TE'
				WHEN (Call.CallTypeID = 1 AND Referral.ReferralTypeID = 3) THEN 'E'
				WHEN (Call.CallTypeID = 1 AND Referral.ReferralTypeID = 4) THEN 'RO' 
			END AS PrevReferralTypeName,
		CASE Referral.CurrentReferralTypeID
			WHEN -1 THEN 'OTE'
			ELSE ReferralType.ReferralAbbreviation
		END AS ReferralTypeName,
		SourceCodeName,
		StatEmployeeFirstName,
		StatEmployeeLastName,
		Person.OrganizationID 
	FROM 
		Call	 
	JOIN
		#callsFilteredByDate c ON c.CallID = Call.CallID
	JOIN	
		Referral ON Call.CallID = Referral.CallID 
	LEFT JOIN 
		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN 
		State ON State.StateID = Organization.StateID 
	LEFT JOIN 
		ReferralType ON ReferralType.ReferralTypeID = Referral.CurrentReferralTypeID 
	LEFT JOIN	
		ReferralType PrevRefType ON Referral.ReferralTypeId = PrevRefType.ReferralTypeId 
	LEFT JOIN
		SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN
		StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN
		Person ON Person.PersonID = StatEmployee.PersonID 
	LEFT JOIN
		#sourceCodes sc ON Call.SourceCodeID = sc.SourceCodeID
	WHERE 
		(
			@userOrganizationID = @stalineOrganizationID
			OR sc.SourceCodeID IS NOT NULL
		)
	AND
		(@callNumber IS NULL OR PATINDEX(@callNumber + '%', ISNULL(Call.CallNumber, @callNumber)) <> 0)
	AND
		(@organizationName IS NULL OR PATINDEX(@organizationName + '%', ISNULL(Organization.OrganizationName, @organizationName)) <> 0)
	AND
		(@statAbbreviation IS NULL OR PATINDEX(@statAbbreviation + '%', ISNULL(State.StateAbbrv, @statAbbreviation)) <> 0)
	AND
		(@referralDonorFirstName IS NULL OR PATINDEX(@referralDonorFirstName + '%', ISNULL(Referral.ReferralDonorFirstName, @referralDonorFirstName)) <> 0)
	AND
		(@referralDonorLastName IS NULL OR PATINDEX(@referralDonorLastName + '%', ISNULL(Referral.ReferralDonorLastName, @referralDonorLastName)) <> 0)
	AND
		(@currentReferralTypeName IS NULL OR PATINDEX(@currentReferralTypeName + '%', ISNULL(ReferralType.ReferralAbbreviation, @currentReferralTypeName)) <> 0)
	AND
		(@previousReferralTypeName IS NULL OR PATINDEX(@previousReferralTypeName + '%', ISNULL(PrevRefType.ReferralAbbreviation, @previousReferralTypeName)) <> 0)
	AND
		(@sourceCodeName IS NULL OR PATINDEX(@sourceCodeName + '%', ISNULL(SourceCode.SourceCodeName, @sourceCodeName)) <> 0)
	AND
		(@statEmployeeFirstName IS NULL OR PATINDEX(@statEmployeeFirstName + '%', ISNULL(StatEmployee.StatEmployeeFirstName, @statEmployeeFirstName)) <> 0)
	AND
		(@statEmployeeLastName IS NULL OR PATINDEX(@statEmployeeLastName + '%', ISNULL(StatEmployee.StatEmployeeLastName, @statEmployeeFirstName)) <> 0)	
	AND
		CallActive <> 0  
	AND
		(@callId IS NULL OR Call.CallID = @callId)
	ORDER BY CallDateTime DESC;	

	DROP TABLE IF EXISTS #sourceCodes;
	DROP TABLE IF EXISTS #callsFilteredByDate;
END
GO
