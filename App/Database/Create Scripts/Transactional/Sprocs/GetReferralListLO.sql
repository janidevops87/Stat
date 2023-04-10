IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetReferralListLO')
	BEGIN
		PRINT 'Dropping Procedure GetReferralListLO'
		DROP  Procedure  GetReferralListLO
	END

GO

PRINT 'Creating Procedure GetReferralListLO'
GO
CREATE Procedure GetReferralListLO
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
	@userOrganizationID INT
AS

/******************************************************************************
**		File: GetReferralListLO.sql
**		Name: GetReferralListLO
**		Desc: 
**
**              
**		Return values:
**		
**		Called by:   
**			StatTrac.ModStatQuery.QueryOpenReferral        
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List.
**		Auth: Bret Knoll
**		Date: 6/15/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		6/17/07		Bret Knoll			8.4.3.3 Prevent Timeout
**		08/07/2008	ccarroll			8.4.6 ASP visibility based on Secondary Pending
**										Organization when Contact Req.
**		9/3/08		Bret Knoll			Rolled Back change from 08/07/2008
**		12/08/2009	ccarroll			Removed table alias in ORDER BY for SQL Server 2008 update.
**		03/16/2010	ccarroll			Added this note for inclusion in release
********************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	-- declare @callid to query only by callid
	DECLARE @callId INT

	-- adjust the time for the time zone
	SET @startDateTime	= DATEADD(
									hh, 
									-dbo.fn_TimeZoneDifference
										(
											@TimeZone, 
											@startDateTime
										),
									@startDateTime		
								)	

	SET @endDatetime = DATEADD(
									hh, 
									-dbo.fn_TimeZoneDifference
										(
											@TimeZone, 
											@endDatetime
										),
									@endDatetime		
							 )
IF( LEN(@callNumber) = 7 AND PATINDEX('-', @callNumber)=0 )
BEGIN
	SET @callId = @callNumber
	SET @startDateTime		= NULL
	SET @endDatetime		= NULL	
	SET @callNumber			= NULL
	SET @organizationName	= NULL
	SET @statAbbreviation	= NULL
	SET @referralDonorFirstName = NULL
	SET @referralDonorLastName = NULL
	SET @currentReferralTypeName = NULL
	SET @previousReferralTypeName = NULL
	SET @sourceCodeName = NULL
	SET @statEmployeeFirstName = NULL
END
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
	Referral.ReferralDonorName,
	Organization.OrganizationName,
	PrevRefType.ReferralTypeName AS PrevReferralTypeName,
	ReferralType.ReferralTypeName,
	SourceCodeName,
	StatEmployeeFirstName + ' ' + StatEmployeeLastName AS StatEmployee,
	Person.OrganizationID 
FROM 
	CALL	 
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
WHERE 
	CallDateTime <= ISNULL(@endDatetime, CallDateTime )
AND 
	CallDateTime >= ISNULL(@startDateTime, CallDateTime )
AND 
	Call.SourceCodeID IN
						(
							SELECT
								WebReportGroupSourceCode.SourceCodeID
							FROM
								WebReportGroup
							JOIN	
								WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
							WHERE
								WebReportGroup.OrgHierarchyParentID = @userOrganizationID	
						)
AND	
	ReferralCallerOrganizationID IN
									(
										SELECT 	DISTINCT										
											WebReportGroupOrg.OrganizationID
										FROM
											WebReportGroup
										JOIN	
											WebReportGroupOrg ON WebReportGroupOrg.WebReportGroupID = WebReportGroup.WebReportGroupID
										WHERE
											WebReportGroup.OrgHierarchyParentID = @userOrganizationID										
									)
AND
	ISNULL(PATINDEX(@callNumber + '%', 
				ISNULL(Call.CallNumber, 0) 
			), -1) <> 0 
AND
	ISNULL(PATINDEX( @organizationName + '%' ,
			  Organization.OrganizationName), -1) <> 0
AND
	ISNULL(PATINDEX(@statAbbreviation + '%', 
			 ISNULL(State.StateAbbrv, 0)), -1) <> 0			
AND
	ISNULL(PATINDEX(@referralDonorFirstName + '%',
					ISNULL(Referral.ReferralDonorFirstName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@referralDonorLastName + '%',
					ISNULL(Referral.ReferralDonorLastName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@currentReferralTypeName + '%',
					ISNULL(ReferralType.ReferralTypeName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@previousReferralTypeName + '%',
					ISNULL(PrevRefType.ReferralTypeName, 0)), -1) <> 0		
AND
	ISNULL(PATINDEX(@sourceCodeName+ '%',
					ISNULL(SourceCode.SourceCodeName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeFirstName + '%',
		   StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName 
			), -1) <> 0
AND
	CallActive <> 0  
AND
	Call.CallID = ISNULL(@callId, Call.CallID)		
ORDER BY CallDateTime DESC;



GO

GRANT EXEC ON GetReferralListLO TO PUBLIC

GO
