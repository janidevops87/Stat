

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ContactRoleSelect')
	BEGIN
		PRINT 'Dropping Procedure ContactRoleSelect'
		DROP Procedure ContactRoleSelect
	END
GO

PRINT 'Creating Procedure ContactRoleSelect'
GO
CREATE Procedure ContactRoleSelect
(
		@OrganizationId int = null, 
		@StatEmployeeId int = null, 
		@AllPermissions bit = 0,
		@Inactive bit = 0,
		@contactId int = null
)
AS
/******************************************************************************
**	File: ContactRoleSelect.sql
**	Name: ContactRoleSelect
**	Desc: Selects multiple rows of UserRoles and Roles
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/16/2010		Bret Knoll				Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON ;
-- First build a Table with all Organizatin People and roles
WITH RoleTable (WebPersonID, PersonID, RoleID, RoleName, LastModified, LastStatEmployeeID, AuditLogTypeID, Hidden)
AS
(
SELECT 	
	WebPerson.WebPersonID,
	WebPerson.PersonID,
	Roles.RoleID,
	Roles.RoleName,	
	GETDATE() AS LastModified,
	-1 AS LastStatEmployeeID,
	1 AS AuditLogTypeID,
	0  AS 'HIDDEN'
FROM	
	WebPerson, Roles
WHERE
	WebPerson.PersonID IN (
		SELECT PersonID 
		FROM Person 
		JOIN 
			Organization ON Person.OrganizationID = Organization.OrganizationID

		WHERE Person.OrganizationID = @OrganizationId
		AND 
			(@contactId IS NULL
			AND
			ISNULL(Person.Inactive, 0) = @Inactive)
			OR
			Person.PersonID = @contactId
		
		)
AND
	(	@AllPermissions = 1
	OR
		Roles.RoleID IN (	SELECT RoleID 
							FROM UserRoles 
							JOIN WebPerson ON UserRoles.WebPersonID = WebPerson.WebPersonID 
							Join StatEmployee ON WebPerson.PersonID = StatEmployee.PersonID WHERE StatEmployee.StatEmployeeID = @statEmployeeId )
	)
)

SELECT 
	RoleTable.WebPersonID, 
	RoleTable.PersonID, 
	RoleTable.RoleID, 
	RoleTable.RoleName, 
	COALESCE(UserRoles.LastModified, RoleTable.LastModified) AS LastModified,
	COALESCE(UserRoles.LastStatEmployeeID, RoleTable.LastStatEmployeeID) AS LastStatEmployeeID, 
	COALESCE(UserRoles.AuditLogTypeID, RoleTable.AuditLogTypeID) AS AuditLogTypeID,
	CASE WHEN UserRoles.ROLEID > 0 THEN 1 ELSE 0 END 'HIDDEN'
FROM 
	RoleTable

LEFT JOIN 
	UserRoles ON RoleTable.WebPersonID = UserRoles.WebPersonID
	AND RoleTable.RoleID = UserRoles.RoleID

ORDER BY WebPersonID, RoleName;

GO

GRANT EXEC ON ContactRoleSelect TO PUBLIC
GO
