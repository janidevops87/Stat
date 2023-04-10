SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetProfile]
GO





CREATE PROCEDURE dbo.GetProfile
	@userName nvarchar(256),
	@profile binary(4096) OUT
AS

	DECLARE @userId int 

	EXEC GetUserIdByName @userName, @userId OUT

	SELECT 
		@profile = [Profile]
	FROM Profiles 
	WHERE WebPersonID = @userId





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

