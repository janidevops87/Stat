SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Access]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_Access]
GO


CREATE PROCEDURE spu_Access
		@WebPersonID 	INT	= 0,
		@Access 		INT	= 0
AS

If @WebPersonID <> 0 AND @Access <> 0
BEGIN
		UPDATE WebPerson
		SET Access=@Access
		WHERE WebPersonID=@WebPersonID
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

