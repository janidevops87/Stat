IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetUserListByOrganizationID')
	BEGIN
		PRINT 'Dropping Procedure GetUserListByOrganizationID'
		DROP  Procedure  GetUserListByOrganizationID
	END

GO

PRINT 'Creating Procedure GetUserListByOrganizationID'
GO
CREATE Procedure GetUserListByOrganizationID
	@OrganizationID INT,
	@Inactive INT = NULL
AS

/******************************************************************************
**		File: GetUserListByOrganizationID.sql
**		Name: GetUserListByOrganizationID
**		Desc: Obtains a list of users for a give Orgainzation
**
**              
**		Return values:
** 
**		Called by:   UserAdminControl.ascx
**               
**		Auth: Bret Knoll
**		Date: 1/6/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		1/6/2008	Bret Knoll			initial
*******************************************************************************/

SELECT     
	WebPerson.WebPersonID, 
	WebPerson.PersonID, 
	WebPerson.WebPersonUserName, 
	CASE
		WHEN 
			Person.PersonLast + Person.PersonFirst + Person.PersonMI IS NULL		
		THEN
			se.StatEmployeeLastName + ', ' + se.StatEmployeeFirstName
		ELSE
				Person.PersonLast + ', ' +  Person.PersonFirst + ' ' + Person.PersonMI 
	END	'PersonName', 
    Person.Inactive
FROM
	Person 
JOIN
	WebPerson ON Person.PersonID = WebPerson.PersonID
LEFT JOIN
	StatEmployee se ON se.PersonID = Person.PersonID	
WHERE     
	(Person.OrganizationID = @OrganizationID)
AND
	(Person.Inactive = CASE WHEN ISNULL(@Inactive, 0) = 0 THEN 0 ELSE Person.Inactive END)	
ORDER BY 	
	CASE
		WHEN 
			Person.PersonLast + Person.PersonFirst + Person.PersonMI IS NULL		
		THEN
			se.StatEmployeeLastName + ', ' + se.StatEmployeeFirstName
		ELSE
				Person.PersonLast + ', ' +  Person.PersonFirst + ' ' + Person.PersonMI 
	END	

GO

GRANT EXEC ON GetUserListByOrganizationID TO PUBLIC

GO
