 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetUserIdByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetUserIdByName]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






CREATE  PROCEDURE dbo.GetUserIdByName
	@name nvarchar(256),
	@userId int OUT
AS

	SELECT @userId = WebPersonID
	FROM WebPerson wp
	JOIN Person p ON p.PersonID = wp.PersonID
	WHERE	WebPersonUserName = @name
	AND		p.Inactive = 0

RETURN





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

