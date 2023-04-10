SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetAllRoles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetAllRoles]
GO





CREATE PROCEDURE dbo.GetAllRoles
AS

	SET NOCOUNT ON
	
	SELECT
		RoleID, 
		RoleName
	FROM 
		Roles
	ORDER BY
		RoleName






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

