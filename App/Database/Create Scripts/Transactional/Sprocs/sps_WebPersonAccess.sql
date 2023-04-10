SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebPersonAccess]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebPersonAccess]
GO


CREATE PROCEDURE sps_WebPersonAccess
		@WebPersonID 		INT	= 0
AS
SET NOCOUNT ON
If @WebPersonID <> 0
BEGIN
	SELECT * FROM WebPerson
	WHERE WebPersonID=@WebPersonID
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

