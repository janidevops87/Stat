SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = object_id(N'[dbo].[sps_GetPersonList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[sps_GetPersonList]
	PRINT 'Dropping Procedure: sps_GetPersonList'
END
	PRINT 'Creating Procedure: sps_GetPersonList'
GO

--  sp_help person

CREATE PROCEDURE  [dbo].[sps_GetPersonList] 
	@WithStar		int,
	@ReportGroupID 	int,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@OrgID			int
AS

/******************************************************************************
**		File: sps_GetPersonList.sql
**		Name: sps_GetPersonList
**		Desc: 
**		0	report or call in referrals/deaths from mm/dd/yy to mm/dd/yy 
**		1	Designated Requestor
**		2	Organization Address 
**		3	Request, but not designated / Trained from mm/dd/yy to mm/dd/yy
**		4       Designated Requestors from mm/dd/yy to mm/dd/yy** 
**		Called by:   GetPersonList.sls
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Unknown
**		Date: 6/10/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		6/10/2008	Bret Knoll			Remove with Recompile and add Set Transaction Isolation Level
**										Modified the Query used for @WithStar = 1, remove join on Organization
**		2/06/2013	James Gerberich		Added new joins for Phone table to reflect a new table structure HS 35152
**      4/25/13		jth					sproc was timing out...added set nocount on
**		09/13/2013	ccarroll			HS 37268 Changed PersonLast to PATINDEX in Where statement for timeout issue.
*******************************************************************************/

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

IF @WithStar = 0
	SELECT DISTINCT
		Person.PersonID,
		Min(CallDateTime)AS FirstCalled,  --Remove Min and Max Dates on 9/10/99
		Max(CallDateTime)AS LastCalled,
		Count(ReferralCallerPersonID) As NumberOfCalls,  -- Added Call Count on 9/10/99
		PersonLast + ', ' + PersonFirst AS PersonName,
		PersonTypeName AS Title
	FROM
		Person
		JOIN Organization ON Person.OrganizationID = Organization.OrganizationID
		JOIN [State] ON Organization.StateID = [State].StateID
		JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
		JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
		--JOIN Phone ON Organization.PhoneID = Phone.PhoneID
		LEFT JOIN OrganizationPhone ON Organization.OrganizationId= OrganizationPhone.OrganizationId
		LEFT JOIN Phone ON OrganizationPhone.PhoneID =Phone.PhoneId
		JOIN Referral ON Person.PersonID = Referral.ReferralCallerPersonID
       	JOIN [Call] ON Referral.CallID = [Call].CallID
	WHERE
		WebReportGroupID = @ReportGroupID
	AND Organization.OrganizationID = @OrgID
	AND	CallDateTime BETWEEN @vStartDate AND @vEndDate	-- Added 9/10/99
	AND PATINDEX('*',RIGHT(PersonLast, 1)) = 0
	GROUP BY
		PersonLast + ', ' + PersonFirst,
		PersonTypeName,
		Person.PersonID
	ORDER BY
		PersonLast + ', ' + PersonFirst
		--, OrganizationName, OrganizationAddress1, OrganizationCity, StateAbbrv, OrganizationZipCode, '(' + PhoneAreaCode + ') ' + PhonePrefix +  '-' + PhoneNumber

IF @WithStar = 1
	SELECT DISTINCT
		Person.PersonID,
		Min(CallDateTime)AS FirstCalled,
		Max(CallDateTime)AS LastCalled,
		Count(ReferralCallerPersonID) As NumberOfCalls,  -- Added Call Count on 9/10/99
		PersonLast + ', ' + PersonFirst AS PersonName,
		PersonTypeName AS Title
	FROM
		Person
		JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
		JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Person.OrganizationID
		LEFT JOIN Referral ON Person.PersonID = Referral.ReferralApproachedByPersonID
		LEFT JOIN [Call] ON Referral.CallID = [Call].CallID
	WHERE
		WebReportGroupID = @ReportGroupID
	AND Person.OrganizationID IN
			(
				SELECT	OrganizationID
				FROM	Organization
				WHERE	OrganizationID = @OrgID
			)
	AND PATINDEX('*',RIGHT(PersonLast, 1)) > 0
    AND Person.Inactive = 0
	GROUP BY
		PersonLast + ', ' + PersonFirst,
		PersonTypeName,
		Person.PersonID
 	ORDER BY
 		PersonLast + ', ' + PersonFirst
		--, OrganizationName, OrganizationAddress1, OrganizationCity, StateAbbrv, OrganizationZipCode, '(' + PhoneAreaCode + ') ' + PhonePrefix +  '-' + PhoneNumber

IF @WithStar = 2
	SELECT DISTINCT
		OrganizationName AS Hospital,
		OrganizationAddress1 AS [Address],
		OrganizationCity AS City,
		StateAbbrv AS [State],
		OrganizationZipCode AS Zip,
		'(' + PhoneAreaCode + ') ' + PhonePrefix +  '-' + PhoneNumber AS Phone
	FROM
		Organization
		JOIN [State] ON Organization.StateID = State.StateID
		JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
		JOIN Phone ON Organization.PhoneID = Phone.PhoneID
	WHERE
		WebReportGroupID = @ReportGroupID
	AND Organization.OrganizationID = @OrgID

IF @WithStar = 3
	SELECT DISTINCT
		Person.PersonID,
		Min(CallDateTime)AS FirstCalled,
		Max(CallDateTime)AS LastCalled,
		Count(ReferralCallerPersonID) As NumberOfCalls,  -- Added Call Count on 9/10/99
		PersonLast + ', ' + PersonFirst AS PersonName,
		PersonTypeName AS Title
	FROM
		Person
		JOIN Organization ON Person.OrganizationID = Organization.OrganizationID
		JOIN [State] ON Organization.StateID = [State].StateID
		JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
		JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
		--JOIN Phone ON Organization.PhoneID = Phone.PhoneID
		LEFT JOIN OrganizationPhone ON Organization.OrganizationId= OrganizationPhone.OrganizationId
		LEFT JOIN Phone ON OrganizationPhone.PhoneID =Phone.PhoneId
		JOIN Referral ON Person.PersonID = Referral.ReferralApproachedByPersonID
		JOIN [Call] ON Referral.CallID = [Call].CallID
	WHERE
		WebReportGroupID = @ReportGroupID
	AND Organization.OrganizationID = @OrgID
	AND  PATINDEX('*',RIGHT(PersonLast, 1)) = 0
	AND	CallDateTime BETWEEN @vStartDate AND @vEndDate -- Added 9/10/99
	GROUP BY
		PersonLast + ', ' + PersonFirst,
		PersonTypeName,
		Person.PersonID
 	ORDER BY
 		PersonLast + ', ' + PersonFirst

If @WithStar = 4
	SELECT DISTINCT
		Person.PersonID,
		Min(CallDateTime)AS FirstCalled,
		Max(CallDateTime)AS LastCalled,
		Count(ReferralCallerPersonID) As NumberOfCalls,  -- Added Call Count on 9/10/99
		PersonLast + ', ' + PersonFirst AS PersonName,
		PersonTypeName AS Title
	FROM
		Person
		JOIN Organization ON Person.OrganizationID = Organization.OrganizationID
		JOIN [State] ON Organization.StateID = [State].StateID
		JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
		JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
		--JOIN Phone ON Organization.PhoneID = Phone.PhoneID
		LEFT JOIN OrganizationPhone ON Organization.OrganizationId= OrganizationPhone.OrganizationId
		LEFT JOIN Phone ON OrganizationPhone.PhoneID =Phone.PhoneId
        LEFT JOIN Referral ON Person.PersonID = Referral.ReferralApproachedByPersonID
        LEFT JOIN [Call] ON Referral.CallID = [Call].CallID
	WHERE
		WebReportGroupID = @ReportGroupID
	AND Organization.OrganizationID = @OrgID
	AND  PATINDEX('*',RIGHT(PersonLast, 1)) > 0
	AND	CallDateTime BETWEEN @vStartDate AND @vEndDate -- Added 9/10/99
   	GROUP BY
   		PersonLast + ', ' + PersonFirst,
   		PersonTypeName,
   		Person.PersonID
 	ORDER BY
 		PersonLast + ', ' + PersonFirst

GO

GRANT EXECUTE ON sps_GetPersonList TO PUBLIC

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

