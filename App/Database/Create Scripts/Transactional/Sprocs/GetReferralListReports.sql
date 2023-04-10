IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetReferralListReports')
	BEGIN
		PRINT 'Dropping Procedure GetReferralListReports'
		DROP  Procedure  GetReferralListReports
	END

GO

PRINT 'Creating Procedure GetReferralListReports'
GO 


CREATE Procedure GetReferralListReports 

	@startDateTime		DATETIME,
	@endDateTime		DATETIME,
	@callNumber		VARCHAR(11) = NULL,
	@PatientFirstName 	VARCHAR(40) = NULL,
	@PatientLastName 	VARCHAR(40) = NULL, 
	@ReportGroupID	int = Null,
	@OrganizationID	int = Null,
	@SpecialSearchCriteria	int = NULL,
	@BasedOnDT		VARCHAR(40) = NULL,
	@TimeZone AS varchar(2)
	
AS
/******************************************************************************
**		File: GetReferralListReports.sql
**		Name: GetReferralListReports
**		Desc: 
**
**		Called by:   
**              
**
**		Auth: jth
**		Date: 07/2008
*******************************************************************************
**		Change History
*******************************************************************************
**	  Date:		Author:		Description:
**	  --------	--------	-------------------------------------------
**    7/2008	jth			Initial
**    10/08     jth         Have to pass in timezone
**    11/08     jth         add pending ref function 
*******************************************************************************/ 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

DECLARE
	@ReferralStartDateTime	 as DATETIME,
	@ReferralEndDateTime as DATETIME,
	@CardiacStartDateTime	as DATETIME,
	@CardiacEndDateTime	as DATETIME,
	@MTZ as int	
	
SET @ReferralStartDateTime = null
SET @ReferralEndDateTime = null
SET @CardiacStartDateTime = null
SET @CardiacEndDateTime = null	
	
IF  IsNull(@callNumber, 0) <> 0 
	BEGIN
	SET @startDateTime	= Null
	SET @endDateTime	= Null
	SET @PatientFirstName		= Null
	SET @PatientLastName		= Null
	SET @OrganizationID		=Null
	SET @SpecialSearchCriteria	= 0
	SET @BasedOnDT		= Null
	--SET @ReportGroupID		= null
	
END

IF @PatientFirstName IS NOT Null
	BEGIN
		SET @PatientFirstName = REPLACE(@PatientFirstName,'*','%')
	END
IF @PatientLastName IS NOT Null
	BEGIN
		SET @PatientLastName = REPLACE(@PatientLastName,'*','%')
	END
IF @OrganizationID = 0
	BEGIN
		SET @OrganizationID = null
	END
					
	-- adjust the time for the time zone
IF @BasedOnDT = 'Referral'
	BEGIN
		SET @ReferralStartDateTime = DATEADD(hh, -dbo.fn_TimeZoneDifference(@TimeZone, @startDateTime),@startDateTime)	

		SET @ReferralEndDateTime = DATEADD(hh, -dbo.fn_TimeZoneDifference	(@TimeZone, @endDatetime),@endDatetime ) 
	END

IF @BasedOnDT = 'Cardiac Death'
	BEGIN
		SET @CardiacStartDateTime = DATEADD(hh, -dbo.fn_TimeZoneDifference(@TimeZone, @startDateTime),@startDateTime)	

		SET @CardiacEndDateTime = DATEADD(hh, -dbo.fn_TimeZoneDifference	(@TimeZone, @endDatetime),@endDatetime ) 
	END

SELECT  DISTINCT
	Call.CallID,
	Call.CallNumber, call.CallDateTime, ReferralDonorDeathDate,

	CASE WHEN (@CardiacStartDateTime Is Not Null) 
		 --THEN ISNULL(convert(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + ISNULL(ReferralDonorDeathTime, ' ')
		 THEN convert(datetime,ISNULL(convert(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + substring(ISNULL(ReferralDonorDeathTime, '00:00 '),1,5))
		 else
		 DATEADD(hh, dbo.fn_TimeZoneDifference(	@TimeZone, Call.CallDateTime), Call.CallDateTime) 
		--ELSE call.CallDateTime
		 END AS 'BasedOnDT',
	--CallDateTime as BasedOnDT,
	Referral.ReferralDonorName,
	Organization.OrganizationName,
	ReferralType.ReferralTypeName AS PreliminaryRefType,
	CurrentRefType.ReferralTypeName AS CurrentRefType,
	Referral.ReferralDonorRecNumber AS MedicalRecordNumber, 
	SourceCodeName,
	Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) + ' /' + Referral.ReferralDonorGender + ' /' + isnull(UPPER(SUBSTRING(race.RaceName,1,2)),'') AS 'A/S/R',
	StatEmployeeFirstName + ' ' + StatEmployeeLastName AS StatEmployee,
	Person.OrganizationID, 
	Referral.ReferralCallerOrganizationID,
	TimeZone.TimeZoneAbbreviation
FROM  	CALL

Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		@CallNumber						 ,
		@ReferralStartDateTime		 ,
		@ReferralEndDateTime		 ,
		@CardiacStartDateTime		 ,
		@CardiacEndDateTime			 , 
		1	 )
	) LT ON LT.CallID = Call.CallID 
JOIN	Referral ON Call.CallID = Referral.CallID 

LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.CurrentReferralTypeID 
LEFT JOIN ReferralType AS CurrentRefType ON CurrentRefType.ReferralTypeID = Referral.CurrentReferralTypeID
LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID  
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID 
LEFT JOIN TimeZone ON Organization.TimeZoneID = TimeZone.TimeZoneID

WHERE 
	
	(@SpecialSearchCriteria=dbo.fn_PendingReferralTest(Referral.CallID) 
	or
	@SpecialSearchCriteria=0) 
AND 
	/* Search - ReportGroup */
	/* broke out webReportroupOrg into a subquery of where */
	(
	(
	Call.SourceCodeID IN 
			(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID, Null))	
	AND
	Referral.ReferralCallerOrganizationID IN (	SELECT WebReportGroupOrg.OrganizationID 
												FROM WebReportGroupOrg 
												WHERE IsNull(WebReportGroupOrg.WebReportGroupID, 0) = IsNull(ISNull(@ReportGroupID, WebReportGroupOrg.WebReportGroupID), 0)
											)
	)											
	OR
	ISNULL(@ReportGroupID, 0) = 0
	)
AND	CallActive <> 0  
AND ISNULL(PATINDEX(LTRIM(RTRIM(@PatientLastName)), ISNULL(Referral.ReferralDonorLastName, 0)), -1) <> 0

AND ISNULL(PATINDEX(LTRIM(RTRIM(@PatientFirstName)), ISNULL(Referral.ReferralDonorFirstName, 0)), -1) <> 0	

/* Search - Organization */
AND IsNull(Referral.ReferralCallerOrganizationID, 0) = IsNull(ISNull(@OrganizationID, Referral.ReferralCallerOrganizationID), 0)


ORDER BY BasedOnDT desc;
GO

