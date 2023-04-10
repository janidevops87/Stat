SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_AccessType    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AccessType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AccessType]
GO


CREATE PROCEDURE sps_AccessType
		@Access 		varchar(500)	= null

AS

If @Access IS NOT NULL
BEGIN
	SELECT * FROM accesstype 
	WHERE access=@Access
	AND AccessName IS NOT NULL
END
ELSE
BEGIN
	SELECT * FROM accesstype 
	WHERE AccessName IS NOT NULL
END



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

