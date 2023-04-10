/****** Object:  StoredProcedure [dbo].[sps_WebUserbyID]    Script Date: 03/01/2011 14:26:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_WebUserbyID]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE [dbo].[sps_WebUserbyID]'
	PRINT GETDATE()
	DROP PROCEDURE [dbo].[sps_WebUserbyID]
END	
GO

PRINT 'CREATE PROCEDURE [dbo].[sps_WebUserbyID]'
PRINT GETDATE()
/****** Object:  StoredProcedure [dbo].[sps_WebUserbyID]    Script Date: 03/01/2011 14:26:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sps_WebUserbyID]
		@WebUserID 		INT	= 0
AS
SET NOCOUNT ON
If @WebUserID <> 0
BEGIN

	SELECT * FROM webuser
	LEFT JOIN registry ON WEBUSER.RegistryID = REGISTRY.ID
	WHERE webuserid=@WebUserID

END




GO

