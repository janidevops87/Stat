if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[GetHashPassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetHashPassword]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE dbo.GetHashPassword
	@name nvarchar(256)
AS
	SET NOCOUNT ON
IF EXISTS(SELECT 1 
FROM WebPerson wp
JOIN Person p ON p.PersonID = wp.personID
WHERE WebPersonUserName = @name AND p.Inactive = 0)
	BEGIN
		UPDATE WebPerson
		SET InternalSessionID = newid()
		WHERE 	WebPersonUserName = @name;
	SELECT	
		SaltValue,
		HashedPassword,
		InternalSessionID		
	FROM WebPerson wp
	JOIN Person p ON p.PersonID = wp.personID
	WHERE 
		WebPersonUserName = @name
	AND
		p.Inactive = 0
END
	SET NOCOUNT OFF

RETURN




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 