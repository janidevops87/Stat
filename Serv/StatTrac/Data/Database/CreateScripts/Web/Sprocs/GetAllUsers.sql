SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetAllUsers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetAllUsers]
GO





CREATE PROCEDURE dbo.GetAllUsers
AS

	SET NOCOUNT ON
	
	SELECT WebPersonUserName AS UserName
	FROM WebPerson





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

