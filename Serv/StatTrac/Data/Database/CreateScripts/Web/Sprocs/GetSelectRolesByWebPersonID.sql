IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetSelectRolesByWebPersonID')
	BEGIN
		PRINT 'Dropping Procedure GetSelectRolesByWebPersonID'
		DROP  Procedure  GetSelectRolesByWebPersonID
	END

GO

PRINT 'Creating Procedure GetSelectRolesByWebPersonID'
GO
CREATE Procedure GetSelectRolesByWebPersonID
	@WebPersonID INT -- WebPersonID with assigned roles
AS

/******************************************************************************
**		File: GetSelectRolesByWebPersonID.sql
**		Name: GetSelectRolesByWebPersonID
**		Desc: 
**
**		Return values:
**				UserRoles Table and the Role.Name field
**		Called by:   
**              AdminReferrenceDB.FillAvailableRolesList
**
**		Auth: Bret Knoll
**		Date: 01/13/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-----------------------------------------
**		1/13/08		Bret Knoll			Initial    
*******************************************************************************/

SELECT     
	UserRoles.WebPersonID, 
	UserRoles.RoleID, 
	Roles.RoleName
FROM         
	UserRoles 
INNER JOIN
	Roles ON UserRoles.RoleID = Roles.RoleID
WHERE     
	(UserRoles.WebPersonID = @WebPersonID)
ORDER BY 
	Roles.RoleName


GO

GRANT EXEC ON GetSelectRolesByWebPersonID TO PUBLIC

GO
