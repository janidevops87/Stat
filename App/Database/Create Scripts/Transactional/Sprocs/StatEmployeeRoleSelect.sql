 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'StatEmployeeRoleSelect')
	BEGIN
		PRINT 'Dropping Procedure StatEmployeeRoleSelect'
		DROP Procedure StatEmployeeRoleSelect
	END
GO

PRINT 'Creating Procedure StatEmployeeRoleSelect'
GO

CREATE PROCEDURE dbo.StatEmployeeRoleSelect
(
	@statEmployeeId  int
)
AS
/***************************************************************************************************
**	Name: StatEmployeeRoleSelect
**	Desc: Select User Roles based on StateEmployeeId
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Bret Knoll		Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	WebPerson.WebPersonID, 
	WebPerson.PersonID, 
	Roles.RoleID, 
	Roles.RoleName, 
	UserRoles.LastModified AS LastModified,
	UserRoles.LastStatEmployeeID AS LastStatEmployeeID, 
	UserRoles.AuditLogTypeID AS AuditLogTypeID
FROM 
	WebPerson 
JOIN 
	StatEmployee ON WebPerson.PersonID = StatEmployee.PersonID
JOIN 
	UserRoles ON WebPerson.WebPersonID = UserRoles.WebPersonID
JOIN 
	Roles ON UserRoles.RoleID = Roles.RoleID
WHERE StatEmployee.StatEmployeeID = @statEmployeeId	

ORDER BY WebPersonID, RoleID;

GO
GO

GRANT EXEC ON StatEmployeeRoleSelect TO PUBLIC
GO
