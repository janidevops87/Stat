IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetUsersInRole')
	BEGIN
		PRINT 'Dropping Procedure GetUsersInRole'
		DROP  Procedure  GetUsersInRole
	END

GO

PRINT 'Creating Procedure GetUsersInRole'
GO
CREATE Procedure GetUsersInRole
	@RoleId		INT,
	@WebPersonId INT	
AS

/******************************************************************************
**		File: GetUsersInRole.sql
**		Name: GetUsersInRole
**		Desc: Loads if users are associated with the role
**
**		Called by:  Admin and Roles storedprocedures
**              
**		Author:		Bret Knoll
**		Create date: 04/04/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		04/04/08	Bret Knoll			Initial
*******************************************************************************/
-- determine if the user making the change is statline 
DECLARE @StatlineUser bit
SELECT 
	@StatlineUser =	dbo.IsStatline(@WebPersonId)

SELECT     
	WebPerson.WebPersonID, 
	WebPerson.WebPersonUserName, 
	Person.PersonLast + ', ' + Person.PersonFirst 'PersonName', 
	Person.Inactive
FROM 
	WebPerson        
INNER JOIN 
	Person ON WebPerson.PersonID = Person.PersonID
WHERE
	(	--- Statline Employee
			WebPersonID IN
				--- webperson with access to a role
				(--- WebPersonID IN
					SELECT	UserRoles.WebPersonID
					FROM	UserRoles 					
					WHERE	(UserRoles.RoleID = @RoleId)
					AND		(@StatlineUser = 1)
				)--- WebPersonID IN
			AND		(@StatlineUser = 1)
	)	--- Statline Employee

OR
	(	--- non Statline Employee
		(WebPersonID IN
			 --- webperson with access to role and in current users list of organizations they have access to through report groups
			(--- WebPersonID IN
				SELECT	UserRoles.WebPersonID
				FROM	UserRoles 				
				WHERE	(UserRoles.RoleID = @RoleId)
				AND		(UserRoles.WebPersonID IN
							 --- webperson in current users list of organizations they have access to through report groups
							(--- UserRoles.WebPersonID IN
							SELECT	WebPerson.WebPersonID
							FROM	WebPerson 
							INNER JOIN Person ON WebPerson.PersonID = Person.PersonID 
							--INNER JOIN Organization ON Person.OrganizationID = Organization.OrganizationID 
							INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Person.OrganizationID
							WHERE	(WebReportGroupOrg.WebReportGroupID IN
										 --- report groups under users organization
										(--- SELECT IN
										SELECT	
											WebReportGroup.WebReportGroupID
										FROM	
											WebPerson 
										INNER JOIN
											Person ON WebPerson.PersonID = Person.PersonID 
										INNER JOIN
											WebReportGroup ON Person.OrganizationID = WebReportGroup.OrgHierarchyParentID
										WHERE     
											(WebPerson.WebPersonID = @WebPersonID)
										)--- SELECT IN
									)
							AND
								(@StatlineUser = 0)
						)
				)
			)--- WebPersonID IN
			OR
			 WebPersonID IN	
				(-- get users organization
				
					SELECT	UserRoles.WebPersonID
					FROM	UserRoles 
					WHERE	(UserRoles.RoleID = @RoleId)
					AND		(UserRoles.WebPersonID IN
									(
									SELECT WebPersonID
									FROM WebPerson
									WHERE PersonID IN (
														SELECT PersonID 
														FROM Person 
														WHERE OrganizationID IN
																(
																	SELECT Person.OrganizationID 
																	FROM WEBPERSON
																	JOIN Person ON Person.PersonID = WebPerson.PersonID
																	WHERE WebPersonID = @WebPersonID
																)
														)
									)
							)
					
				
				)-- get users organization
			)
			
			
				AND
					(@StatlineUser = 0)
			
	)--- non Statline Employee

ORDER BY Person.PersonLast, Person.PersonFirst 


GO

GRANT EXEC ON GetUsersInRole TO PUBLIC

GO



