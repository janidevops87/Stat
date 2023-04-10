SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetUserInRoleByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetUserInRoleByName]
GO





CREATE PROCEDURE dbo.GetUserInRoleByName
	@roleName nvarchar(256)
AS

	DECLARE @roleID int

	EXEC GetRoleIdByName @roleName, @roleID OUT

	SELECT WebPerson.WebPersonID AS UserID, WebPerson.WebPersonUserName AS UserName
	FROM Roles 
		JOIN UserRoles
			ON Roles.RoleID = UserRoles.RoleID
		JOIN WebPerson
			ON UserRoles.WebPersonID = WebPerson.WebPersonID
	WHERE Roles.RoleID = @roleID

RETURN




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

