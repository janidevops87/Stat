SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetPersonList1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetPersonList1]
GO

CREATE PROCEDURE  sps_GetPersonList1
	@WithStar		int,
	@ReportGroupID 	int,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@OrgID			int
with 	Recompile
AS  

/*

	0	report or call in referrals/deaths from mm/dd/yy to mm/dd/yy 
	1	Designated Requestor
	2	Organization Address 
	3	Request, but not designated / Trained from mm/dd/yy to mm/dd/yy
       	4       	Designated Requestors from mm/dd/yy to mm/dd/yy
	5	All People for this organization	--1/29/03 drh

*/

If @WithStar = 0
	SELECT 
	DISTINCT   
                        Person.PersonID,
                  	Min(CallDateTime)AS FirstCalled,  --Remove Min and Max Dates on 9/10/99
                  	Max(CallDateTime)AS LastCalled,
		Count(ReferralCallerPersonID) As NumberOfCalls,  -- Added Call Count on 9/10/99
	          	PersonLast + ', ' + PersonFirst AS PersonName,
	          	PersonTypeName AS Title

	FROM      Person
	JOIN      Organization ON Person.OrganizationID = Organization.OrganizationID
	JOIN      State ON Organization.StateID = State.StateID
	JOIN      PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
	JOIN	  WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
	JOIN	OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
	JOIN      Phone ON OrganizationPhone.PhoneID = Phone.PhoneID 
        	JOIN      Referral ON Person.PersonID = Referral.ReferralCallerPersonID
       	JOIN      Call ON Referral.CallID = Call.CallID
	WHERE 	  WebReportGroupID = @ReportGroupID   
	AND       Organization.OrganizationID = @OrgID
	AND	CallDateTime 			-- Added 9/10/99 
		Between 	@vStartDate 
		AND		@vEndDate	
	--AND       RIGHT(PersonLast, 1) <> '*'
       	GROUP 
	BY  	PersonLast + ', ' + PersonFirst,  PersonTypeName, Person.PersonID
 
	ORDER 
	BY 	PersonLast + ', ' + PersonFirst
--, OrganizationName, OrganizationAddress1, OrganizationCity, StateAbbrv, OrganizationZipCode, '(' + PhoneAreaCode + ') ' + PhonePrefix +  '-' + PhoneNumber
If @WithStar = 1
	SELECT 
	DISTINCT
                        Person.PersonID,
                  	Min(CallDateTime)AS FirstCalled,
                  	Max(CallDateTime)AS LastCalled,
		Count(ReferralCallerPersonID) As NumberOfCalls,  -- Added Call Count on 9/10/99
	          	PersonLast + ', ' + PersonFirst AS PersonName,
	          	PersonTypeName AS Title

	FROM      Person
	JOIN      Organization ON Person.OrganizationID = Organization.OrganizationID
	JOIN      State ON Organization.StateID = State.StateID

	JOIN      PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
	JOIN	  WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
	JOIN	OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
	JOIN      Phone ON OrganizationPhone.PhoneID = Phone.PhoneID 
        LEFT 
         JOIN      Referral ON Person.PersonID = Referral.ReferralApproachedByPersonID
        LEFT 
         JOIN      Call ON Referral.CallID = Call.CallID
	WHERE 	  WebReportGroupID = @ReportGroupID
	AND       Organization.OrganizationID = @OrgID
	AND       RIGHT(PersonLast, 1) = '*'
        AND       Person.Inactive = 0
	
       	GROUP 
	BY  	PersonLast + ', ' + PersonFirst,  PersonTypeName, Person.PersonID
 	ORDER 
	BY 	PersonLast + ', ' + PersonFirst

--, OrganizationName, OrganizationAddress1, OrganizationCity, StateAbbrv, OrganizationZipCode, '(' + PhoneAreaCode + ') ' + PhonePrefix +  '-' + PhoneNumber
If @WithStar = 2
	SELECT 
	DISTINCT   
	          	OrganizationName AS Hospital,
	          	OrganizationAddress1 AS Address, 
	         	 OrganizationCity AS City,
	          	StateAbbrv AS State,     
	          	OrganizationZipCode AS Zip,
	          	'(' + PhoneAreaCode + ') ' + PhonePrefix +  '-' + PhoneNumber AS Phone 
	FROM    Organization
	JOIN      State ON Organization.StateID = State.StateID
	JOIN	  WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
	JOIN	OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
	JOIN      Phone ON OrganizationPhone.PhoneID = Phone.PhoneID 
	WHERE  WebReportGroupID = @ReportGroupID   
	AND       Organization.OrganizationID = @OrgID

If @WithStar = 3
	SELECT 
	DISTINCT
                        Person.PersonID,
                        Min(CallDateTime)AS FirstCalled,
                  	Max(CallDateTime)AS LastCalled,
		Count(ReferralCallerPersonID) As NumberOfCalls,  -- Added Call Count on 9/10/99
	          	PersonLast + ', ' + PersonFirst AS PersonName,
	          	PersonTypeName AS Title
	FROM      Person
	JOIN      Organization ON Person.OrganizationID = Organization.OrganizationID
	JOIN      State ON Organization.StateID = State.StateID

	JOIN      PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
	JOIN	  WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
	JOIN	OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
	JOIN      Phone ON OrganizationPhone.PhoneID = Phone.PhoneID 
        	JOIN      Referral ON Person.PersonID = Referral.ReferralApproachedByPersonID
        	JOIN      Call ON Referral.CallID = Call.CallID
	WHERE 	  WebReportGroupID = @ReportGroupID
	AND       Organization.OrganizationID = @OrgID
	AND       RIGHT(PersonLast, 1) <> '*'
	AND	CallDateTime 			-- Added 9/10/99 
		Between 	@vStartDate 
		AND		@vEndDate	
        GROUP 
	BY  	PersonLast + ', ' + PersonFirst,  PersonTypeName, Person.PersonID
 	ORDER 
	BY 	PersonLast + ', ' + PersonFirst

If @WithStar = 4
	SELECT 
	DISTINCT
                        Person.PersonID,
                  	Min(CallDateTime)AS FirstCalled,
                  	Max(CallDateTime)AS LastCalled,
		Count(ReferralCallerPersonID) As NumberOfCalls,  -- Added Call Count on 9/10/99
	          	PersonLast + ', ' + PersonFirst AS PersonName,
	          	PersonTypeName AS Title

	FROM      Person
	JOIN      Organization ON Person.OrganizationID = Organization.OrganizationID
	JOIN      State ON Organization.StateID = State.StateID

	JOIN      PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
	JOIN	  WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
	JOIN	OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
	JOIN      Phone ON OrganizationPhone.PhoneID = Phone.PhoneID 
        	left JOIN      Referral ON Person.PersonID = Referral.ReferralApproachedByPersonID
        	left JOIN      Call ON Referral.CallID = Call.CallID
	WHERE 	  WebReportGroupID = @ReportGroupID
	AND       Organization.OrganizationID = @OrgID
	AND       RIGHT(PersonLast, 1) = '*'
	AND	(CallDateTime 			-- Added 9/10/99 
		Between 	@vStartDate 
		AND		@vEndDate)

       	GROUP 
	BY  	PersonLast + ', ' + PersonFirst,  PersonTypeName, Person.PersonID
 	ORDER 
	BY 	PersonLast + ', ' + PersonFirst

If @WithStar = 5
	SELECT DISTINCT Person.PersonID,
                  	Min(CallDateTime)AS FirstCalled,
                  	Max(CallDateTime)AS LastCalled,
		Count(ReferralCallerPersonID) As NumberOfCalls,
	          	PersonLast,
		PersonFirst,
	          	PersonTypeName AS Title,
		Person.Inactive AS Status
	FROM Person
		JOIN Organization ON Person.OrganizationID = Organization.OrganizationID
		JOIN State ON Organization.StateID = State.StateID
		JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
		JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID
	JOIN	OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
	JOIN      Phone ON OrganizationPhone.PhoneID = Phone.PhoneID 
        		LEFT JOIN Referral ON Person.PersonID = Referral.ReferralApproachedByPersonID
        		LEFT JOIN Call ON Referral.CallID = Call.CallID
	WHERE WebReportGroupID = @ReportGroupID
		AND Organization.OrganizationID = @OrgID
       	GROUP BY PersonLast, PersonFirst,  PersonTypeName, Person.PersonID,Person.Inactive
 	ORDER BY PersonLast, PersonFirst

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

