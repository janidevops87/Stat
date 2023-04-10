SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddProfile]
GO





CREATE PROCEDURE dbo.AddProfile
	@userName nvarchar(256),
	@profile binary(4096)
AS

	DECLARE @userId int 

	EXEC GetUserIdByName @userName, @userId OUT

	INSERT Profiles 
		(WebPersonID, [profile])
	VALUES
		(@userId, @profile)





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

