SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUser    Script Date: 5/14/2007 10:02:42 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUser]
GO




CREATE PROCEDURE sps_WebUser
		@Access 		INT	= 0
AS
SET NOCOUNT ON
If @Access <> 0
BEGIN

	SELECT * FROM webuser, registry
	WHERE access & @Access <> 0	
	AND webuser.RegistryID *= registry.ID

--	SELECT * FROM webuser
--	WHERE access & @Access <> 0
END















GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

