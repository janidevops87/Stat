IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetRoleById')
	BEGIN
		Print 'DROP  Procedure  GetRoleById'
		DROP  Procedure  GetRoleById
	END
Print 'CREATE Procedure GetRoleById'
GO

CREATE Procedure GetRoleById
	@RoleId INT
/******************************************************************************
**		File: 
**		Name: GetRoleById
**		Desc: Loads role by RoleId
**
** 
**		Called by:   Statline.StatTrac.Web.UI Add/Edit Role Screen
**              
**
**		Auth: Bret Knoll
**		Date: 3/31/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		3/31/2008	Bret Knoll			initial
*******************************************************************************/
AS

SELECT     
	RoleID, 
	ISNULL(RoleName, '') 'RoleName', 
	ISNULL(RoleDescription, '') 'RoleDescription',
	ISNULL(Inactive, 0) 'Inactive'
FROM         
	Roles r
WHERE     
	-- The user making the changes has access
	(RoleID = @RoleId)


GO


GRANT EXEC ON GetRoleById TO PUBLIC

GO


 