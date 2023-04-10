SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUserbyID    Script Date: 5/14/2007 10:02:43 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserbyID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserbyID]
GO




CREATE PROCEDURE sps_WebUserbyID
		@WebUserID 		INT	= 0
AS
SET NOCOUNT ON
If @WebUserID <> 0
BEGIN

	SELECT * FROM webuser, registry
	WHERE webuserid=@WebUserID
	AND webuser.RegistryID *= registry.ID

END




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

