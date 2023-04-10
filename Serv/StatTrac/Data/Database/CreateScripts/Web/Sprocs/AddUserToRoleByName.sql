SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddUserToRoleByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddUserToRoleByName]
GO





CREATE PROCEDURE dbo.AddUserToRoleByName
	@name nvarchar(256),
	@roleName nvarchar(256)
AS
DECLARE @userId int, @roleID int

EXEC GetUserIdByName @name, @userId OUT
EXEC GetRoleIdByName @roleName, @roleID OUT
IF (ISNULL(@userId, 0) <> 0 AND ISNULL(@roleID , 0) <> 0)
BEGIN
	INSERT INTO UserRoles
		(WebPersonID, RoleID)
	VALUES
		(@userId, @roleID)
END	




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

