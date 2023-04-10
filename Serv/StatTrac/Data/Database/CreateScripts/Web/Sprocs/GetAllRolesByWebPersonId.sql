IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetAllRolesByWebPersonId')
	BEGIN
		PRINT 'Dropping Procedure  GetAllRolesByWebPersonId'
		DROP  Procedure  GetAllRolesByWebPersonId
	END

PRINT 'Dropping CREATE Procedure GetAllRolesByWebPersonId'
GO

CREATE Procedure GetAllRolesByWebPersonId
	@WebPersonID INT
/******************************************************************************
**		File: 
**		Name: GetAllRolesByWebPersonId
**		Desc: Loads all roles available to users
**
** 
**		Called by:   Statline.StatTrac.Web.UI Add/Edit Role Screen
**              
**
**		Auth: Bret Knoll
**		Date: 3/13/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		3/13/2008	Bret Knoll			initial
*******************************************************************************/
AS

-- determine if the user making the change is statline 
DECLARE @StatlineUser bit
SELECT 
	@StatlineUser =	CASE 
					WHEN p.OrganizationID = 194 
					THEN 1 
					ELSE 0 
					END 
FROM 
	Person p
WHERE 
	p.PersonID IN	(
						SELECT DISTINCT							
							PersonID 
						FROM 
							WebPerson 
						WHERE 
							WebPersonID = @WebPersonID)

SELECT     
	RoleID, 
	RoleName, 
	RoleDescription, 
	ISNULL(Inactive, 0) AS 'Inactive', 
	LastStatEmployeeID, 
	AuditLogTypeID
FROM         Roles AS r
WHERE     
	-- The user making the changes has access
	(RoleID IN
				(
				SELECT	RoleID 
				FROM	Roles 
				WHERE	@StatlineUser = 1
				UNION
				SELECT	RoleID
				FROM	UserRoles ur
				WHERE	ur.WebPersonID = @WebPersonID
				AND		ur.RoleID IN
						(
						SELECT	RoleID
						FROM	UserRoles 
						INNER JOIN	WebPerson ON UserRoles.WebPersonID = WebPerson.WebPersonID 
						INNER JOIN	Person ON WebPerson.PersonID = Person.PersonID
						WHERE (Person.OrganizationID IN (
								SELECT     wrgo.OrganizationId
								FROM         WebReportGroup wrg
								JOIN WebReportGroupOrg wrgo ON wrgo.WebReportGroupId = wrg.WebReportGroupID
								WHERE     (wrg.OrgHierarchyParentID IN (
											SELECT     Person.OrganizationID
											FROM         WebPerson INNER JOIN
																  Person ON WebPerson.PersonID = Person.PersonID
											WHERE     (WebPerson.WebPersonID = @WebPersonId)
											))
								))
						)

				)
	)
ORDER BY 
	r.RoleName

GO


GRANT EXEC ON GetAllRolesByWebPersonId TO PUBLIC

GO


