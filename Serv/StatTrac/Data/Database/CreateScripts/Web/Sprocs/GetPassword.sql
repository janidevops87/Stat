if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetPassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetPassword]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





CREATE PROCEDURE dbo.GetPassword
	@name nvarchar(256)
AS
	SET NOCOUNT ON

	SELECT	
		CONVERT(VARBINARY(64),WebPersonPassword) AS Password		
	FROM WebPerson wp
	JOIN Person p ON p.PersonID = wp.personID
	WHERE 
		WebPersonUserName = @name
	AND
		p.Inactive = 0

	SET NOCOUNT OFF

RETURN




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 