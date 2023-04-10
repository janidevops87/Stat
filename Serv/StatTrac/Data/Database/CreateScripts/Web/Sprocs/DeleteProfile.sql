SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteProfile]
GO






CREATE PROCEDURE dbo.DeleteProfile
	@userName nvarchar(256)
AS

	DECLARE @userId int 

	EXEC GetUserIdByName @userName, @userId OUT

	DELETE Profiles 
	WHERE WebPersonID = @userId






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

