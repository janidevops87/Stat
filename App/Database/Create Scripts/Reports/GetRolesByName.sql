SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

PRINT 'DROP PROCEDURE [dbo].[GetRolesByName]';
DROP PROCEDURE IF EXISTS [dbo].[GetRolesByName];
GO

PRINT 'CREATE PROCEDURE GetRolesByName';
GO

CREATE  PROCEDURE dbo.GetRolesByName
	@name nvarchar(256)
AS

 /***************************************************************************************************
**	Name: GetRolesByName
**	Desc: Look up roles for a given user
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	?			?				Initial Script Creation 
**	02/08/2021	Mike Berenson	Added to source control
**	02/08/2021	Mike Berenson	Added filter to exclude new roles
***************************************************************************************************/
BEGIN

	DECLARE @userId INT;

	EXEC GetUserIdByName @name, @userId OUT;

	SELECT 
		Roles.RoleID, 
		Roles.RoleName
	FROM WebPerson wp
		JOIN UserRoles
		ON wp.WebPersonID = UserRoles.WebPersonID
		JOIN Roles
		ON UserRoles.RoleID = Roles.RoleID
	WHERE wp.WebPersonID = @userId
	AND PATINDEX('%Report Portal%', Roles.RoleName) <= 0;

	RETURN;

END

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO