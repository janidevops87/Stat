IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetReferralListReportsCount')
	BEGIN
		PRINT 'Dropping Procedure GetReferralListReportsCount'
		DROP  Procedure  GetReferralListReportsCount
	END

GO

PRINT 'Creating Procedure GetReferralListReportsCount'
GO 


CREATE Procedure GetReferralListReportsCount 

	@startDateTime		DATETIME,
	@endDateTime		DATETIME,
	@callNumber		VARCHAR(11) = NULL,
	@PatientFirstName 	VARCHAR(40) = NULL,
	@PatientLastName 	VARCHAR(40) = NULL, 
	@ReportGroupID	int = Null,
	@OrganizationID	int = Null,
	@SpecialSearchCriteria	int = null,
	@BasedOnDT		VARCHAR(40) = NULL,
	@TimeZone AS varchar(2),
	@returnVal int OUTPUT
	
AS
/******************************************************************************
**		File: GetReferralListReportsCount.sql
**		Name: GetReferralListReportsCount
**		Desc: 
**
**		Called by:   
**              
**
**		Auth: jth
**		Date: 10/2008
*******************************************************************************
**		Change History
*******************************************************************************
**	  Date:		Author:		Description:
**	  --------	--------	-------------------------------------------
**    10/2008	jth			Initial
*******************************************************************************/ 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
set @returnval = 0
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
SELECT @returnval =count(DISTINCT Call.CallID)
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

RETURN @returnVal
GO

