 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetRolesByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetRolesByName]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






CREATE  PROCEDURE dbo.GetRolesByName
	@name nvarchar(256)
AS

	DECLARE @userId int

	EXEC GetUserIdByName @name, @userId OUT

	SELECT 
		Roles.RoleID, 
		Roles.RoleName
	FROM WebPerson wp
		JOIN UserRoles
		ON wp.WebPersonID = UserRoles.WebPersonID
		JOIN Roles
		ON UserRoles.RoleID = Roles.RoleID
	WHERE wp.WebPersonID = @userId

RETURN





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

