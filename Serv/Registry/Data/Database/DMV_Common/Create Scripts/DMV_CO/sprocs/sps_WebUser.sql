
/****** Object:  StoredProcedure [dbo].[sps_WebUser]    Script Date: 03/01/2011 13:08:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_WebUser]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE [dbo].[sps_WebUser]'
	PRINT GETDATE()
	DROP PROCEDURE [dbo].[sps_WebUser]
END	
GO

PRINT 'CREATE PROCEDURE [dbo].[sps_WebUser]'
PRINT GETDATE()

/****** Object:  StoredProcedure [dbo].[sps_WebUser]    Script Date: 03/01/2011 13:08:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sps_WebUser]
		@Access 		INT	= 0
AS
SET NOCOUNT ON
If @Access <> 0
BEGIN

	SELECT * FROM webuser
	LEFT JOIN registry ON WEBUSER.RegistryID = REGISTRY.ID
	WHERE access & @Access <> 0	

--	SELECT * FROM webuser
--	WHERE access & @Access <> 0
END















GO

