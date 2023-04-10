SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetRoleIdByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetRoleIdByName]
GO





CREATE PROCEDURE dbo.GetRoleIdByName
	@name	nvarchar(256),
	@roleID int OUT
AS

	SELECT @roleID = RoleID 
	FROM Roles 
	WHERE RoleName = @name

RETURN




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

